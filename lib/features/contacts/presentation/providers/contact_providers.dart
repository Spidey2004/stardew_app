import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import '../../domain/entities/contact.dart';
import '../../domain/repositories/contact_repository.dart';
import '../../data/repositories/contact_repository_impl.dart';

// Provider do Isar
final isarProvider = FutureProvider<Isar>((ref) async {
  final dir = await getApplicationDocumentsDirectory();
  return await Isar.open(
    [ContactSchema],
    directory: dir.path,
  );
});

// Provider do Repository
final contactRepositoryProvider = Provider<ContactRepository>((ref) {
  final isar = ref.watch(isarProvider).value;
  if (isar == null) {
    throw Exception('Isar not initialized');
  }
  return ContactRepositoryImpl(isar);
});

// Provider da lista de contatos
final contactsProvider = StreamProvider<List<Contact>>((ref) async* {
  final isar = await ref.watch(isarProvider.future);
  yield* isar.contacts.where().watch(fireImmediately: true);
});

// Provider para contato selecionado
final selectedContactProvider = StateProvider<Contact?>((ref) => null);
