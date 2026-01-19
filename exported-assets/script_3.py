
# 9. Contacts List Page
contacts_page = """import 'package:flutter/material.dart';
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
                  Contact(name: _nameController.text.trim()),
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
"""

# 10. Contact Detail Page (com editor markdown)
detail_page = """import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import '../../domain/entities/contact.dart';
import '../providers/contact_providers.dart';
import '../widgets/heart_indicator.dart';
import '../../../../core/theme/app_theme.dart';

class ContactDetailPage extends ConsumerStatefulWidget {
  final int contactId;
  
  const ContactDetailPage({
    Key? key,
    required this.contactId,
  }) : super(key: key);

  @override
  ConsumerState<ContactDetailPage> createState() => _ContactDetailPageState();
}

class _ContactDetailPageState extends ConsumerState<ContactDetailPage> {
  late TextEditingController _notesController;
  bool _isEditing = false;
  Contact? _contact;
  
  @override
  void initState() {
    super.initState();
    _notesController = TextEditingController();
    _loadContact();
  }
  
  Future<void> _loadContact() async {
    final repository = ref.read(contactRepositoryProvider);
    final contact = await repository.getContactById(widget.contactId);
    if (contact != null) {
      setState(() {
        _contact = contact;
        _notesController.text = contact.notes;
      });
    }
  }
  
  @override
  void dispose() {
    _notesController.dispose();
    super.dispose();
  }
  
  Future<void> _saveNotes() async {
    if (_contact != null) {
      final repository = ref.read(contactRepositoryProvider);
      await repository.updateNotes(widget.contactId, _notesController.text);
      setState(() {
        _isEditing = false;
      });
      await _loadContact();
    }
  }
  
  @override
  Widget build(BuildContext context) {
    if (_contact == null) {
      return Scaffold(
        appBar: AppBar(title: Text('Carregando...')),
        body: Center(child: CircularProgressIndicator()),
      );
    }
    
    return Scaffold(
      appBar: AppBar(
        title: Text(_contact!.name),
        actions: [
          if (_isEditing)
            IconButton(
              icon: Icon(Icons.save),
              onPressed: _saveNotes,
              tooltip: 'Salvar',
            )
          else
            IconButton(
              icon: Icon(Icons.edit),
              onPressed: () {
                setState(() {
                  _isEditing = true;
                });
              },
              tooltip: 'Editar',
            ),
        ],
      ),
      body: Column(
        children: [
          // Header com informações do contato
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                bottom: BorderSide(color: AppTheme.woodBorder, width: 3),
              ),
            ),
            child: Column(
              children: [
                // Avatar
                CircleAvatar(
                  radius: 40,
                  backgroundColor: AppTheme.primaryBrown,
                  child: Text(
                    _contact!.name[0].toUpperCase(),
                    style: TextStyle(
                      fontSize: 32,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 16),
                
                // Nome
                Text(
                  _contact!.name,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                SizedBox(height: 16),
                
                // Corações
                HeartIndicator(
                  fullHearts: _contact!.fullHearts,
                  hasHalfHeart: _contact!.hasHalfHeart,
                  onIncrement: () async {
                    await ref.read(contactRepositoryProvider)
                      .incrementProximity(widget.contactId);
                    await _loadContact();
                  },
                  onDecrement: () async {
                    await ref.read(contactRepositoryProvider)
                      .decrementProximity(widget.contactId);
                    await _loadContact();
                  },
                ),
                SizedBox(height: 16),
                
                // Presente
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.card_giftcard,
                      color: _contact!.giftGivenThisMonth 
                        ? AppTheme.giftGreen 
                        : AppTheme.heartEmpty,
                    ),
                    SizedBox(width: 8),
                    Text(
                      _contact!.giftGivenThisMonth 
                        ? 'Presente dado este mês' 
                        : 'Sem presente este mês',
                      style: TextStyle(fontSize: 11),
                    ),
                    SizedBox(width: 8),
                    ElevatedButton(
                      onPressed: () async {
                        await ref.read(contactRepositoryProvider)
                          .toggleGift(widget.contactId);
                        await _loadContact();
                      },
                      child: Text(
                        _contact!.giftGivenThisMonth ? 'Remover' : 'Dar Presente',
                        style: TextStyle(fontSize: 10),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          
          // Área de notas
          Expanded(
            child: _isEditing ? _buildEditor() : _buildMarkdownPreview(),
          ),
        ],
      ),
    );
  }
  
  Widget _buildEditor() {
    return Container(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Notas (Markdown)',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          SizedBox(height: 8),
          Expanded(
            child: TextField(
              controller: _notesController,
              maxLines: null,
              expands: true,
              decoration: InputDecoration(
                hintText: 'Use Markdown para formatar suas notas...\\n\\n'
                    '# Título\\n## Subtítulo\\n- Item de lista\\n**Negrito**',
                border: OutlineInputBorder(),
                filled: true,
                fillColor: Colors.white,
              ),
              style: TextStyle(fontSize: 12, fontFamily: 'Courier'),
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildMarkdownPreview() {
    return Container(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Notas',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              Text(
                'Clique em editar para modificar',
                style: TextStyle(fontSize: 9, color: Colors.grey),
              ),
            ],
          ),
          SizedBox(height: 8),
          Expanded(
            child: _contact!.notes.isEmpty
              ? Center(
                  child: Text(
                    'Sem notas ainda.\\nClique em editar para adicionar.',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.grey, fontSize: 11),
                  ),
                )
              : Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: AppTheme.woodBorder, width: 2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Markdown(
                    data: _contact!.notes,
                    styleSheet: MarkdownStyleSheet(
                      p: TextStyle(fontSize: 12),
                      h1: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      h2: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      h3: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
          ),
        ],
      ),
    );
  }
}
"""

files3 = {
    "lib/features/contacts/presentation/pages/contacts_list_page.dart": contacts_page,
    "lib/features/contacts/presentation/pages/contact_detail_page.dart": detail_page,
}

print("\nArquivos de páginas criados:")
for filename in files3.keys():
    print(f"  - {filename}")
