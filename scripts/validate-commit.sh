#!/bin/bash

# Script para validar el formato de mensaje de commit
# Uso: ./scripts/validate-commit.sh "mensaje de commit"

set -e

# Colores
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

# Verificar que se pasó un argumento
if [ $# -eq 0 ]; then
    echo -e "${YELLOW}Uso:${NC} ./scripts/validate-commit.sh \"[sc-1234] Tu mensaje\""
    exit 1
fi

COMMIT_MSG="$1"

# Patrón requerido: [sc-XXXX] Mensaje
PATTERN='^\[sc-[0-9]+\] .+'

if [[ $COMMIT_MSG =~ $PATTERN ]]; then
    echo -e "${GREEN}✓${NC} Formato de commit válido: $COMMIT_MSG"
    
    # Extraer el número de historia
    STORY_ID=$(echo "$COMMIT_MSG" | grep -oP '\[sc-\K[0-9]+')
    echo -e "${GREEN}✓${NC} Story ID: sc-$STORY_ID"
    echo ""
    echo "Link a Shortcut: https://app.shortcut.com/story/$STORY_ID"
    exit 0
else
    echo -e "${RED}✗${NC} Formato de commit inválido"
    echo ""
    echo "El mensaje debe seguir el formato:"
    echo "  [sc-XXXX] Descripción del cambio"
    echo ""
    echo "Ejemplos válidos:"
    echo "  [sc-1234] Implementar validación de coordenadas GPS"
    echo "  [sc-5678] Corregir bug en DroneStatus component"
    echo "  [sc-9012] Refactorizar AIController"
    echo ""
    echo "Tu mensaje: $COMMIT_MSG"
    exit 1
fi
