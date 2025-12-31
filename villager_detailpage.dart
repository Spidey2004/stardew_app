class VillagerDetailPage extends StatefulWidget {
  final int villagerId;
  const VillagerDetailPage({super.key, required this.villagerId});

  @override
  State<VillagerDetailPage> createState() => _VillagerDetailPageState();
}

class _VillagerDetailPageState extends State<VillagerDetailPage> {
  Villager? villager;
  final _notesController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadVillager();
  }

  Future<void> _loadVillager() async {
    final v = await isar.villagers.get(widget.villagerId);
    if (v != null) {
      setState(() {
        villager = v;
        _notesController.text = v.notes;
      });
    }
  }

  Future<void> _updateVillager(void Function(Villager v) update) async {
    if (villager == null) return;
    final current = villager!;
    update(current);
    await isar.writeTxn(() async {
      await isar.villagers.put(current);
    });
    setState(() {
      villager = current;
    });
  }

  @override
  Widget build(BuildContext context) {
    final v = villager;
    if (v == null) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(title: Text(v.name)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Corações
            const Text('Corações'),
            const SizedBox(height: 8),
            Row(
              children: List.generate(10, (index) {
                final filled = index < v.hearts;
                return IconButton(
                  icon: Icon(
                    Icons.favorite,
                    color: filled ? Colors.red : Colors.grey,
                  ),
                  onPressed: () {
                    final newHearts = index + 1 == v.hearts ? index : index + 1;
                    _updateVillager((villager) {
                      villager.hearts = newHearts;
                    });
                  },
                );
              }),
            ),
            const SizedBox(height: 16),

            // Checkbox presente
            CheckboxListTile(
              title: const Text('Presente hoje'),
              value: v.giftedToday,
              onChanged: (value) {
                _updateVillager((villager) {
                  villager.giftedToday = value ?? false;
                });
              },
            ),
            const SizedBox(height: 16),

            // Anotações
            const Text('Anotações'),
            const SizedBox(height: 8),
            Expanded(
              child: TextField(
                controller: _notesController,
                maxLines: null,
                expands: true,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Escreva suas anotações...',
                ),
                onChanged: (text) {
                  _updateVillager((villager) {
                    villager.notes = text;
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
