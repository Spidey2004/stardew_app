import 'package:flutter/material.dart';
import '../models/villager.dart';
import 'villager_detailpage.dart';
import 'package:isar/isar.dart';

class VillagersPage extends StatefulWidget {
  const VillagersPage({super.key});

  @override
  State<VillagersPage> createState() => _VillagersPageState();
}

class _VillagersPageState extends State<VillagersPage> {
  late Stream<List<Villager>> _stream;

  @override
  void initState() {
    super.initState();
    _stream = isar.villagers.where().watch(fireImmediately: true);
  }

  Future<void> _addVillager() async {
    final controller = TextEditingController();
    final name = await showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Novo personagem'),
        content: TextField(controller: controller, decoration: const InputDecoration(labelText: 'Nome')),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancelar')),
          TextButton(onPressed: () => Navigator.pop(context, controller.text), child: const Text('OK')),
        ],
      ),
    );
    if (name != null && name.trim().isNotEmpty) {
      final v = Villager()..name = name.trim();
      await isar.writeTxn(() async {
        await isar.villagers.put(v);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Relacionamentos')),
      body: StreamBuilder<List<Villager>>(
        stream: _stream,
        builder: (context, snapshot) {
          final list = snapshot.data ?? [];
          if (list.isEmpty) return const Center(child: Text('Nenhum personagem ainda'));
          return ListView.builder(
            itemCount: list.length,
            itemBuilder: (context, index) {
              final v = list[index];
              return ListTile(
                title: Text(v.name),
                subtitle: Text('${v.hearts} coração(ões)'),
                trailing: Icon(Icons.favorite, color: v.hearts > 0 ? Colors.red : Colors.grey),
                onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => VillagerDetailPage(villagerId: v.id))),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(onPressed: _addVillager, child: const Icon(Icons.add)),
    );
  }
}
