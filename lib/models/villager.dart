import 'package:isar/isar.dart';

part 'villager.g.dart';

@Collection()
class Villager {
  Id id = Isar.autoIncrement;

  late String name;
  int hearts = 0; // 0–10
  bool giftedToday = false;
  String notes = '';

  Villager();
}
