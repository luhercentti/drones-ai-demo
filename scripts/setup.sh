#!/bin/bash

# Script de setup inicial para Drones Antimisiles
# Este script instala todas las dependencias del proyecto

set -e  # Exit on error

echo "🚁 Drones Antimisiles - Setup Script"
echo "======================================"
echo ""

# Colores para output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Función para logging
log_info() {
    echo -e "${GREEN}✓${NC} $1"
}

log_warn() {
    echo -e "${YELLOW}⚠${NC} $1"
}

log_error() {
    echo -e "${RED}✗${NC} $1"
}

# Verificar que estamos en el directorio correcto
if [ ! -f "README.md" ]; then
    log_error "Este script debe ejecutarse desde la raíz del proyecto"
    exit 1
fi

# Verificar Node.js
echo "Verificando Node.js..."
if ! command -v node &> /dev/null; then
    log_error "Node.js no está instalado. Por favor instala Node.js >= 20.x"
    exit 1
fi

NODE_VERSION=$(node -v | cut -d'v' -f2 | cut -d'.' -f1)
if [ "$NODE_VERSION" -lt 20 ]; then
    log_error "Node.js version $NODE_VERSION es muy antigua. Se requiere >= 20.x"
    exit 1
fi

log_info "Node.js $(node -v) encontrado"

# Verificar npm
if ! command -v npm &> /dev/null; then
    log_error "npm no está instalado"
    exit 1
fi

log_info "npm $(npm -v) encontrado"

# Verificar Python
echo ""
echo "Verificando Python..."
if ! command -v python3 &> /dev/null; then
    log_error "Python 3 no está instalado. Por favor instala Python >= 3.11"
    exit 1
fi

PYTHON_VERSION=$(python3 --version | cut -d' ' -f2 | cut -d'.' -f1,2)
log_info "Python $PYTHON_VERSION encontrado"

# Verificar pip
if ! command -v pip3 &> /dev/null; then
    log_error "pip3 no está instalado"
    exit 1
fi

log_info "pip $(pip3 --version | cut -d' ' -f2) encontrado"

# Instalar dependencias del Backend
echo ""
echo "📦 Instalando dependencias del Backend..."
cd backend

if [ ! -f "package.json" ]; then
    log_error "package.json no encontrado en backend/"
    exit 1
fi

npm install
log_info "Dependencias del Backend instaladas"

cd ..

# Instalar dependencias del Frontend
echo ""
echo "📦 Instalando dependencias del Frontend..."
cd frontend

if [ ! -f "package.json" ]; then
    log_error "package.json no encontrado en frontend/"
    exit 1
fi

npm install
log_info "Dependencias del Frontend instaladas"

cd ..

# Instalar dependencias de Python Services
echo ""
echo "🐍 Configurando Python Services..."
cd python-services

# Crear entorno virtual si no existe
if [ ! -d "venv" ]; then
    log_info "Creando entorno virtual de Python..."
    python3 -m venv venv
fi

# Activar entorno virtual
source venv/bin/activate

# Actualizar pip
pip install --upgrade pip > /dev/null 2>&1

# Instalar dependencias
log_info "Instalando dependencias de Python..."
pip install -r requirements.txt > /dev/null 2>&1

log_info "Dependencias de Python instaladas"

deactivate
cd ..

# Verificar Git
echo ""
echo "Verificando configuración de Git..."

if ! git rev-parse --git-dir > /dev/null 2>&1; then
    log_warn "No estás en un repositorio Git"
else
    log_info "Repositorio Git detectado"
    
    # Verificar remote upstream
    if ! git remote | grep -q "upstream"; then
        log_warn "Remote 'upstream' no configurado"
        echo ""
        echo "Para configurar upstream, ejecuta:"
        echo "  git remote add upstream https://github.com/luhercentti/drones-ai-demo.git"
    else
        log_info "Remote 'upstream' configurado"
    fi
fi

# Resumen final
echo ""
echo "======================================"
echo "✅ Setup completado exitosamente!"
echo "======================================"
echo ""
echo "Próximos pasos:"
echo ""
echo "1. Verificar que todo funciona:"
echo "   ./scripts/run-all-tests.sh"
echo ""
echo "2. Configurar Git (si no lo has hecho):"
echo "   git remote add upstream https://github.com/luhercentti/drones-ai-demo.git"
echo ""
echo "3. Leer la documentación:"
echo "   - README.md"
echo "   - docs/WORKFLOW_GUIDE.md"
echo "   - docs/SHORTCUT_INTEGRATION.md"
echo ""
echo "4. Crear tu primera rama:"
echo "   git checkout -b feature/sc-XXXX-descripcion"
echo ""
echo "¡Feliz coding! 🚁"
