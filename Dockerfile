# Etapa 1: build
FROM node:20-bullseye AS builder
WORKDIR /usr/src/app

# Copiar solo package files primero para cache de dependencias
COPY package*.json ./
RUN npm ci --only=development

# Copiar código fuente y build
COPY . .
RUN npm run build

# Etapa 2: runtime
FROM node:20-bullseye
WORKDIR /usr/src/app

# Instalar curl para health checks
RUN apt-get update && apt-get install -y curl && rm -rf /var/lib/apt/lists/*

# Copiar package files y instalar solo dependencias de producción
COPY package*.json ./
RUN npm ci --only=production && npm cache clean --force

# Copiar dist desde builder
COPY --from=builder /usr/src/app/dist ./dist

# Crear usuario no-root para seguridad
RUN groupadd -r nodeuser && useradd -r -g nodeuser nodeuser
RUN chown -R nodeuser:nodeuser /usr/src/app
USER nodeuser

EXPOSE 3000

CMD ["node", "dist/main"]
