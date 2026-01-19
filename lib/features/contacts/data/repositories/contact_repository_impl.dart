import 'package:isar/isar.dart';
import '../../domain/entities/contact.dart';
import '../../domain/repositories/contact_repository.dart';

class ContactRepositoryImpl implements ContactRepository {
  final Isar isar;
  
  ContactRepositoryImpl(this.isar);
  
  @override
  Future<List<Contact>> getAllContacts() async {
    return await isar.contacts.where().findAll()..sort((a, b) => a.name.compareTo(b.name));
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
