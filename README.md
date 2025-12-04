# 🚁 Drones Antimisiles - Sistema de Defensa con IA

Sistema crítico de defensa basado en drones autónomos con algoritmos de inteligencia artificial para detección y neutralización de amenazas.

[![Backend CI](https://github.com/luhercentti/drones-ai-demo/workflows/Backend%20CI/badge.svg)](https://github.com/luhercentti/drones-ai-demo/actions)
[![Frontend CI](https://github.com/luhercentti/drones-ai-demo/workflows/Frontend%20CI/badge.svg)](https://github.com/luhercentti/drones-ai-demo/actions)
[![Python CI](https://github.com/luhercentti/drones-ai-demo/workflows/Python%20Services%20CI/badge.svg)](https://github.com/luhercentti/drones-ai-demo/actions)

---

## 📋 Tabla de Contenidos

- [Arquitectura del Proyecto](#-arquitectura-del-proyecto)
- [Requisitos Previos](#-requisitos-previos)
- [Setup Inicial](#-setup-inicial)
- [Flujo de Trabajo](#-flujo-de-trabajo)
- [CI/CD](#-cicd)
- [Integración con Shortcut](#-integración-con-shortcut)
- [Reglas de Protección](#-reglas-de-protección)
- [Testing](#-testing)
- [Scripts de Automatización](#-scripts-de-automatización)

---

## 🏗️ Arquitectura del Proyecto

```
drones-ai-demo/
├── backend/              # API REST en TypeScript (Node.js + Express)
│   ├── src/
│   │   ├── index.ts
│   │   └── utils/
│   ├── package.json
│   ├── tsconfig.json
│   ├── jest.config.js
│   └── .eslintrc.json
│
├── frontend/             # Interfaz de usuario en React + TypeScript
│   ├── src/
│   │   ├── components/
│   │   └── utils/
│   ├── package.json
│   ├── tsconfig.json
│   └── jest.config.js
│
├── python-services/      # Servicios de IA en Python
│   ├── src/
│   │   └── ai_controller.py
│   ├── tests/
│   ├── requirements.txt
│   └── pyproject.toml
│
├── .github/
│   ├── workflows/        # GitHub Actions CI/CD
│   │   ├── backend-ci.yml
│   │   ├── frontend-ci.yml
│   │   ├── python-ci.yml
│   │   └── shortcut-integration.yml
│   ├── CODEOWNERS        # Ownership por equipos
│   └── PULL_REQUEST_TEMPLATE.md
│
├── docs/                 # Documentación técnica
│   ├── BRANCH_PROTECTION_SETUP.md
│   ├── WORKFLOW_GUIDE.md
│   └── SHORTCUT_INTEGRATION.md
│
└── scripts/              # Scripts de automatización
    ├── setup.sh
    ├── validate-commit.sh
    └── run-all-tests.sh
```

---

## 🔧 Requisitos Previos

### Software necesario:

- **Node.js** >= 20.x
- **Python** >= 3.11
- **Git** >= 2.40
- **npm** >= 10.x
- **pip** >= 23.x

### Cuentas necesarias:

- Cuenta de **GitHub** con permisos de colaborador
- Cuenta de **Shortcut.com** para gestión de historias

---

## 🚀 Setup Inicial

### 1. Clonar el repositorio

```bash
# Hacer fork del repositorio principal
# Luego clonar tu fork
git clone https://github.com/TU_USUARIO/drones-ai-demo.git
cd drones-ai-demo
```

### 2. Configurar repositorio remoto

```bash
# Añadir el repositorio principal como upstream
git remote add upstream https://github.com/luhercentti/drones-ai-demo.git

# Verificar remotos
git remote -v
```

### 3. Instalar dependencias

```bash
# Ejecutar script de setup automático
chmod +x scripts/setup.sh
./scripts/setup.sh

# O manualmente:

# Backend
cd backend
npm install
cd ..

# Frontend
cd frontend
npm install
cd ..

# Python Services
cd python-services
python -m venv venv
source venv/bin/activate  # En Windows: venv\Scripts\activate
pip install -r requirements.txt
cd ..
```

### 4. Verificar instalación

```bash
# Ejecutar todos los tests
./scripts/run-all-tests.sh
```

---

## 🔄 Flujo de Trabajo

### Modelo: Fork + Pull Request

Este proyecto utiliza el **modelo de Fork y Pull Request**. Los desarrolladores NO pueden hacer push directo a `main` ni `develop`.

### Proceso paso a paso:

#### 1️⃣ Sincronizar tu fork

```bash
# Actualizar desde upstream
git fetch upstream
git checkout develop
git merge upstream/develop
git push origin develop
```

#### 2️⃣ Crear rama de feature

```bash
# Desde develop, crear rama de feature
git checkout develop
git pull upstream develop
git checkout -b feature/sc-1234-descripcion-corta
```

**Convención de nombres de ramas:**
- `feature/sc-XXXX-descripcion` - Nuevas funcionalidades
- `bugfix/sc-XXXX-descripcion` - Corrección de bugs
- `hotfix/sc-XXXX-descripcion` - Correcciones urgentes
- `refactor/sc-XXXX-descripcion` - Refactorización

#### 3️⃣ Desarrollar y hacer commits

```bash
# Hacer cambios y commit con formato correcto
git add .
git commit -m "[sc-1234] Añadir validación de coordenadas GPS"

# ⚠️ IMPORTANTE: Todos los commits deben seguir el formato [sc-XXXX]
```

#### 4️⃣ Push a tu fork

```bash
git push origin feature/sc-1234-descripcion-corta
```

#### 5️⃣ Crear Pull Request

1. Ve a GitHub → Tu fork → "Compare & pull request"
2. **Base repository:** `luhercentti/drones-ai-demo` base: `develop`
3. **Head repository:** `TU_USUARIO/drones-ai-demo` compare: `feature/sc-1234-descripcion-corta`
4. Completa el template de PR
5. Espera a que pasen todos los checks de CI/CD
6. Solicita revisión de Code Owners

#### 6️⃣ Proceso de Review

- Mínimo **1 aprobación** para merge a `develop`
- Mínimo **2 aprobaciones** para merge a `main`
- Todos los checks de CI/CD deben pasar (✅ verde)
- Cobertura de tests >= 70%
- Sin conflictos con la rama base

---

## 🤖 CI/CD

### Pipelines automáticos

El proyecto tiene **4 workflows de GitHub Actions**:

#### 1. Backend CI (`backend-ci.yml`)

Se ejecuta cuando hay cambios en `backend/**`

✅ Verifica:
- ESLint (calidad de código)
- Prettier (formato)
- Tests unitarios con Jest
- Cobertura >= 70%

#### 2. Frontend CI (`frontend-ci.yml`)

Se ejecuta cuando hay cambios en `frontend/**`

✅ Verifica:
- ESLint + React rules
- Prettier (formato)
- Tests unitarios con Jest + React Testing Library
- Cobertura >= 70%

#### 3. Python Services CI (`python-ci.yml`)

Se ejecuta cuando hay cambios en `python-services/**`

✅ Verifica:
- flake8 (linting)
- black (formato)
- pytest (tests)
- Cobertura >= 70%

#### 4. Shortcut Integration (`shortcut-integration.yml`)

Se ejecuta en TODOS los commits y PRs

✅ Verifica:
- Formato de commits: `[sc-XXXX] mensaje`
- Vincula commits a historias de Shortcut
- Publica comentarios automáticos en Shortcut

### ⛔ Bloqueo de Merge

El PR **NO podrá mergearse** si:
- ❌ Algún pipeline falla
- ❌ La cobertura es < 70%
- ❌ Hay errores de linting
- ❌ El código no está formateado
- ❌ Los commits no tienen formato `[sc-XXXX]`
- ❌ Faltan aprobaciones requeridas

---

## 🔗 Integración con Shortcut

### Configuración

#### 1. Obtener API Token

1. Ve a https://app.shortcut.com/settings/account/api-tokens
2. Crea un nuevo token: "GitHub Integration"
3. Copia el token

#### 2. Configurar Secret en GitHub

1. Ve a **Settings → Secrets and variables → Actions**
2. Click "New repository secret"
3. **Name:** `SHORTCUT_API_TOKEN`
4. **Value:** [tu token]

### Uso diario

#### Formato de commits

**Obligatorio:** Todos los commits deben incluir el ID de la historia de Shortcut:

```bash
# ✅ Correcto
git commit -m "[sc-1234] Implementar algoritmo de detección de amenazas"
git commit -m "[sc-5678] Corregir bug en cálculo de trayectorias"

# ❌ Incorrecto
git commit -m "Implementar algoritmo"
git commit -m "Fix bug"
```

#### Vinculación automática

Cuando haces push:
1. GitHub Actions extrae el ID de Shortcut del commit
2. Valida el formato
3. Publica un comentario automático en la historia de Shortcut con:
   - Link al commit en GitHub
   - Autor del commit
   - Branch
   - Mensaje del commit

#### Verificación

El workflow `shortcut-integration.yml` **bloqueará el PR** si algún commit no tiene el formato correcto.

---

## 🛡️ Reglas de Protección

### Branch Protection configurado para:

#### `main` (Producción)
- ✅ Requiere PR
- ✅ 2 aprobaciones mínimas
- ✅ Todos los checks de CI/CD deben pasar
- ✅ Review de Code Owners
- ✅ Commits firmados
- ✅ Historial lineal
- ❌ NO permite push directo (solo DevOps)

#### `develop` (Desarrollo)
- ✅ Requiere PR
- ✅ 1 aprobación mínima
- ✅ Todos los checks de CI/CD deben pasar
- ✅ Review de Code Owners
- ✅ Historial lineal

### CODEOWNERS

El archivo `.github/CODEOWNERS` define qué equipos deben aprobar cambios:

```
/backend/**           → @drones-ai-team/backend
/frontend/**          → @drones-ai-team/frontend
/python-services/**   → @drones-ai-team/backend @drones-ai-team/ai-team
/.github/workflows/** → @drones-ai-team/devops
```

**Ver detalles completos:** [`docs/BRANCH_PROTECTION_SETUP.md`](docs/BRANCH_PROTECTION_SETUP.md)

---

## 🧪 Testing

### Ejecutar tests localmente

#### Backend (TypeScript + Jest)

```bash
cd backend

# Tests
npm test

# Tests con cobertura
npm run test:ci

# Watch mode
npm test -- --watch

# Linting
npm run lint
npm run lint:fix

# Format check
npm run format:check
npm run format
```

#### Frontend (React + Jest)

```bash
cd frontend

# Tests
npm test

# Tests con cobertura
npm run test:ci

# Linting
npm run lint
npm run lint:fix
```

#### Python Services (pytest)

```bash
cd python-services
source venv/bin/activate

# Tests
pytest

# Tests con verbose
pytest -v

# Tests específicos
pytest tests/test_ai_controller.py

# Linting
flake8 src/ tests/

# Format
black src/ tests/
black --check src/ tests/
```

### Cobertura mínima requerida

**70%** en todas las métricas:
- ✅ Statements: 70%
- ✅ Branches: 70%
- ✅ Functions: 70%
- ✅ Lines: 70%

Los pipelines de CI/CD **fallarán** si la cobertura es inferior.

---

## 📜 Scripts de Automatización

### `scripts/setup.sh`

Instala todas las dependencias del proyecto:

```bash
./scripts/setup.sh
```

### `scripts/validate-commit.sh`

Valida el formato de mensaje de commit localmente:

```bash
./scripts/validate-commit.sh "[sc-1234] Mi mensaje"
```

### `scripts/run-all-tests.sh`

Ejecuta todos los tests del proyecto:

```bash
./scripts/run-all-tests.sh
```

---

## 📚 Documentación Adicional

- **[Branch Protection Setup](docs/BRANCH_PROTECTION_SETUP.md)** - Configuración detallada de protección de ramas
- **[Workflow Guide](docs/WORKFLOW_GUIDE.md)** - Guía completa del flujo de trabajo
- **[Shortcut Integration](docs/SHORTCUT_INTEGRATION.md)** - Detalles de integración con Shortcut

---

## 👥 Equipos

### Backend Team
- Responsable de: API REST, servicios backend, base de datos
- Tech stack: TypeScript, Node.js, Express

### Frontend Team
- Responsable de: Interfaz de usuario, componentes React
- Tech stack: TypeScript, React, Testing Library

### AI/ML Team
- Responsable de: Algoritmos de IA, modelos de ML
- Tech stack: Python, TensorFlow/PyTorch

### DevOps Team
- Responsable de: CI/CD, infraestructura, deployment
- Tech stack: GitHub Actions, Docker, Kubernetes

---

## 📞 Soporte

Para preguntas o problemas:

1. Revisa la documentación en `/docs`
2. Busca en los issues existentes
3. Crea un nuevo issue si es necesario
4. Contacta al equipo DevOps

---

## 📄 Licencia

MIT License - Ver archivo `LICENSE` para más detalles

---

## 🎯 Contribuir

Lee nuestra [guía de flujo de trabajo](docs/WORKFLOW_GUIDE.md) para contribuir al proyecto.

**Recuerda:**
- ✅ Siempre trabajar desde un fork
- ✅ Usar el formato de commits `[sc-XXXX]`
- ✅ Mantener cobertura >= 70%
- ✅ Pasar todos los checks de CI/CD
- ✅ Solicitar review de Code Owners

---

**¡Gracias por contribuir a Drones Antimisiles! 🚁🛡️**
