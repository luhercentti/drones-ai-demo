## Configuración de Branch Protection Rules

Para configurar las reglas de protección de ramas en GitHub, sigue estos pasos:

### 1. Configuración para la rama `main`

Ve a: **Settings → Branches → Add branch protection rule**

#### Configuración requerida:

**Branch name pattern:** `main`

✅ **Require a pull request before merging**
  - ✅ Require approvals: **2**
  - ✅ Dismiss stale pull request approvals when new commits are pushed
  - ✅ Require review from Code Owners

✅ **Require status checks to pass before merging**
  - ✅ Require branches to be up to date before merging
  - **Status checks required:**
    - `Backend Lint & Test`
    - `Frontend Lint & Test`
    - `Python Lint & Test`
    - `Link commits to Shortcut stories`

✅ **Require conversation resolution before merging**

✅ **Require signed commits**

✅ **Require linear history**

✅ **Do not allow bypassing the above settings**

✅ **Restrict who can push to matching branches**
  - Solo: `@drones-ai-team/devops`

---

### 2. Configuración para la rama `develop`

**Branch name pattern:** `develop`

✅ **Require a pull request before merging**
  - ✅ Require approvals: **1**
  - ✅ Dismiss stale pull request approvals when new commits are pushed
  - ✅ Require review from Code Owners

✅ **Require status checks to pass before merging**
  - ✅ Require branches to be up to date before merging
  - **Status checks required:**
    - `Backend Lint & Test`
    - `Frontend Lint & Test`
    - `Python Lint & Test`
    - `Link commits to Shortcut stories`

✅ **Require conversation resolution before merging**

✅ **Require linear history**

---

### 3. Configuración para ramas de feature

**Branch name pattern:** `feature/*`

✅ **Require a pull request before merging**
  - ✅ Require approvals: **1**

✅ **Require status checks to pass before merging**
  - **Status checks required:**
    - `Backend Lint & Test` (si aplica)
    - `Frontend Lint & Test` (si aplica)
    - `Python Lint & Test` (si aplica)

---

### 4. Configuración adicional del repositorio

#### Configurar Fork & Pull Request workflow

Ve a: **Settings → General**

- ✅ **Allow forking**
- ❌ **Allow merge commits**
- ✅ **Allow squash merging** (recomendado)
- ✅ **Allow rebase merging**
- ✅ **Always suggest updating pull request branches**
- ✅ **Automatically delete head branches**

#### Configurar Secrets para Shortcut

Ve a: **Settings → Secrets and variables → Actions**

Añade el siguiente secret:
- **Name:** `SHORTCUT_API_TOKEN`
- **Value:** Tu token de API de Shortcut (obtenerlo en https://app.shortcut.com/settings/account/api-tokens)

---

## Verificación

Para verificar que las reglas están correctamente configuradas:

1. Intenta hacer push directamente a `main` → Debe ser rechazado
2. Crea un PR sin el formato `[sc-XXXX]` → Debe fallar el check de Shortcut
3. Crea un PR sin tests → Debe fallar el check de cobertura
4. Crea un PR con código mal formateado → Debe fallar el linter

---

## Equipos de GitHub

Crea los siguientes equipos en tu organización de GitHub:

- `@drones-ai-team/backend` - Desarrolladores backend
- `@drones-ai-team/frontend` - Desarrolladores frontend
- `@drones-ai-team/ai-team` - Equipo de IA/ML
- `@drones-ai-team/devops` - Equipo DevOps

Asigna los miembros correspondientes a cada equipo.
