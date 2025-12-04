---
name: Pull Request Template
about: Template estándar para Pull Requests
title: '[sc-XXXX] '
labels: ''
assignees: ''

---

## 🎯 Descripción

<!-- Describe brevemente los cambios realizados -->

## 📌 Historia de Shortcut

- **Story ID:** [sc-XXXX](https://app.shortcut.com/story/XXXX)
- **Tipo:** [Feature/Bugfix/Hotfix/Refactor]

## ✅ Checklist

- [ ] El código compila sin errores
- [ ] Los tests unitarios pasan exitosamente
- [ ] La cobertura de tests es >= 70%
- [ ] El código pasa el linter (ESLint/flake8)
- [ ] El código está formateado correctamente (Prettier/black)
- [ ] Los commits siguen el formato `[sc-XXXX] Mensaje`
- [ ] La documentación ha sido actualizada si es necesario
- [ ] Se han agregado/actualizado tests para los nuevos cambios

## 🧪 Testing

<!-- Describe cómo se probaron los cambios -->

### Tests unitarios
- [ ] Backend tests: `npm test` (backend/)
- [ ] Frontend tests: `npm test` (frontend/)
- [ ] Python tests: `pytest` (python-services/)

### Tests manuales
<!-- Describe pruebas manuales realizadas -->

## 📸 Screenshots (si aplica)

<!-- Agrega capturas de pantalla para cambios visuales -->

## 🔗 Enlaces relacionados

<!-- Links a documentación, diseños, etc. -->

## ⚠️ Notas adicionales

<!-- Información adicional que los revisores deban conocer -->

---

**Revisores:** Por favor verificar que:
1. El código cumple con los estándares del equipo
2. Los tests tienen cobertura adecuada
3. La historia de Shortcut está correctamente vinculada
4. Los commits tienen el formato correcto `[sc-XXXX]`
