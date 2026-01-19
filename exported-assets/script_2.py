
# 5. Providers (Riverpod)
providers = """import 'package:flutter_riverpod/flutter_riverpod.dart';
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
"""

# 6. Theme
theme = """import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // Cores inspiradas no Stardew Valley
  static const Color primaryBrown = Color(0xFF8B5A3C);
  static const Color lightBrown = Color(0xFFD4A574);
  static const Color darkBrown = Color(0xFF5C3A21);
  static const Color creamBackground = Color(0xFFFFF8DC);
  static const Color woodBorder = Color(0xFF6B4423);
  static const Color heartRed = Color(0xFFE74C3C);
  static const Color heartEmpty = Color(0xFFBDC3C7);
  static const Color giftGreen = Color(0xFF27AE60);
  
  static ThemeData get theme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.light(
        primary: primaryBrown,
        secondary: lightBrown,
        surface: creamBackground,
        background: creamBackground,
      ),
      scaffoldBackgroundColor: creamBackground,
      textTheme: GoogleFonts.pressStart2pTextTheme().apply(
        bodyColor: darkBrown,
        displayColor: darkBrown,
      ),
      cardTheme: CardTheme(
        color: Colors.white,
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          side: BorderSide(color: woodBorder, width: 3),
        ),
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: primaryBrown,
        foregroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: GoogleFonts.pressStart2p(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
"""

# 7. Heart Widget
heart_widget = """import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';

class HeartIndicator extends StatelessWidget {
  final int fullHearts;
  final bool hasHalfHeart;
  final int maxHearts;
  final VoidCallback? onIncrement;
  final VoidCallback? onDecrement;
  
  const HeartIndicator({
    Key? key,
    required this.fullHearts,
    this.hasHalfHeart = false,
    this.maxHearts = 5,
    this.onIncrement,
    this.onDecrement,
  }) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (onDecrement != null)
          IconButton(
            icon: Icon(Icons.remove_circle_outline, size: 20),
            onPressed: onDecrement,
            padding: EdgeInsets.zero,
            constraints: BoxConstraints(),
          ),
        SizedBox(width: 8),
        ...List.generate(maxHearts, (index) {
          if (index < fullHearts) {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 2),
              child: Icon(
                Icons.favorite,
                color: AppTheme.heartRed,
                size: 24,
              ),
            );
          } else if (index == fullHearts && hasHalfHeart) {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 2),
              child: Icon(
                Icons.favorite_half,
                color: AppTheme.heartRed,
                size: 24,
              ),
            );
          } else {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 2),
              child: Icon(
                Icons.favorite_border,
                color: AppTheme.heartEmpty,
                size: 24,
              ),
            );
          }
        }),
        SizedBox(width: 8),
        if (onIncrement != null)
          IconButton(
            icon: Icon(Icons.add_circle_outline, size: 20),
            onPressed: onIncrement,
            padding: EdgeInsets.zero,
            constraints: BoxConstraints(),
          ),
      ],
    );
  }
}
"""

# 8. Contact List Item Widget
contact_item = """import 'package:flutter/material.dart';
import '../../domain/entities/contact.dart';
import '../../../core/theme/app_theme.dart';
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
"""

files2 = {
    "lib/features/contacts/presentation/providers/contact_providers.dart": providers,
    "lib/core/theme/app_theme.dart": theme,
    "lib/features/contacts/presentation/widgets/heart_indicator.dart": heart_widget,
    "lib/features/contacts/presentation/widgets/contact_list_item.dart": contact_item,
}

print("\nArquivos de UI criados:")
for filename in files2.keys():
    print(f"  - {filename}")
