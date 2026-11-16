# Neo4j (CampusCloud)

## 📋 Requisitos Previos
Para ejecutar este compose, es necesario crear previamente el volumen donde se almacenarán los datos:

```bash
docker volume create "nombre del volumen"
```

También debes crear la red con la cual dicho servicio podrá estar en conexión con otros servicios:

```bash
docker network create "nombre de la red"
```

## ⚙️ Instrucciones de Operación

### 1. Configurar variables de entorno
Dentro de la carpeta de **neo4j** se encuentra el archivo **.env**, el cual contiene las variables de entorno necesarias para ejecutar el servicio:

#### Variables de entorno de Neo4j
```bash
# ==========================================
# NEO4J
# ==========================================
NEO4J_AUTH="usuario/contraseña"
NEO4J_PORT1="puerto"
NEO4J_PORT2="puerto"
```

#### Variables de entorno de red y volumen
```bash
# ==========================================
# RED
# ==========================================
DOCKER_NETWORK="nombre de la red"

#===========================================
# VOLUMEN
# ==========================================
NEO4J_VOLUME="nombre del volumen"
```

### 2. Iniciar el gestor
Despliega el contenedor de Neo4j en segundo plano utilizando el siguiente comando en la terminal:

```bash
docker compose up -d
```

*Nota:* Asegúrate de estar dentro de la carpeta donde se encuentra el archivo docker-compose.yml; de lo contrario, el servicio no se levantará.

### 3. Verificar el estado del servicio
Comprueba que el contenedor se encuentre ejecutándose correctamente con el comando:

```bash
docker compose ps
```

### 4. Detener el gestor
Para detener el servicio de forma segura, utiliza el siguiente comando:

```bash
docker compose down
```

## 🔒 Seguridad
- El archivo `.env.example` Incluye únicamente variables de referencia **sin credenciales reales**
- El archivo `.env` con credenciales reales y la carpeta de datos local se encuentran excluidos mediante `.gitignore` para evitar filtrar las claves de seguridad en Git

