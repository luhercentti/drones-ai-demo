# Integración con Shortcut.com

## 📋 Descripción General

Este proyecto está integrado con **Shortcut** (anteriormente Clubhouse) para gestión de historias de usuario y trazabilidad de desarrollo.

## 🔗 Integración GitHub ↔ Shortcut

### Características implementadas

✅ **Vinculación automática de commits**
- Cada commit con formato `[sc-XXXX]` se vincula automáticamente a Shortcut
- Se publica un comentario en la historia con detalles del commit

✅ **Validación de formato**
- GitHub Actions valida que todos los commits tengan el formato correcto
- Bloquea PRs si algún commit no cumple con el formato

✅ **Actualización de estado**
- Los cambios en GitHub se reflejan en Shortcut
- Trazabilidad completa del trabajo realizado

---

## ⚙️ Configuración

### 1. Obtener API Token de Shortcut

1. Inicia sesión en https://app.shortcut.com
2. Ve a **Settings → Account → API Tokens**
3. Click en **"Generate New API Token"**
4. Dale un nombre descriptivo: "GitHub Integration - Drones AI"
5. Copia el token generado (solo se muestra una vez)

### 2. Configurar Secret en GitHub

#### Para el repositorio principal:

1. Ve a tu repositorio en GitHub
2. Click en **Settings** → **Secrets and variables** → **Actions**
3. Click en **"New repository secret"**
4. Configura:
   - **Name:** `SHORTCUT_API_TOKEN`
   - **Secret:** [pega el token de Shortcut]
5. Click en **"Add secret"**

#### Para tu fork (opcional):

Si quieres probar la integración en tu fork:

1. Ve a **tu fork** → **Settings** → **Secrets and variables** → **Actions**
2. Añade el mismo secret `SHORTCUT_API_TOKEN`

---

## 📝 Formato de Commits

### Formato obligatorio

```
[sc-NUMERO] Mensaje descriptivo del commit
```

### Ejemplos válidos

```bash
[sc-1234] Implementar validación de coordenadas GPS
[sc-5678] Corregir bug en cálculo de distancias
[sc-9012] Refactorizar componente DroneStatus
[sc-3456] Añadir tests para AIController
```

### Ejemplos inválidos ❌

```bash
Implementar validación GPS
Fix bug
[SC-1234] Mensaje  # Minúscula en 'sc' no válida
sc-1234 Mensaje    # Falta corchetes
```

---

## 🤖 Funcionamiento del Workflow

El archivo `.github/workflows/shortcut-integration.yml` se ejecuta en cada push y PR:

### Pasos del workflow:

1. **Extracción del Story ID**
   - Analiza el mensaje del último commit
   - Busca el patrón `[sc-XXXX]`
   - Extrae el número de la historia

2. **Validación del formato**
   - Verifica que el ID sea numérico
   - Valida que el formato sea correcto
   - Falla si el formato es incorrecto

3. **Publicación en Shortcut**
   - Envía una petición POST a la API de Shortcut
   - Crea un comentario en la historia vinculada
   - Incluye: commit hash, autor, branch, mensaje

4. **Validación de PRs**
   - En PRs, valida TODOS los commits
   - Falla si algún commit no tiene el formato correcto
   - Muestra mensajes de error detallados

### Ejemplo de comentario en Shortcut

Cuando haces un commit, Shortcut recibe un comentario como:

```
🔗 **Commit vinculado desde GitHub**

**Commit:** `a1b2c3d`
**Branch:** `feature/sc-1234-gps-validation`
**Autor:** @tu-usuario
**Mensaje:** [sc-1234] Implementar validación de coordenadas GPS
```

---

## 🔍 Verificación

### Verificar que la integración funciona:

1. **Crear una historia de prueba en Shortcut**
   ```
   Titulo: Test de integración GitHub
   ID resultante: sc-XXXX (anota este número)
   ```

2. **Hacer un commit de prueba**
   ```bash
   git checkout -b feature/sc-XXXX-test
   echo "test" > test.txt
   git add test.txt
   git commit -m "[sc-XXXX] Test de integración con Shortcut"
   git push origin feature/sc-XXXX-test
   ```

3. **Verificar en GitHub Actions**
   - Ve a **Actions** en tu repositorio
   - Busca el workflow "Shortcut Integration"
   - Verifica que haya terminado exitosamente ✅

4. **Verificar en Shortcut**
   - Abre la historia sc-XXXX en Shortcut
   - Ve a la sección de comentarios
   - Deberías ver un comentario con el enlace al commit

---

## 🚨 Troubleshooting

### El workflow falla con "No se encontró ID de Shortcut"

**Problema:** El commit no tiene el formato correcto

**Solución:**
```bash
# Modificar el último commit
git commit --amend -m "[sc-1234] Tu mensaje corregido"
git push --force
```

### El workflow falla con error 401 (Unauthorized)

**Problema:** El token de Shortcut no está configurado o es inválido

**Solución:**
1. Verifica que el secret `SHORTCUT_API_TOKEN` existe
2. Genera un nuevo token en Shortcut
3. Actualiza el secret en GitHub

### El comentario no aparece en Shortcut

**Problema:** El Story ID no existe en Shortcut

**Solución:**
1. Verifica que el ID de la historia existe
2. Verifica que tienes acceso a esa historia
3. Revisa los logs del workflow en GitHub Actions

### Error: "Story not found" (404)

**Problema:** El número de historia no existe

**Solución:**
- Verifica el ID en Shortcut: `https://app.shortcut.com/story/XXXX`
- Usa un ID válido existente

---

## 🎯 Mejores Prácticas

### 1. Un commit = Una historia

Cada commit debería relacionarse con UNA historia de Shortcut:

```bash
# ✅ Correcto
[sc-1234] Implementar endpoint /api/drones

# ❌ Incorrecto (múltiples historias)
[sc-1234][sc-5678] Cambios varios
```

### 2. Mensajes descriptivos

El mensaje debe explicar QUÉ se hizo:

```bash
# ✅ Correcto
[sc-1234] Añadir validación de coordenadas GPS en DroneController

# ❌ Incorrecto
[sc-1234] Cambios
[sc-1234] Fix
```

### 3. Commits atómicos

Haz commits pequeños y frecuentes:

```bash
# ✅ Correcto - commits separados
[sc-1234] Añadir interfaz Coordinates
[sc-1234] Implementar validateCoordinates
[sc-1234] Añadir tests para validateCoordinates

# ❌ Incorrecto - todo en un commit
[sc-1234] Implementar todo el sistema de coordenadas
```

### 4. Vincular desde el inicio

Vincula la historia desde el primer commit:

```bash
# Al crear la rama
git checkout -b feature/sc-1234-nueva-funcionalidad

# Primer commit
git commit -m "[sc-1234] Añadir estructura base del módulo"
```

---

## 📊 Workflow en Shortcut

### Estados recomendados

1. **Ready for Development** → Creas la rama
2. **In Development** → Primer commit con `[sc-XXXX]`
3. **Ready for Review** → Abres el PR
4. **In Review** → Durante code review
5. **Ready for Deploy** → PR aprobado y mergeado
6. **Deployed** → Deploy a producción

### Automatización adicional (opcional)

Puedes configurar webhooks en Shortcut para:
- Mover historias automáticamente según estado del PR
- Notificar en Slack cuando se vincula un commit
- Actualizar labels según el tipo de commit

---

## 🔧 Personalización

### Modificar el formato de comentario

Edita `.github/workflows/shortcut-integration.yml`:

```yaml
COMMENT="🔗 **Commit vinculado desde GitHub**\n\n"
COMMENT+="**Commit:** [\`${COMMIT_SHA:0:7}\`](...)\n"
# Añade más campos aquí
```

### Cambiar el formato de commit requerido

Si quieres usar un formato diferente:

```yaml
# En shortcut-integration.yml, línea ~20
STORY_ID=$(echo "$COMMIT_MSG" | grep -oP '\[sc-\K[0-9]+' || echo "")

# Cambia a tu patrón preferido, ejemplo:
# Para formato "SC-1234:"
STORY_ID=$(echo "$COMMIT_MSG" | grep -oP 'SC-\K[0-9]+' || echo "")
```

---

## 📚 Referencias

- **API de Shortcut:** https://developer.shortcut.com/api/rest/v3
- **GitHub Actions:** https://docs.github.com/en/actions
- **Webhooks de Shortcut:** https://help.shortcut.com/hc/en-us/articles/360028953452

---

## ✅ Checklist de Configuración

- [ ] Token de API generado en Shortcut
- [ ] Secret `SHORTCUT_API_TOKEN` configurado en GitHub
- [ ] Workflow `shortcut-integration.yml` añadido al repo
- [ ] Test de integración realizado exitosamente
- [ ] Documentación compartida con el equipo
- [ ] Equipo entrenado en formato de commits

---

¿Necesitas ayuda? Contacta al equipo DevOps 🛠️
