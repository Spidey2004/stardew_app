
# 11. Main.dart
main_dart = """import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/theme/app_theme.dart';
import 'features/contacts/presentation/pages/contacts_list_page.dart';

void main() {
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Relationship Manager',
      theme: AppTheme.theme,
      debugShowCheckedModeBanner: false,
      home: const ContactsListPage(),
    );
  }
}
"""

# 12. Script completo de build
build_script = """#!/bin/bash
# Script completo de build para Windows

echo "🚀 Iniciando build do Relationship Manager..."

# Cores para output
GREEN='\\033[0;32m'
BLUE='\\033[0;34m'
NC='\\033[0m' # No Color

# 1. Limpar build anterior
echo "${BLUE}📦 Limpando builds anteriores...${NC}"
flutter clean

# 2. Obter dependências
echo "${BLUE}📥 Baixando dependências...${NC}"
flutter pub get

# 3. Gerar código do Isar
echo "${BLUE}⚙️  Gerando código do Isar (isso pode demorar)...${NC}"
dart run build_runner build --delete-conflicting-outputs

# 4. Build para Windows
echo "${BLUE}🏗️  Compilando para Windows...${NC}"
flutter build windows --release

# 5. Criar pasta de distribuição
echo "${BLUE}📁 Criando pasta de distribuição...${NC}"
mkdir -p dist
cp -r build/windows/x64/runner/Release/* dist/

# Verificar se o executável foi criado
if [ -f "dist/relationship_manager.exe" ]; then
    echo "${GREEN}✅ Build concluído com sucesso!${NC}"
    echo "${GREEN}📂 Executável disponível em: dist/relationship_manager.exe${NC}"
    echo ""
    echo "Para executar o app:"
    echo "  cd dist"
    echo "  ./relationship_manager.exe"
else
    echo "❌ Erro: Executável não foi criado"
    exit 1
fi
"""

# 13. Script rápido de desenvolvimento
dev_script = """#!/bin/bash
# Script de desenvolvimento rápido

echo "🔧 Modo desenvolvimento..."

# Gerar código do Isar se necessário
if [ ! -f "lib/features/contacts/domain/entities/contact.g.dart" ]; then
    echo "⚙️  Gerando código do Isar..."
    dart run build_runner build --delete-conflicting-outputs
fi

# Rodar em modo debug
echo "🚀 Iniciando app em modo debug..."
flutter run -d windows
"""

# 14. README
readme = """# Relationship Manager

App inspirado no Stardew Valley para gerenciar relacionamentos pessoais.

## 🎮 Características

- **Sistema de Corações**: 5 corações (10 níveis) para medir proximidade
- **Controle de Presentes**: Marque presentes dados no mês atual
- **Editor de Notas**: Markdown editor para cada contato
- **Design Pixel Art**: Interface inspirada no Stardew Valley

## 🚀 Como Executar

### Primeira vez (Build completo):

```bash
chmod +x build.sh
./build.sh
```

O executável estará em `dist/relationship_manager.exe`

### Modo desenvolvimento:

```bash
chmod +x dev.sh
./dev.sh
```

## 🏗️ Arquitetura

O projeto segue Clean Architecture:

```
lib/
├── core/
│   └── theme/          # Tema da aplicação
├── features/
│   └── contacts/
│       ├── data/       # Implementações (Repository)
│       ├── domain/     # Entities e Interfaces
│       └── presentation/
│           ├── pages/  # Telas
│           ├── widgets/# Componentes reutilizáveis
│           └── providers/ # Estado (Riverpod)
```

## 📦 Tecnologias

- **Flutter**: Framework UI
- **Isar**: Banco de dados local NoSQL
- **Riverpod**: Gerenciamento de estado
- **Flutter Markdown**: Renderização de Markdown

## 🎯 Funcionalidades

### Tela Principal
- Lista de todos os contatos
- Visualização rápida de corações e presentes
- Botões +/- para ajustar proximidade
- Adicionar/Remover contatos

### Tela de Detalhes
- Informações completas do contato
- Editor de notas com Markdown
- Preview formatado das notas
- Controle de proximidade e presentes

## 📝 Uso do Markdown

No editor de notas, você pode usar:

```markdown
# Título Grande
## Subtítulo
### Seção

**Negrito**
*Itálico*

- Item 1
- Item 2
- Item 3

1. Primeiro
2. Segundo
```

## 🔄 Reset Automático de Presentes

O sistema detecta automaticamente mudança de mês e reseta os presentes dados.
"""

files4 = {
    "lib/main.dart": main_dart,
    "build.sh": build_script,
    "dev.sh": dev_script,
    "README.md": readme,
}

print("\nArquivos principais criados:")
for filename in files4.keys():
    print(f"  - {filename}")

print("\n" + "="*60)
print("📁 ESTRUTURA COMPLETA DO PROJETO")
print("="*60)
