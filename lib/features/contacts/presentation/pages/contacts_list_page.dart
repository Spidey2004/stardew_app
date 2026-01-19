import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/contact.dart';
import '../providers/contact_providers.dart';
import '../widgets/contact_list_item.dart';
import 'contact_detail_page.dart';  


class ContactsListPage extends ConsumerStatefulWidget {
  const ContactsListPage({Key? key}) : super(key: key);

  @override
  ConsumerState<ContactsListPage> createState() => _ContactsListPageState();
}

class _ContactsListPageState extends ConsumerState<ContactsListPage> {
  final _nameController = TextEditingController();
  
  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }
  
  void _showAddContactDialog() {
    _nameController.clear();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Adicionar Contato', style: TextStyle(fontSize: 14)),
        content: TextField(
          controller: _nameController,
          decoration: InputDecoration(
            labelText: 'Nome',
            border: OutlineInputBorder(),
          ),
          autofocus: true,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () async {
              if (_nameController.text.trim().isNotEmpty) {
                final repository = ref.read(contactRepositoryProvider);
                await repository.addContact(
                  Contact.create(name: _nameController.text.trim()),
                );
                if (mounted) Navigator.pop(context);
              }
            },
            child: Text('Adicionar'),
          ),
        ],
      ),
    );
  }
  
  @override
  Widget build(BuildContext context) {
    final contactsAsync = ref.watch(contactsProvider);
    
    return Scaffold(
      appBar: AppBar(
        title: Text('Relacionamentos'),
      ),
      body: contactsAsync.when(
        data: (contacts) {
          if (contacts.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.people_outline, size: 64, color: Colors.grey),
                  SizedBox(height: 16),
                  Text(
                    'Nenhum contato ainda',
                    style: TextStyle(fontSize: 12),
                  ),
                  SizedBox(height: 8),
                  ElevatedButton.icon(
                    onPressed: _showAddContactDialog,
                    icon: Icon(Icons.add),
                    label: Text('Adicionar Primeiro Contato'),
                  ),
                ],
              ),
            );
          }
          
          return ListView.builder(
            padding: EdgeInsets.symmetric(vertical: 16),
            itemCount: contacts.length,
            itemBuilder: (context, index) {
              final contact = contacts[index];
              return ContactListItem(
                contact: contact,
                onTap: () {
                  ref.read(selectedContactProvider.notifier).state = contact;
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ContactDetailPage(contactId: contact.id),
                    ),
                  );
                },
                onIncrementProximity: () {
                  ref.read(contactRepositoryProvider).incrementProximity(contact.id);
                },
                onDecrementProximity: () {
                  ref.read(contactRepositoryProvider).decrementProximity(contact.id);
                },
                onToggleGift: () {
                  ref.read(contactRepositoryProvider).toggleGift(contact.id);
                },
                onDelete: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text('Confirmar exclusão', style: TextStyle(fontSize: 14)),
                      content: Text('Deseja excluir ${contact.name}?', style: TextStyle(fontSize: 12)),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: Text('Cancelar'),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            ref.read(contactRepositoryProvider).deleteContact(contact.id);
                            Navigator.pop(context);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                          ),
                          child: Text('Excluir'),
                        ),
                      ],
                    ),
                  );
                },
              );
            },
          );
        },
        loading: () => Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(
          child: Text('Erro: $error', style: TextStyle(fontSize: 12)),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddContactDialog,
        child: Icon(Icons.add),
        tooltip: 'Adicionar Contato',
      ),
    );
  }
}
