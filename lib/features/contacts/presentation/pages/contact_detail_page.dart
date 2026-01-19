import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_markdown_plus/flutter_markdown_plus.dart';
import '../../domain/entities/contact.dart';
import '../providers/contact_providers.dart';
import '../widgets/heart_indicator.dart';
import '../../../../core/theme/app_theme.dart';

class ContactDetailPage extends ConsumerStatefulWidget {
  final int contactId;
  
  const ContactDetailPage({
    super.key,
    required this.contactId,
  });

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
                hintText: 'Use Markdown para formatar suas notas...\n\n'
                    '# Título\n## Subtítulo\n- Item de lista\n**Negrito**',
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
                    'Sem notas ainda.\nClique em editar para adicionar.',
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
