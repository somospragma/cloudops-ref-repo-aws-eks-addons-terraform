# Changelog

All notable changes to this project will be documented in this file.

## [2.0.1] - 2025-12-19

### Changed
- Actualizado comentario en `locals.tf` para clarificar addons gestionados por Auto Mode
- Documentación mejorada basada en AWS Best Practices

## [2.0.0] - 2024-12-18

### Added
- **Auto Mode Compatibility**: Validación de addons incompatibles con EKS Auto Mode
- **PC-IAC Compliance**: Aplicadas las 26 reglas de gobernanza
  - PC-IAC-001: Estructura completa de módulo
  - PC-IAC-002: Variables con validaciones
  - PC-IAC-005: Provider injection pattern
  - PC-IAC-006: Version pinning
  - PC-IAC-007: Outputs granulares
  - PC-IAC-009: map(object) con optional()
  - PC-IAC-010: for_each implementation
  - PC-IAC-026: Sample con patrón de transformación
- **Documentación**: Lista de addons compatibles/incompatibles con Auto Mode

### Changed
- **BREAKING**: Estructura de módulo actualizada para cumplir con PC-IAC-001
- Actualizado `versions.tf` con version pinning >= 5.0

### Documentation
- README.md actualizado con información de compatibilidad Auto Mode
- Agregado sample funcional con patrón PC-IAC-026

## [1.0.0] - 2024-12-01

### Added
- Initial release del módulo EKS Addons
- Soporte para múltiples addons con for_each anidado
- Configuración de versiones y service account roles
- Resolve conflicts automático
