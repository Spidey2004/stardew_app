class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Stardew Relacionamentos',
      theme: ThemeData.dark(),
      home: const VillagersPage(),
    );
  }
}

class VillagersPage extends StatefulWidget {
  const VillagersPage({super.key});

  @override
  State<VillagersPage> createState() => _VillagersPageState();
}

class _VillagersPageState extends State<VillagersPage> {
  late Stream<List<Villager>> _villagersStream;

  @override
  void initState() {
    super.initState();
    _villagersStream = isar.villagers.where().watch(fireImmediately: true);
  }

  Future<void> _addVillager() async {
    final controller = TextEditingController();
    final name = await showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Novo personagem'),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(labelText: 'Nome'),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancelar')),
          TextButton(onPressed: () => Navigator.pop(context, controller.text), child: const Text('OK')),
        ],
      ),
    );
    if (name != null && name.trim().isNotEmpty) {
      final villager = Villager()..name = name.trim();
      await isar.writeTxn(() => isar.villagers.put(villager));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Relacionamentos')),
      body: StreamBuilder<List<Villager>>(
        stream: _villagersStream,
        builder: (context, snapshot) {
          final villagers = snapshot.data ?? [];
          if (villagers.isEmpty) {
            return const Center(child: Text('Nenhum personagem ainda'));
          }
          return ListView.builder(
            itemCount: villagers.length,
            itemBuilder: (context, index) {
              final v = villagers[index];
              return ListTile(
                title: Text(v.name),
                subtitle: Text('${v.hearts} coração(ões)'),
                trailing: Icon(
                  Icons.favorite,
                  color: v.hearts > 0 ? Colors.red : Colors.grey,
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => VillagerDetailPage(villagerId: v.id),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addVillager,
        child: const Icon(Icons.add),
      ),
    );
  }
}
