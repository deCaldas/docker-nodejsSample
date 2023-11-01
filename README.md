# Sample Node.js application

This repository is a sample Node.js application for Docker's documentation.

Dockerfile:
Este archivo `Dockerfile` utiliza una imagen de Node.js oficial como imagen principal y establece el directorio de trabajo en `/app`. Luego, copia todo el contenido del directorio actual en el contenedor en `/app`. A continuación, instala cualquier paquete necesario especificado en `package.json`, expone el puerto 80 al mundo exterior y define una variable de entorno llamada `NAME`. Finalmente, ejecuta `npm start` cuando se lanza el contenedor.


.dockerignore:
Este archivo `.dockerignore` excluye los archivos `node_modules` y `npm-debug.log` del contexto de construcción de Docker. Esto significa que estos archivos no se incluirán en la imagen de Docker, lo que reduce el tamaño de la imagen y acelera el proceso de construcción.


compose.yaml:
Este archivo `docker-compose.yml` define dos servicios: `web` y `redis`. El servicio `web` se construye a partir del directorio actual (`.`) y se expone en el puerto 80. El servicio `redis` utiliza la imagen oficial de Redis para Alpine Linux.