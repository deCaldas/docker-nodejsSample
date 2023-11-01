# syntax=docker/dockerfile:1
# Utilizamos la sintaxis de Docker BuildKit con la versión 1 del Dockerfile.
# Esto habilita características avanzadas y mejor manejo de argumentos.

ARG NODE_VERSION=18.0.0
# Definimos un argumento para especificar la versión de Node que se usará.
# Esto nos permite flexibilidad al construir la imagen.

FROM node:${NODE_VERSION}-alpine as base
# Definimos la etapa "base" que será común a todas las variantes de la imagen.

WORKDIR /usr/src/app
# Establecemos el directorio de trabajo dentro del contenedor.

EXPOSE 3000
# Exponemos el puerto 3000, que será utilizado por la aplicación.

FROM base as dev
# Creamos la etapa "dev" que se utiliza para desarrollo.

RUN --mount=type=bind,source=package.json,target=package.json \
    --mount=type=bind,source=package-lock.json,target=package-lock.json \
    --mount=type=cache,target=/root/.npm \
    npm ci --include=dev
# Copiamos el archivo package.json y package-lock.json del sistema de archivos host
# para aprovechar el caché y evitar descargas innecesarias.

USER node
# Cambiamos al usuario "node" para ejecutar la aplicación de forma más segura.

COPY . .
# Copiamos todo el código fuente de la aplicación.

CMD npm run dev
# Ejecutamos el comando "npm run dev" para iniciar la aplicación en modo desarrollo.

FROM base as prod
# Creamos la etapa "prod" para producción.

ENV NODE_ENV production
# Establecemos la variable de entorno NODE_ENV en "production".

RUN --mount=type=bind,source=package.json,target=package.json \
    --mount=type=bind,source=package-lock.json,target=package-lock.json \
    --mount=type=cache,target=/root/.npm \
    npm ci --omit=dev
# Realizamos el mismo proceso de copia e instalación que en la etapa "dev".

USER node
COPY . .
# Cambiamos al usuario "node" y copiamos el código fuente.

CMD node src/index.js
# Ejecutamos la aplicación en modo producción.

FROM base as test
# Creamos la etapa "test" para ejecutar pruebas.

ENV NODE_ENV test
# Establecemos NODE_ENV en "test" para configurar el entorno de prueba.

RUN --mount=type=bind,source=package.json,target=package.json \
    --mount=type=bind,source=package-lock.json,target=package-lock.json \
    --mount=type=cache,target=/root/.npm \
    npm ci --include=dev
# Realizamos el proceso de copia e instalación similar a las etapas anteriores.

USER node
COPY . .
# Cambiamos al usuario "node" y copiamos el código fuente.

RUN npm run test
# Ejecutamos las pruebas de la aplicación.
