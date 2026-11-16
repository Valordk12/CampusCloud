# Scripts de Operaciones MongoDB — CampusCloud

## Inserción de 6 documentos

```json
[
    {
      "servicio_id": "SRV-SQL-001",
      "tipo": "curso",
      "nombre": "Arquitectura de Bases de Datos",
      "metadata": {
        "nivel": "Avanzado",
        "duracion_horas": 40,
        "instructor": "Agente Coulson"
      },
      "etiquetas": ["sql", "nosql", "arquitectura"],
      "activo": true
    },
    {
      "servicio_id": "SRV-SQL-002",
      "tipo": "curso",
      "nombre": "Seguridad en la Nube",
      "metadata": {
        "nivel": "Intermedio",
        "duracion_horas": 30,
        "instructor": "Agente May"
      },
      "etiquetas": ["cloud", "Seguridad", "devops"],
      "activo": true
    },
    {
      "servicio_id": "SRV-LAB-101",
      "tipo": "laboratorio",
      "nombre": "Laboratorio de Contenedores Docker",
      "metadata": {
        "capacidad_maxima": 25,
        "plataforma": "Linux/Docker"
      },
      "equipamiento": ["Servidor dedicado", "IP estática", "SSD 50GB"],
      "activo": true
    },
    {
      "servicio_id": "SRV-LAB-102",
      "tipo": "laboratorio",
      "nombre": "Laboratorio de Redes Virtuales",
      "metadata": {
        "capacidad_maxima": 15,
        "plataforma": "Cisco Packet Tracer"
      },
      "equipamiento": ["Simulador de red", "Firewall virtual"],
      "activo": true
    },
    {
      "servicio_id": "SRV-ASE-201",
      "tipo": "asesoria",
      "nombre": "Consultoría de Migración NoSQL",
      "metadata": {
        "modalidad": "Remota",
        "prioridad": "Alta"
      },
      "requisitos_previos": ["Inventario de datos", "Esquema actual"],
      "activo": false
    },
    {
      "servicio_id": "SRV-ASE-202",
      "tipo": "asesoria",
      "nombre": "Auditoría de Seguridad y Cifrado",
      "metadata": {
        "modalidad": "Presencial",
        "prioridad": "Crítica"
      },
      "requisitos_previos": ["Llaves SSH", "Permisos root"],
      "activo": true
    }
  ]
```

## Consultas


### Consulta 1: Filtrar por tipo de servicio
```json
db.detalles_extendidos.find({"tipo": "laboratorio"});
```

### Consulta 2: Filtrar por un elemento dentro de un Array
```json
db.detalles_extendidos.find({ "etiquetas": "Seguridad" })
```

### Consulta 3: Filtrar utilizando campos de un Subdocumento
```json
db.detalles_extendidos.find({ "metadata.prioridad": "Crítica" })
``` 

### Consulta 4: Filtrar por campo booleano
```json
db.detalles_extendidos.find({ "activo": true })
```

## Actualización controlada
Modificar el estado activo a true y actualizar la prioridad dentro del subdocumento metadata para el servicio con "servicio_id": "SRV-ASE-201"

```json
db.detalles_extendidos.updateOne(
  { "servicio_id": "SRV-ASE-201" },
  { $set: { "activo": true, "metadata.prioridad": "Media" } }
);
```

## Eliminación por identificador 
Eliminar un documento específico utilizando su identificador único dentro de la colección: "SRV-LAB-102"

```json
db.detalles_extendidos.deleteOne({ "servicio_id": "SRV-LAB-102" });
```

## Agregación sencilla
Utilizar el framework de agregación para agrupar los documentos por su tipo ($group) y contar cuántos existen en cada categoría

```json
db.detalles_extendidos.aggregate([
  { 
    $group: { 
      _id: "$tipo", 
      total_servicios: { $sum: 1 } 
    } 
  },
  { 
    $sort: { total_servicios: -1 } 
  }
]);
```