# 🕷️ Nest Scraper

## Descripción 📋
API de scraping construida con NestJS y Docker. Proyecto MVP con arquitectura containerizada para desarrollo y producción, utilizando PostgreSQL como base de datos y configuración optimizada para escalabilidad.

## Pre-requisitos ⚙️
Antes de comenzar, asegúrate de tener instalado lo siguiente:
- [Docker](https://www.docker.com/)
- [Docker Compose](https://docs.docker.com/compose/)
- [Node.js](https://nodejs.org/) versión 20 o superior (solo para desarrollo local)

Para que la aplicación funcione correctamente, necesitas configurar las variables de entorno. En la raíz del proyecto, crea un archivo llamado `.env` y agrega las siguientes variables:

```env
# Database Configuration
POSTGRES_USER=nest
POSTGRES_PASSWORD=nest
POSTGRES_DB=nestdb
POSTGRES_PORT=5432
POSTGRES_HOST=db

# Application
PORT=3000
NODE_ENV=development
```

## Comenzando 🚀

### Con Docker (Recomendado)

Para iniciar el proyecto en **desarrollo**:

```bash
# Levantar contenedores en modo desarrollo (con hot reload)
docker-compose -f docker-compose.dev.yml up --build
```

Para iniciar el proyecto en **producción**:

```bash
# Levantar contenedores en modo producción
docker-compose -f docker-compose.yml up --build
```

### Comandos útiles 🛠️

```bash
# Parar contenedores de desarrollo
docker-compose -f docker-compose.dev.yml down

# Parar contenedores de producción
docker-compose -f docker-compose.yml down

# Limpiar volúmenes (reset completo)
docker-compose -f docker-compose.dev.yml down -v
docker-compose -f docker-compose.yml down -v

# Acceder a la base de datos
docker exec -it nest_postgres_dev psql -U nest -d nestdb
```

## Construido con 🛠️
- [NestJS](https://nestjs.com/) - Framework progresivo de Node.js
- [TypeScript](https://www.typescriptlang.org/)
- [PostgreSQL](https://www.postgresql.org/) - Base de datos relacional
- [TypeORM](https://typeorm.io/) - ORM para TypeScript
- [Docker](https://www.docker.com/) - Containerización
- [Docker Compose](https://docs.docker.com/compose/) - Orquestación de contenedores

## Arquitectura 🏗️
El proyecto utiliza una arquitectura containerizada con Docker:

- **Aplicación NestJS**: Servidor API con TypeScript
- **Base de datos PostgreSQL**: Almacenamiento persistente
- **Docker Multi-stage**: Build optimizado para producción
- **Health Checks**: Monitoreo automático de servicios
- **Hot Reload**: Desarrollo ágil con recarga automática

## Configuración Docker 🐳

### Desarrollo vs Producción

| Característica | Desarrollo | Producción |
|---------------|------------|------------|
| **Hot Reload** | ✅ Activado | ❌ Desactivado |
| **Volúmenes** | ✅ Código mapeado | ❌ Código copiado |
| **Rebuild** | ❌ No necesario | ✅ Necesario para cambios |
| **Optimización** | ❌ Básica | ✅ Multi-stage build |
| **Seguridad** | ❌ Usuario root | ✅ Usuario no-root |
| **Health Checks** | ❌ Opcional | ✅ Habilitado |

## Endpoints disponibles 📡

### Health Check
| Método | Ruta | Descripción |
|--------|------|-------------|
| GET | `/health` | Estado de la aplicación |

### Respuesta Health Check:
```json
{
  "status": "ok",
  "timestamp": "2025-09-25T00:20:15.123Z",
  "service": "nest-scraper"
}
```

## Estructura del Proyecto 📁
```
nest-scarper/
├── src/                    # Código fuente
│   ├── app.controller.ts   # Controlador principal
│   ├── app.module.ts       # Módulo raíz
│   ├── app.service.ts      # Servicio principal
│   └── main.ts            # Punto de entrada
├── docker-compose.yml      # Configuración producción
├── docker-compose.dev.yml  # Configuración desarrollo
├── Dockerfile              # Image de producción
├── Dockerfile.dev          # Image de desarrollo
├── .dockerignore          # Archivos excluidos del build
└── .env                   # Variables de entorno
```

## Desarrollo 👨‍💻

### Modo Desarrollo
- **Hot Reload**: Los cambios se aplican automáticamente
- **Debug**: Logs detallados disponibles
- **Base de datos**: PostgreSQL en contenedor separado
- **Volumes**: Código mapeado para desarrollo ágil

### Modo Producción
- **Optimizado**: Build multi-stage para menor tamaño
- **Seguro**: Usuario no-root y configuraciones de seguridad
- **Monitoreo**: Health checks automáticos
- **Estable**: Imagen inmutable para despliegue

## Características Principales ✨
- 🐳 **Containerización completa** con Docker y Docker Compose
- 🔄 **Hot reload** para desarrollo ágil
- 🏥 **Health checks** automáticos en producción
- 🔒 **Configuración segura** con usuarios no-root
- 📊 **Base de datos PostgreSQL** con persistencia
- ⚡ **Build optimizado** con cache de dependencias
- 🛠️ **Desarrollo sin setup** - solo necesitas Docker

## Estado del Proyecto 🚧
Este es un proyecto **MVP (Minimum Viable Product)** con la configuración base lista para:
- ✅ Desarrollo local con hot reload
- ✅ Despliegue en producción
- ✅ Base de datos PostgreSQL
- ✅ Health monitoring
- 🔄 **Próximamente**: Funcionalidades de scraping

## Autores ✒️
- **Everto** ❤️

*Desarrollado con 💚 usando NestJS y Docker*
