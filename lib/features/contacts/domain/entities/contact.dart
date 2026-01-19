import 'package:isar/isar.dart';

part 'contact.g.dart';

@collection
class Contact {
  Id id = Isar.autoIncrement;
  
  late String name;
  
  // Proximidade: 0 a 10 (2 corações cheios = 10 níveis)
  @Index()
  late int proximityLevel;
  
  // Presentes dados no mês atual
  late bool giftGivenThisMonth;
  
  // Mês de referência para controle de presentes
  late String currentMonth; // formato: "2026-01"
  
  // Notas em markdown
  late String notes;
  
  // Data de criação
  late DateTime createdAt;
  
  // Data da última interação
  late DateTime lastInteraction;
  
  // Construtor padrão vazio para o Isar
  Contact();
  
  // Factory constructor para criar com valores
  factory Contact.create({
    required String name,
    int proximityLevel = 0,
    bool giftGivenThisMonth = false,
    String? currentMonth,
    String notes = '',
    DateTime? createdAt,
    DateTime? lastInteraction,
  }) {
    final contact = Contact();
    contact.name = name;
    contact.proximityLevel = proximityLevel;
    contact.giftGivenThisMonth = giftGivenThisMonth;
    contact.currentMonth = currentMonth ?? _getCurrentMonth();
    contact.notes = notes;
    contact.createdAt = createdAt ?? DateTime.now();
    contact.lastInteraction = lastInteraction ?? DateTime.now();
    return contact;
  }
  
  static String _getCurrentMonth() {
    final now = DateTime.now();
    return '${now.year}-${now.month.toString().padLeft(2, '0')}';
  }
  
  // Verifica e reseta presente se mudou o mês
  void checkAndResetGift() {
    final currentMonthStr = _getCurrentMonth();
    if (currentMonth != currentMonthStr) {
      currentMonth = currentMonthStr;
      giftGivenThisMonth = false;
    }
  }
  
  // Calcula quantos corações estão completos (máximo 5)
  int get fullHearts => (proximityLevel / 2).floor();
  
  // Verifica se tem meio coração
  bool get hasHalfHeart => proximityLevel % 2 == 1;
}
