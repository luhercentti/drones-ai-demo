#!/bin/bash

# Script para ejecutar todos los tests del proyecto
# Verifica backend, frontend, y python services

set -e

# Colores
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

echo -e "${BLUE}🧪 Drones Antimisiles - Test Suite${NC}"
echo "======================================"
echo ""

# Función para logging
log_info() {
    echo -e "${GREEN}✓${NC} $1"
}

log_error() {
    echo -e "${RED}✗${NC} $1"
}

log_section() {
    echo ""
    echo -e "${BLUE}▶ $1${NC}"
    echo "--------------------------------------"
}

# Verificar que estamos en el directorio correcto
if [ ! -f "README.md" ]; then
    log_error "Este script debe ejecutarse desde la raíz del proyecto"
    exit 1
fi

# Variables para tracking
BACKEND_PASSED=0
FRONTEND_PASSED=0
PYTHON_PASSED=0

# ============================================
# BACKEND TESTS
# ============================================
log_section "Backend Tests (TypeScript + Jest)"

cd backend

# Verificar que node_modules existe
if [ ! -d "node_modules" ]; then
    log_error "Dependencias del backend no instaladas. Ejecuta: npm install"
    cd ..
    exit 1
fi

# Ejecutar linter
echo "Running ESLint..."
if npm run lint > /dev/null 2>&1; then
    log_info "ESLint passed"
else
    log_error "ESLint failed"
    npm run lint
    cd ..
    exit 1
fi

# Verificar formato
echo "Checking Prettier..."
if npm run format:check > /dev/null 2>&1; then
    log_info "Prettier check passed"
else
    log_error "Prettier check failed"
    npm run format:check
    cd ..
    exit 1
fi

# Ejecutar tests con coverage
echo "Running Jest tests..."
if npm run test:ci > /dev/null 2>&1; then
    log_info "Backend tests passed"
    BACKEND_PASSED=1
    
    # Mostrar coverage
    if [ -f "coverage/coverage-summary.json" ]; then
        COVERAGE=$(node -e "const fs = require('fs'); const coverage = JSON.parse(fs.readFileSync('coverage/coverage-summary.json', 'utf8')); const total = coverage.total; console.log(Math.min(total.lines.pct, total.statements.pct, total.functions.pct, total.branches.pct).toFixed(2));")
        log_info "Backend coverage: ${COVERAGE}%"
        
        if (( $(echo "$COVERAGE < 70" | bc -l) )); then
            log_error "Coverage is below 70%"
            BACKEND_PASSED=0
        fi
    fi
else
    log_error "Backend tests failed"
    npm run test:ci
    cd ..
    exit 1
fi

cd ..

# ============================================
# FRONTEND TESTS
# ============================================
log_section "Frontend Tests (React + Jest)"

cd frontend

# Verificar que node_modules existe
if [ ! -d "node_modules" ]; then
    log_error "Dependencias del frontend no instaladas. Ejecuta: npm install"
    cd ..
    exit 1
fi

# Ejecutar linter
echo "Running ESLint..."
if npm run lint > /dev/null 2>&1; then
    log_info "ESLint passed"
else
    log_error "ESLint failed"
    npm run lint
    cd ..
    exit 1
fi

# Verificar formato
echo "Checking Prettier..."
if npm run format:check > /dev/null 2>&1; then
    log_info "Prettier check passed"
else
    log_error "Prettier check failed"
    npm run format:check
    cd ..
    exit 1
fi

# Ejecutar tests con coverage
echo "Running Jest tests..."
if npm run test:ci > /dev/null 2>&1; then
    log_info "Frontend tests passed"
    FRONTEND_PASSED=1
    
    # Mostrar coverage
    if [ -f "coverage/coverage-summary.json" ]; then
        COVERAGE=$(node -e "const fs = require('fs'); const coverage = JSON.parse(fs.readFileSync('coverage/coverage-summary.json', 'utf8')); const total = coverage.total; console.log(Math.min(total.lines.pct, total.statements.pct, total.functions.pct, total.branches.pct).toFixed(2));")
        log_info "Frontend coverage: ${COVERAGE}%"
        
        if (( $(echo "$COVERAGE < 70" | bc -l) )); then
            log_error "Coverage is below 70%"
            FRONTEND_PASSED=0
        fi
    fi
else
    log_error "Frontend tests failed"
    npm run test:ci
    cd ..
    exit 1
fi

cd ..

# ============================================
# PYTHON TESTS
# ============================================
log_section "Python Services Tests (pytest)"

cd python-services

# Verificar que venv existe
if [ ! -d "venv" ]; then
    log_error "Entorno virtual de Python no existe. Ejecuta: ./scripts/setup.sh"
    cd ..
    exit 1
fi

# Activar entorno virtual
source venv/bin/activate

# Ejecutar flake8
echo "Running flake8..."
if flake8 src/ tests/ > /dev/null 2>&1; then
    log_info "flake8 passed"
else
    log_error "flake8 failed"
    flake8 src/ tests/
    deactivate
    cd ..
    exit 1
fi

# Verificar formato con black
echo "Checking black..."
if black --check src/ tests/ > /dev/null 2>&1; then
    log_info "black check passed"
else
    log_error "black check failed"
    black --check src/ tests/
    deactivate
    cd ..
    exit 1
fi

# Ejecutar tests con coverage
echo "Running pytest..."
if pytest > /dev/null 2>&1; then
    log_info "Python tests passed"
    PYTHON_PASSED=1
    
    # Mostrar coverage
    COVERAGE=$(python -c "import json; data = json.load(open('.coverage')); print(f\"{data.get('totals', {}).get('percent_covered', 0):.2f}\")" 2>/dev/null || echo "N/A")
    if [ "$COVERAGE" != "N/A" ]; then
        log_info "Python coverage: ${COVERAGE}%"
        
        if (( $(echo "$COVERAGE < 70" | bc -l) )); then
            log_error "Coverage is below 70%"
            PYTHON_PASSED=0
        fi
    fi
else
    log_error "Python tests failed"
    pytest -v
    deactivate
    cd ..
    exit 1
fi

deactivate
cd ..

# ============================================
# RESUMEN
# ============================================
echo ""
echo "======================================"
echo -e "${BLUE}Test Results Summary${NC}"
echo "======================================"
echo ""

if [ $BACKEND_PASSED -eq 1 ]; then
    echo -e "Backend:  ${GREEN}✓ PASSED${NC}"
else
    echo -e "Backend:  ${RED}✗ FAILED${NC}"
fi

if [ $FRONTEND_PASSED -eq 1 ]; then
    echo -e "Frontend: ${GREEN}✓ PASSED${NC}"
else
    echo -e "Frontend: ${RED}✗ FAILED${NC}"
fi

if [ $PYTHON_PASSED -eq 1 ]; then
    echo -e "Python:   ${GREEN}✓ PASSED${NC}"
else
    echo -e "Python:   ${RED}✗ FAILED${NC}"
fi

echo ""

if [ $BACKEND_PASSED -eq 1 ] && [ $FRONTEND_PASSED -eq 1 ] && [ $PYTHON_PASSED -eq 1 ]; then
    echo -e "${GREEN}✅ All tests passed! Ready to push.${NC}"
    exit 0
else
    echo -e "${RED}❌ Some tests failed. Please fix before pushing.${NC}"
    exit 1
fi
