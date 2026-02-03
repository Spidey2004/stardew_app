import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import '../../domain/entities/contact.dart';
import '../../domain/repositories/contact_repository.dart';
import '../../data/repositories/contact_repository_impl.dart';

// Provider do Isar
final isarProvider = FutureProvider<Isar>((ref) async {
  try {
    // Use app temporary directory instead of Documents (which might be on OneDrive)
    final dir = await getApplicationCacheDirectory();
    final dbPath = '${dir.path}/isar_db';
    
    // Ensure directory exists
    final dbDir = Directory(dbPath);
    if (!await dbDir.exists()) {
      await dbDir.create(recursive: true);
    }
    
    print('Opening Isar database at: $dbPath');
    
    return await Isar.open(
      [ContactSchema],
      directory: dbPath,
    );
  } catch (e) {
    print('Error opening Isar: $e');
    
    // Try one more time with a different path after a delay
    try {
      await Future.delayed(Duration(seconds: 1));
      final dir = await getApplicationSupportDirectory();
      final dbPath = '${dir.path}/isar_db';
      
      final dbDir = Directory(dbPath);
      if (!await dbDir.exists()) {
        await dbDir.create(recursive: true);
      }
      
      print('Retrying Isar at: $dbPath');
      return await Isar.open(
        [ContactSchema],
        directory: dbPath,
      );
    } catch (e2) {
      print('Second attempt failed: $e2');
      rethrow;
    }
  }
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
