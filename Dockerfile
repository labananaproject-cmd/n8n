FROM node:18-alpine

# Instalar dependencias del sistema
RUN apk add --update graphicsmagick tzdata git tini su-exec

# Crear directorio de trabajo
WORKDIR /home/node

# Copiar archivos de configuración
COPY package.json pnpm-lock.yaml pnpm-workspace.yaml ./
COPY packages ./packages
COPY patches ./patches

# Instalar pnpm y dependencias
RUN npm install -g pnpm@8
RUN pnpm install --frozen-lockfile

# Build del proyecto
RUN pnpm build

# Configurar usuario
USER node

# Exponer puerto
EXPOSE 5678

# Variables de entorno por defecto
ENV N8N_HOST=0.0.0.0
ENV N8N_PORT=5678

# Comando de inicio
CMD ["pnpm", "start"]
