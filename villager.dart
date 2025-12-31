import 'package:isar/isar.dart';

part 'villager.g.dart';

@collection
class Villager {
  Id id = Isar.autoIncrement;

  late String name;
  int hearts = 0;           // 0–10
  bool giftedToday = false; // presente marcado
  String notes = '';        // anotações
}
