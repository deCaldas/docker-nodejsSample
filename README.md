# Sample Node.js application
This repository is a sample Node.js application for Docker's documentation.

# Dockerfile con comentarios explicando cada sección:

1. Se utiliza una variable de argumento `NODE_VERSION` para especificar la versión de Node que se usará en el contenedor.
2. La primera etapa `base` define el directorio de trabajo y expone el puerto 3000, comúnmente utilizado para aplicaciones web.
3. La etapa `dev` se enfoca en el desarrollo, instalando las dependencias de desarrollo y estableciendo el usuario "node" para mayor seguridad.
4. La etapa `prod` se orienta a la producción, configurando la variable de entorno `NODE_ENV` como "production" y también estableciendo el usuario "node" para seguridad.
5. Se utilizan comandos para copiar el código fuente a las imágenes respectivas en ambas etapas.
6. Los comandos `CMD` difieren entre las etapas para reflejar los modos de desarrollo y producción.

Este Dockerfile sigue buenas prácticas, utiliza variables de entorno, y define dos etapas para facilitar el desarrollo y producción de la aplicación. También se ajusta a la exposición de puertos y el uso de volúmenes para almacenar datos persistentes estándares en contenedores. Además, ten en cuenta que debes configurar los secretos de acuerdo con tus necesidades específicas, lo cual no está reflejado en el Dockerfile.

## .dockerignore:
Este archivo `.dockerignore` excluye los archivos `node_modules` y `npm-debug.log` del contexto de construcción de Docker. Esto significa que estos archivos no se incluirán en la imagen de Docker, lo que reduce el tamaño de la imagen y acelera el proceso de construcción.

## compose.yaml:
Este archivo `docker-compose.yml` con comentarios explicando cada sección y por qué se necesita, está diseñado para orquestar dos servicios: el servidor de la aplicación y una base de datos PostgreSQL. Se utilizan variables de entorno para configurar la aplicación y secretos para proteger información confidencial como contraseñas. Además, se implementa una comprobación de salud para garantizar que la base de datos esté funcionando correctamente, y solo se exponen los puertos necesarios. Los datos de la base de datos se almacenan de manera persistente en un volumen separado.