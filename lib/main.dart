import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:isar_flutter_libs/isar_flutter_libs.dart';
import 'models/villager.dart';
import 'pages/villagers_page.dart';

late final Isar isar;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  isar = await Isar.open([
    VillagerSchema,
  ], inspector: true, libraries: getEmbeddedIsarLibraries());

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Stardew Relacionamentos',
      theme: ThemeData.light(),
      home: const VillagersPage(),
    );
  }
}
