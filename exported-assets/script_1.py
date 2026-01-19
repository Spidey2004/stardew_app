
import json

# 1. pubspec.yaml
pubspec = """name: relationship_manager
description: App para gerenciar relacionamentos pessoais
publish_to: 'none'
version: 1.0.0+1

environment:
  sdk: '>=3.0.0 <4.0.0'

dependencies:
  flutter:
    sdk: flutter
  
  # State Management
  flutter_riverpod: ^2.4.9
  
  # Database
  isar: ^3.1.0+1
  isar_flutter_libs: ^3.1.0+1
  path_provider: ^2.1.1
  
  # Markdown Editor
  flutter_markdown: ^0.6.18
  markdown_editable_textinput: ^2.2.0
  
  # UI
  google_fonts: ^6.1.0

dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_lints: ^3.0.0
  isar_generator: ^3.1.0+1
  build_runner: ^2.4.7

flutter:
  uses-material-design: true
  assets:
    - assets/images/
"""

# 2. Contact Entity (Isar Model)
contact_model = """import 'package:isar/isar.dart';

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
  
  Contact({
    this.id = Isar.autoIncrement,
    required this.name,
    this.proximityLevel = 0,
    this.giftGivenThisMonth = false,
    String? currentMonth,
    this.notes = '',
    DateTime? createdAt,
    DateTime? lastInteraction,
  }) {
    this.currentMonth = currentMonth ?? _getCurrentMonth();
    this.createdAt = createdAt ?? DateTime.now();
    this.lastInteraction = lastInteraction ?? DateTime.now();
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
"""

# 3. Contact Repository Interface
contact_repository_interface = """import '../entities/contact.dart';

abstract class ContactRepository {
  Future<List<Contact>> getAllContacts();
  Future<Contact?> getContactById(int id);
  Future<void> addContact(Contact contact);
  Future<void> updateContact(Contact contact);
  Future<void> deleteContact(int id);
  Future<void> incrementProximity(int id);
  Future<void> decrementProximity(int id);
  Future<void> toggleGift(int id);
  Future<void> updateNotes(int id, String notes);
}
"""

# 4. Contact Repository Implementation
contact_repository_impl = """import 'package:isar/isar.dart';
import '../../domain/entities/contact.dart';
import '../../domain/repositories/contact_repository.dart';

class ContactRepositoryImpl implements ContactRepository {
  final Isar isar;
  
  ContactRepositoryImpl(this.isar);
  
  @override
  Future<List<Contact>> getAllContacts() async {
    return await isar.contacts.where().sortByName().findAll();
  }
  
  @override
  Future<Contact?> getContactById(int id) async {
    return await isar.contacts.get(id);
  }
  
  @override
  Future<void> addContact(Contact contact) async {
    await isar.writeTxn(() async {
      await isar.contacts.put(contact);
    });
  }
  
  @override
  Future<void> updateContact(Contact contact) async {
    await isar.writeTxn(() async {
      await isar.contacts.put(contact);
    });
  }
  
  @override
  Future<void> deleteContact(int id) async {
    await isar.writeTxn(() async {
      await isar.contacts.delete(id);
    });
  }
  
  @override
  Future<void> incrementProximity(int id) async {
    final contact = await getContactById(id);
    if (contact != null && contact.proximityLevel < 10) {
      contact.proximityLevel++;
      contact.lastInteraction = DateTime.now();
      await updateContact(contact);
    }
  }
  
  @override
  Future<void> decrementProximity(int id) async {
    final contact = await getContactById(id);
    if (contact != null && contact.proximityLevel > 0) {
      contact.proximityLevel--;
      contact.lastInteraction = DateTime.now();
      await updateContact(contact);
    }
  }
  
  @override
  Future<void> toggleGift(int id) async {
    final contact = await getContactById(id);
    if (contact != null) {
      contact.checkAndResetGift();
      contact.giftGivenThisMonth = !contact.giftGivenThisMonth;
      contact.lastInteraction = DateTime.now();
      await updateContact(contact);
    }
  }
  
  @override
  Future<void> updateNotes(int id, String notes) async {
    final contact = await getContactById(id);
    if (contact != null) {
      contact.notes = notes;
      contact.lastInteraction = DateTime.now();
      await updateContact(contact);
    }
  }
}
"""

files = {
    "pubspec.yaml": pubspec,
    "lib/features/contacts/domain/entities/contact.dart": contact_model,
    "lib/features/contacts/domain/repositories/contact_repository.dart": contact_repository_interface,
    "lib/features/contacts/data/repositories/contact_repository_impl.dart": contact_repository_impl,
}

print("Arquivos base criados:")
for filename in files.keys():
    print(f"  - {filename}")
