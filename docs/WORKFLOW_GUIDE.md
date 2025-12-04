# Guía de Flujo de Trabajo - Drones Antimisiles

## 🎯 Objetivo

Esta guía describe el flujo de trabajo completo para desarrollar nuevas funcionalidades en el proyecto "Drones Antimisiles" utilizando el modelo **Fork + Pull Request** con integración continua.

---

## 📊 Diagrama de Flujo

```
┌─────────────────┐
│  Shortcut.com   │  1. Se crea historia
│   [sc-1234]     │
└────────┬────────┘
         │
         ▼
┌─────────────────┐
│   Fork Repo     │  2. Developer hace fork
│  (tu_usuario)   │
└────────┬────────┘
         │
         ▼
┌─────────────────┐
│  Clone Fork     │  3. Clonar localmente
│    & Setup      │
└────────┬────────┘
         │
         ▼
┌─────────────────┐
│  Create Branch  │  4. feature/sc-1234-desc
│  from develop   │
└────────┬────────┘
         │
         ▼
┌─────────────────┐
│    Develop      │  5. Hacer cambios
│   & Commit      │     [sc-1234] Mensaje
└────────┬────────┘
         │
         ▼
┌─────────────────┐
│  Run Tests      │  6. Tests locales
│   Locally       │     Coverage >= 70%
└────────┬────────┘
         │
         ▼
┌─────────────────┐
│  Push to Fork   │  7. Push a origin
│                 │
└────────┬────────┘
         │
         ▼
┌─────────────────┐
│  Create PR      │  8. PR a upstream/develop
│                 │
└────────┬────────┘
         │
         ▼
┌─────────────────┐
│  CI/CD Runs     │  9. GitHub Actions
│  Automatically  │     - Lint
│                 │     - Tests
│                 │     - Coverage
│                 │     - Shortcut link
└────────┬────────┘
         │
         ▼
┌─────────────────┐
│  Code Review    │  10. Team review
│   by Owners     │
└────────┬────────┘
         │
         ▼
┌─────────────────┐
│     Merge       │  11. Squash & Merge
│   to develop    │
└────────┬────────┘
         │
         ▼
┌─────────────────┐
│   Shortcut      │  12. Historia actualizada
│   Updated       │      automáticamente
└─────────────────┘
```

---

## 📝 Paso a Paso Detallado

### 0. Preparación Inicial (Solo primera vez)

#### Fork del repositorio

1. Ve a https://github.com/luhercentti/drones-ai-demo
2. Click en **"Fork"** (esquina superior derecha)
3. Selecciona tu cuenta personal
4. Espera a que se cree el fork

#### Clonar tu fork

```bash
# Clonar tu fork
git clone https://github.com/TU_USUARIO/drones-ai-demo.git
cd drones-ai-demo

# Configurar remote upstream (repositorio principal)
git remote add upstream https://github.com/luhercentti/drones-ai-demo.git

# Verificar remotos
git remote -v
# Deberías ver:
# origin    https://github.com/TU_USUARIO/drones-ai-demo.git (fetch)
# origin    https://github.com/TU_USUARIO/drones-ai-demo.git (push)
# upstream  https://github.com/luhercentti/drones-ai-demo.git (fetch)
# upstream  https://github.com/luhercentti/drones-ai-demo.git (push)
```

#### Instalar dependencias

```bash
./scripts/setup.sh
```

---

### 1. Crear Historia en Shortcut

1. Ve a https://app.shortcut.com
2. Click en **"New Story"**
3. Completa:
   - **Name:** Descripción de la funcionalidad
   - **Type:** Feature/Bug/Chore
   - **Estimate:** Puntos de historia
   - **Owner:** Asígnate la historia
4. Click **"Create"**
5. **Anota el ID:** `sc-XXXX` (ej: `sc-1234`)

---

### 2. Sincronizar tu Fork

**Antes de empezar a trabajar, SIEMPRE sincroniza:**

```bash
# Cambiar a develop
git checkout develop

# Traer cambios del repo principal
git fetch upstream

# Mergear cambios en tu develop local
git merge upstream/develop

# Actualizar tu fork en GitHub
git push origin develop
```

---

### 3. Crear Rama de Feature

```bash
# Desde develop, crear nueva rama
git checkout -b feature/sc-1234-breve-descripcion

# Ejemplos de nombres válidos:
# feature/sc-1234-gps-validation
# bugfix/sc-5678-drone-status-error
# refactor/sc-9012-ai-controller-cleanup
```

**Convenciones de nombres:**
- `feature/sc-XXXX-descripcion` - Nueva funcionalidad
- `bugfix/sc-XXXX-descripcion` - Corrección de bug
- `hotfix/sc-XXXX-descripcion` - Corrección urgente
- `refactor/sc-XXXX-descripcion` - Refactorización

---

### 4. Desarrollar la Funcionalidad

#### 4.1 Escribir código

Ejemplo para backend:

```bash
cd backend

# Crear archivo de utilidades
touch src/utils/gps.ts

# Escribir código...
```

#### 4.2 Escribir tests

```bash
# Crear archivo de tests
touch src/utils/gps.test.ts

# Escribir tests con coverage >= 70%
```

#### 4.3 Ejecutar tests localmente

```bash
# Backend
cd backend
npm test

# Frontend
cd frontend
npm test

# Python
cd python-services
pytest
```

#### 4.4 Verificar linting

```bash
# Backend/Frontend
npm run lint
npm run format:check

# Python
flake8 src/ tests/
black --check src/ tests/
```

---

### 5. Hacer Commits

**Formato OBLIGATORIO:**

```bash
git add .
git commit -m "[sc-1234] Descripción clara del cambio"
```

**Ejemplos válidos:**

```bash
[sc-1234] Añadir validación de coordenadas GPS
[sc-1234] Implementar cálculo de distancia entre puntos
[sc-1234] Añadir tests para validateCoordinates
[sc-1234] Corregir bug en DroneStatus component
```

**Consejos:**
- ✅ Commits pequeños y atómicos
- ✅ Un commit = un cambio lógico
- ✅ Mensaje descriptivo y claro
- ❌ Evitar commits gigantes con muchos cambios

---

### 6. Push a tu Fork

```bash
# Primera vez que haces push de esta rama
git push -u origin feature/sc-1234-breve-descripcion

# Pushes subsiguientes
git push
```

---

### 7. Crear Pull Request

#### En GitHub:

1. Ve a tu fork: `https://github.com/TU_USUARIO/drones-ai-demo`
2. Verás un banner: **"Compare & pull request"** → Click
3. Configura el PR:
   - **Base repository:** `luhercentti/drones-ai-demo`
   - **Base branch:** `develop`
   - **Head repository:** `TU_USUARIO/drones-ai-demo`
   - **Compare branch:** `feature/sc-1234-breve-descripcion`

#### Completar el Template:

```markdown
## 🎯 Descripción
Implementa validación de coordenadas GPS para el sistema de drones.

## 📌 Historia de Shortcut
- **Story ID:** [sc-1234](https://app.shortcut.com/story/1234)
- **Tipo:** Feature

## ✅ Checklist
- [x] El código compila sin errores
- [x] Los tests unitarios pasan exitosamente
- [x] La cobertura de tests es >= 70%
- [x] El código pasa el linter
- [x] El código está formateado correctamente
- [x] Los commits siguen el formato `[sc-XXXX]`

## 🧪 Testing
### Tests unitarios
- [x] Backend tests: `npm test` - ✅ Passed (Coverage: 85%)

### Tests manuales
- Validación manual de coordenadas válidas e inválidas
```

4. Click **"Create pull request"**

---

### 8. CI/CD Automático

GitHub Actions ejecutará automáticamente:

#### ✅ Backend CI (si modificaste backend/)
- ESLint
- Prettier check
- Jest tests
- Coverage >= 70%

#### ✅ Frontend CI (si modificaste frontend/)
- ESLint + React rules
- Prettier check
- Jest + React Testing Library
- Coverage >= 70%

#### ✅ Python CI (si modificaste python-services/)
- flake8
- black check
- pytest
- Coverage >= 70%

#### ✅ Shortcut Integration
- Valida formato de commits `[sc-XXXX]`
- Vincula commits a Shortcut
- Publica comentarios en la historia

**Espera a que todos los checks pasen:**

```
✅ Backend Lint & Test
✅ Frontend Lint & Test  
✅ Python Lint & Test
✅ Link commits to Shortcut stories
```

---

### 9. Code Review

#### Solicitar revisores

El archivo `CODEOWNERS` asigna automáticamente revisores según:

- `backend/**` → @drones-ai-team/backend
- `frontend/**` → @drones-ai-team/frontend
- `python-services/**` → @drones-ai-team/backend + @drones-ai-team/ai-team

#### Durante el review:

Los revisores pueden:
- ✅ Aprobar (✓ Approve)
- 💬 Solicitar cambios (Request changes)
- 💭 Comentar (Comment)

#### Si hay cambios solicitados:

```bash
# Hacer cambios localmente
# ...edit files...

# Commit con el mismo formato
git add .
git commit -m "[sc-1234] Corregir observaciones del code review"

# Push (se actualiza el PR automáticamente)
git push
```

El CI/CD se ejecutará nuevamente.

---

### 10. Aprobar y Mergear

#### Condiciones para merge:

**Para develop:**
- ✅ Mínimo 1 aprobación
- ✅ Todos los checks de CI/CD pasan
- ✅ Sin conflictos con develop
- ✅ Conversaciones resueltas

**Para main:**
- ✅ Mínimo 2 aprobaciones
- ✅ Todos los checks de CI/CD pasan
- ✅ Review de DevOps aprobado

#### Mergear:

1. El **reviewer aprobador** o **el autor** puede mergear
2. Click en **"Squash and merge"** (recomendado)
3. Confirma el mensaje del merge
4. Click **"Confirm squash and merge"**

#### Auto-cleanup:

GitHub automáticamente:
- ✅ Cierra el PR
- ✅ Borra la rama del repo principal (no de tu fork)
- ✅ Actualiza Shortcut con link al merge

---

### 11. Post-Merge

#### Limpiar tu fork:

```bash
# Volver a develop
git checkout develop

# Traer cambios del repo principal (incluye tu merge)
git fetch upstream
git merge upstream/develop

# Actualizar tu fork
git push origin develop

# Borrar rama local (ya mergeada)
git branch -d feature/sc-1234-breve-descripcion

# Borrar rama remota de tu fork (opcional)
git push origin --delete feature/sc-1234-breve-descripcion
```

#### Verificar en Shortcut:

La historia `sc-1234` debería tener:
- ✅ Comentarios con links a tus commits
- ✅ Link al PR mergeado
- 📊 Puedes moverla a "Ready for Deploy" o "Deployed"

---

## 🚨 Problemas Comunes

### ❌ CI/CD falla: "Coverage below 70%"

**Solución:**
```bash
# Añadir más tests
# Ejecutar localmente
npm test -- --coverage

# Ver qué falta cubrir
open coverage/index.html
```

### ❌ CI/CD falla: "ESLint errors"

**Solución:**
```bash
# Ver errores
npm run lint

# Auto-fix
npm run lint:fix
```

### ❌ CI/CD falla: "Prettier formatting"

**Solución:**
```bash
# Formatear código
npm run format

# Verificar
npm run format:check
```

### ❌ CI/CD falla: "Commit format invalid"

**Solución:**
```bash
# Modificar el último commit
git commit --amend -m "[sc-1234] Mensaje corregido"

# Force push (solo si no hay review aún)
git push --force
```

### ❌ Conflictos con develop

**Solución:**
```bash
# Actualizar develop local
git checkout develop
git fetch upstream
git merge upstream/develop

# Volver a tu rama
git checkout feature/sc-1234-descripcion

# Rebase sobre develop actualizado
git rebase develop

# Resolver conflictos si hay
# ...edit conflicted files...
git add .
git rebase --continue

# Force push (rebase reescribe historia)
git push --force
```

---

## 📋 Checklists Rápidas

### Antes de crear el PR:

- [ ] Tests locales pasan
- [ ] Coverage >= 70%
- [ ] Lint pasa
- [ ] Código formateado
- [ ] Commits con formato `[sc-XXXX]`
- [ ] Rama actualizada con develop
- [ ] Sin conflictos

### Al crear el PR:

- [ ] Template completo
- [ ] Story de Shortcut vinculada
- [ ] Descripción clara de cambios
- [ ] Tipo de cambio indicado (Feature/Bug/etc)
- [ ] Checklist completado
- [ ] Screenshots si hay cambios visuales

### Antes de mergear:

- [ ] Todas las aprobaciones requeridas
- [ ] Todos los checks pasan ✅
- [ ] Conversaciones resueltas
- [ ] Sin conflictos
- [ ] Historia de Shortcut actualizada

---

## 🎓 Mejores Prácticas

### Commits

✅ **Hacer:**
- Commits pequeños y frecuentes
- Mensajes descriptivos
- Un commit = un cambio lógico

❌ **Evitar:**
- Commits gigantes
- Mensajes vagos ("fix", "changes")
- Mezclar múltiples cambios

### Branches

✅ **Hacer:**
- Crear desde develop actualizado
- Nombres descriptivos
- Borrar después del merge

❌ **Evitar:**
- Branches viejas sin actualizar
- Nombres genéricos (feature-1, test)
- Acumular muchas branches

### Testing

✅ **Hacer:**
- Tests antes de push
- Coverage >= 70%
- Tests de casos edge

❌ **Evitar:**
- Tests solo para pasar el threshold
- Mock excesivo
- Tests sin asserts reales

### Code Review

✅ **Hacer:**
- Respuestas rápidas
- Explicar decisiones
- Agradecer feedback

❌ **Evitar:**
- Ignorar comentarios
- Defensiveness
- Cambios sin discutir

---

## 📚 Recursos Adicionales

- [Branch Protection Setup](BRANCH_PROTECTION_SETUP.md)
- [Shortcut Integration](SHORTCUT_INTEGRATION.md)
- [Testing Guidelines](../README.md#testing)
- [GitHub Flow](https://guides.github.com/introduction/flow/)

---

## ❓ FAQ

**P: ¿Puedo hacer push directo a main o develop?**
R: No. Todas las ramas están protegidas. Solo PR.

**P: ¿Cuántas aprobaciones necesito?**
R: 1 para develop, 2 para main.

**P: ¿Qué pasa si olvido el formato [sc-XXXX]?**
R: El CI/CD fallará y no podrás mergear. Usa `git commit --amend`.

**P: ¿Puedo mergear mi propio PR?**
R: En develop sí, después de aprobación. En main necesitas ser DevOps.

**P: ¿Cómo actualizo mi fork?**
R: `git fetch upstream && git merge upstream/develop && git push origin develop`

---

**¿Dudas?** Contacta al equipo DevOps 🛠️
