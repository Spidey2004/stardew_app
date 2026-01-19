import 'package:flutter/material.dart';
import '../../domain/entities/contact.dart';
import 'package:stardew_app/core/theme/app_theme.dart';
import 'heart_indicator.dart';

class ContactListItem extends StatelessWidget {
  final Contact contact;
  final VoidCallback onTap;
  final VoidCallback onIncrementProximity;
  final VoidCallback onDecrementProximity;
  final VoidCallback onToggleGift;
  final VoidCallback? onDelete;
  
  const ContactListItem({
    Key? key,
    required this.contact,
    required this.onTap,
    required this.onIncrementProximity,
    required this.onDecrementProximity,
    required this.onToggleGift,
    this.onDelete,
  }) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    // Verifica e reseta presente se necessário
    contact.checkAndResetGift();
    
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Row(
            children: [
              // Nome
              Expanded(
                flex: 2,
                child: Text(
                  contact.name,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              
              SizedBox(width: 16),
              
              // Corações
              Expanded(
                flex: 3,
                child: HeartIndicator(
                  fullHearts: contact.fullHearts,
                  hasHalfHeart: contact.hasHalfHeart,
                  onIncrement: onIncrementProximity,
                  onDecrement: onDecrementProximity,
                ),
              ),
              
              SizedBox(width: 16),
              
              // Presente
              IconButton(
                icon: Icon(
                  Icons.card_giftcard,
                  color: contact.giftGivenThisMonth 
                    ? AppTheme.giftGreen 
                    : AppTheme.heartEmpty,
                  size: 28,
                ),
                onPressed: onToggleGift,
                tooltip: contact.giftGivenThisMonth 
                  ? 'Presente dado este mês' 
                  : 'Dar presente',
              ),
              
              // Deletar
              if (onDelete != null)
                IconButton(
                  icon: Icon(Icons.delete_outline, size: 20),
                  onPressed: onDelete,
                  tooltip: 'Excluir contato',
                ),
            ],
          ),
        ),
      ),
    );
  }
}