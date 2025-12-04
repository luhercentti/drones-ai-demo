# Troubleshooting CI/CD

## Errores comunes en GitHub Actions y sus soluciones

### ❌ Error: "Unable to cache dependencies"

**Síntoma:**
```
Error: Some specified paths were not resolved, unable to cache dependencies.
```

**Causa:** El archivo `package-lock.json` no existe aún.

**Solución:**
1. Genera el `package-lock.json` ejecutando `npm install` localmente:
   ```bash
   cd backend
   npm install
   git add package-lock.json
   git commit -m "[sc-XXXX] Añadir package-lock.json para backend"
   
   cd ../frontend
   npm install
   git add package-lock.json
   git commit -m "[sc-XXXX] Añadir package-lock.json para frontend"
   ```

2. O desactiva el cache en los workflows (ya aplicado en los workflows actuales)

### ❌ Error: FileNotFoundError en Python coverage

**Síntoma:**
```
FileNotFoundError: [Errno 2] No such file or directory: '.coverage.json'
```

**Causa:** pytest no genera archivos de cobertura en formato JSON por defecto.

**Solución:** Usar `--cov-fail-under=70` en pytest (ya configurado en `pyproject.toml`), que falla automáticamente si la cobertura es < 70%.

### ❌ Error: "Cannot find module 'supertest'"

**Síntoma:**
```
Cannot find module 'supertest' or its corresponding type declarations.
```

**Solución:**
```bash
cd backend
npm install --save-dev supertest @types/supertest
```

### ❌ Error: "toBeInTheDocument is not a function"

**Síntoma:**
```
Property 'toBeInTheDocument' does not exist on type 'JestMatchers<any>'.
```

**Solución:**
```bash
cd frontend
npm install --save-dev @testing-library/jest-dom
```

Luego crear `jest.setup.js`:
```javascript
import '@testing-library/jest-dom';
```

Y actualizar `jest.config.js`:
```javascript
setupFilesAfterEnv: ['<rootDir>/jest.setup.js'],
```

### ❌ Error: "Cannot find module 'react'"

**Solución:**
```bash
cd frontend
npm install react react-dom
npm install --save-dev @testing-library/react @types/react @types/react-dom
```

### ❌ Tests fallan localmente pero pasan en CI (o viceversa)

**Solución:**
1. Verificar versiones de Node.js:
   ```bash
   node -v  # Debe ser >= 20.x
   ```

2. Limpiar y reinstalar:
   ```bash
   rm -rf node_modules package-lock.json
   npm install
   ```

3. Verificar que las variables de entorno sean consistentes

### ❌ Error: "ESLint: Parsing error"

**Solución:**
1. Verificar que `tsconfig.json` esté configurado correctamente
2. Reinstalar dependencias de ESLint:
   ```bash
   npm install --save-dev @typescript-eslint/parser @typescript-eslint/eslint-plugin
   ```

### ❌ Cobertura < 70% en CI pero >= 70% localmente

**Solución:**
1. Ejecutar con las mismas opciones que CI:
   ```bash
   npm run test:ci
   ```

2. Verificar que todos los archivos estén incluidos en `collectCoverageFrom`

3. Revisar qué archivos no están siendo cubiertos:
   ```bash
   npm test -- --coverage
   open coverage/index.html  # macOS
   ```

### ⚠️ Warning: "React is not defined"

**Solución:**
Actualizar `.eslintrc.json`:
```json
{
  "rules": {
    "react/react-in-jsx-scope": "off"
  }
}
```

### 🔧 Comandos útiles para debugging

```bash
# Ver logs detallados de tests
npm test -- --verbose

# Ejecutar solo un archivo de test
npm test -- src/utils/gps.test.ts

# Ejecutar tests en modo watch
npm test -- --watch

# Ver cobertura detallada
npm test -- --coverage --verbose

# Limpiar cache de Jest
npm test -- --clearCache

# Verificar sintaxis de TypeScript
npx tsc --noEmit

# Ejecutar ESLint con detalles
npm run lint -- --debug
```

### 📊 Verificar antes de hacer push

```bash
# Ejecutar todos los tests
./scripts/run-all-tests.sh

# O manualmente:
cd backend && npm test && cd ..
cd frontend && npm test && cd ..
cd python-services && source venv/bin/activate && pytest && deactivate && cd ..
```

### 🚀 Primeros pasos después de clonar

```bash
# 1. Ejecutar setup automático
./scripts/setup.sh

# 2. Verificar que todo funciona
./scripts/run-all-tests.sh

# 3. Si hay errores, instalar dependencias faltantes
cd backend && npm install && cd ..
cd frontend && npm install && cd ..
cd python-services && source venv/bin/activate && pip install -r requirements.txt && deactivate && cd ..
```

### 📞 ¿Aún tienes problemas?

1. Revisa los logs completos de GitHub Actions
2. Compara con un commit que haya pasado los checks
3. Verifica que tus dependencias estén actualizadas
4. Contacta al equipo DevOps

---

**Última actualización:** Diciembre 2025
