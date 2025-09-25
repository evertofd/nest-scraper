FROM node:20-bullseye AS builder

# Configurar Puppeteer para no descargar Chromium durante build
ENV PUPPETEER_SKIP_CHROMIUM_DOWNLOAD=true

WORKDIR /usr/src/app

# Copiar package files primero para cache de dependencias
COPY package*.json ./
RUN npm ci

# Copiar código fuente y compilar
COPY . .
RUN npm run build

# Etapa 2: runtime
FROM node:20-bullseye

# Instalar Chromium (más simple y confiable que Google Chrome)
RUN apt-get update && apt-get install -y \
    chromium \
    chromium-sandbox \
    curl \
    fonts-ipafont-gothic \
    fonts-wqy-zenhei \
    fonts-thai-tlwg \
    fonts-kacst \
    fonts-freefont-ttf \
    --no-install-recommends \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /usr/src/app

# Copiar package files e instalar solo dependencias de producción
COPY package*.json ./
RUN npm ci --omit=dev && npm cache clean --force

# Copiar dist desde builder
COPY --from=builder /usr/src/app/dist ./dist

# Configurar Puppeteer para usar Chromium instalado
ENV PUPPETEER_SKIP_CHROMIUM_DOWNLOAD=true \
    PUPPETEER_EXECUTABLE_PATH=/usr/bin/chromium

# Crear usuario no-root para seguridad
RUN groupadd -r nodeuser && useradd -r -g nodeuser nodeuser \
    && chown -R nodeuser:nodeuser /usr/src/app \
    && mkdir -p /home/nodeuser && chown -R nodeuser:nodeuser /home/nodeuser
USER nodeuser

EXPOSE 3000

CMD ["node", "dist/main"]
