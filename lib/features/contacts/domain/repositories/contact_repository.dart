import '../entities/contact.dart';

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
