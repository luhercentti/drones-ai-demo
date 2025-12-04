#!/bin/bash

# Pre-commit hook para validar formato de commit
# Instalar: cp scripts/pre-commit.sh .git/hooks/pre-commit

set -e

# Colores
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

echo "🔍 Validando commit..."

# Obtener el mensaje del commit
COMMIT_MSG_FILE=$1
COMMIT_MSG=$(cat "$COMMIT_MSG_FILE")

# Patrón requerido: [sc-XXXX] Mensaje
PATTERN='^\[sc-[0-9]+\] .+'

if [[ $COMMIT_MSG =~ $PATTERN ]]; then
    echo -e "${GREEN}✓${NC} Formato de commit válido"
    exit 0
else
    echo -e "${RED}✗${NC} Formato de commit inválido"
    echo ""
    echo "El mensaje debe seguir el formato:"
    echo "  [sc-XXXX] Descripción del cambio"
    echo ""
    echo "Tu mensaje: $COMMIT_MSG"
    echo ""
    echo "Para validar antes de commit:"
    echo "  ./scripts/validate-commit.sh \"[sc-1234] Tu mensaje\""
    exit 1
fi
