late Isar isar;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  isar = await Isar.open(
    [VillagerSchema],
    inspector: true,
  );

  runApp(const MyApp());
}
