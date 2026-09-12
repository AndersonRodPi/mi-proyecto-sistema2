# Rediseño de Arquitectura y API RESTful - Módulo de Ventas

![Version](https://img.shields.io/badge/version-1.0.0-blue.svg)
![OpenAPI](https://img.shields.io/badge/OpenAPI-3.0.3-green.svg)
![Database](https://img.shields.io/badge/Database-MySQL_8.0_(InnoDB)-orange.svg)
![Cache](https://img.shields.io/badge/Cache-Redis_7.0-red.svg)
![Security](https://img.shields.io/badge/Security-JWT_Bearer-yellow.svg)

Este repositorio contiene la propuesta de arquitectura de software, especificación de API RESTful, diseño de persistencia transaccional y estrategia de caché para la modernización del **Módulo de Ventas**. El objetivo principal es desacoplar el módulo del sistema legado monolítico, resolver cuellos de botella de rendimiento y garantizar la integración segura con Recursos Humanos, Soporte Técnico y Pasarelas de Pago.

---

## Estructura del Repositorio

El proyecto sigue una estructura estandarizada de documentación técnica y artefactos ejecutables:

```text
.
├── docs/
│   ├── api/
│   │   └── openapi.yaml               # Contrato formal de la API (OpenAPI 3.0.3)
│   ├── c4/
│   │   ├── c4_nivel1_contexto.png     # Diagrama 1: Contexto del Sistema
│   │   ├── c4_nivel2_contenedores.png # Diagrama 2: Contenedores
│   │   └── c4_nivel3_componentes.png   # Diagrama 3 y 4: Componentes internos
│   ├── database/
│   │   ├── modelo_datos.png           # Diagrama 5: Modelo ER Conceptual (Notación Chen)
│   │   └── schema.sql                 # Script DDL de creación de BD y datos iniciales (MySQL)
│   ├── cache/
│   │   └── estrategia_cache.png       # Diagrama 6: Flujo de caché Cache-Aside con Redis
│   └── evidence/
│       └── swagger_validacion.png     # Evidencia de validación en Swagger UI
└── README.md                          # Documentación general del repositorio