
# Vou criar o script de setup completo do projeto
setup_script = """#!/bin/bash
# Script de setup do projeto Stardew App

# Criar estrutura de pastas seguindo clean architecture
mkdir -p lib/core/theme
mkdir -p lib/features/contacts/data/models
mkdir -p lib/features/contacts/data/repositories
mkdir -p lib/features/contacts/domain/entities
mkdir -p lib/features/contacts/domain/repositories
mkdir -p lib/features/contacts/presentation/pages
mkdir -p lib/features/contacts/presentation/widgets
mkdir -p lib/features/contacts/presentation/providers

echo "Estrutura criada com sucesso!"
"""

print(setup_script)
