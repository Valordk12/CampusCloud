# Scripts de Operaciones Neo4j — CampusCloud

## Creación de nodos Estudiante
```cypher
CREATE (e1:Estudiante {estudiante_id: "EST-001", nombre: "Peter Parker", carrera: "Ingeniería de Software", semestre: 4, afinidad: "IA"})
CREATE (e2:Estudiante {estudiante_id: "EST-002", nombre: "Wanda Maximoff", carrera: "Ciencia de Datos", semestre: 6, afinidad: "Ciberseguridad"})
CREATE (e3:Estudiante {estudiante_id: "EST-003", nombre: "Shuri Udaku", carrera: "Arquitectura Cloud", semestre: 8, afinidad: "Hardware"})
CREATE (e4:Estudiante {estudiante_id: "EST-004", nombre: "Kamala Khan", carrera: "Desarrollo Web", semestre: 2, afinidad: "Frontend"})
CREATE (e5:Estudiante {estudiante_id: "EST-005", nombre: "Miles Morales", carrera: "Redes y Seguridad", semestre: 3, afinidad: "IA"})
```

## Creación de nodos Servicio
```cypher
CREATE (s1:Servicio {servicio_id: "SRV-SQL-001", nombre: "Arquitectura de Bases de Datos", tipo: "curso", nivel: "Avanzado"})
CREATE (s2:Servicio {servicio_id: "SRV-LAB-101", nombre: "Laboratorio de Contenedores Docker", tipo: "laboratorio", capacidad: 25})
CREATE (s3:Servicio {servicio_id: "SRV-ASE-202", nombre: "Auditoría de Seguridad y Cifrado", tipo: "asesoria", modalidad: "Presencial"})
CREATE (s4:Servicio {servicio_id: "SRV-SQL-002", nombre: "Seguridad en la Nube", tipo: "curso", nivel: "Intermedio"})
```

## Creación de relaciones USA con propiedades
```cypher
CREATE (e1)-[:USA {fecha_inicio: "2026-09-01", estado: "Activo", progreso: 85}]->(s1)
CREATE (e1)-[:USA {fecha_inicio: "2026-09-10", estado: "Activo", progreso: 60}]->(s2)
CREATE (e2)-[:USA {fecha_inicio: "2026-08-15", estado: "Completado", progreso: 100}]->(s3)
CREATE (e2)-[:USA {fecha_inicio: "2026-09-05", estado: "Activo", progreso: 75}]->(s4)
CREATE (e3)-[:USA {fecha_inicio: "2026-08-20", estado: "Completado", progreso: 100}]->(s1)
CREATE (e3)-[:USA {fecha_inicio: "2026-09-01", estado: "Activo", progreso: 90}]->(s2)
CREATE (e3)-[:USA {fecha_inicio: "2026-09-12", estado: "Activo", progreso: 50}]->(s3)
CREATE (e4)-[:USA {fecha_inicio: "2026-10-01", estado: "Activo", progreso: 40}]->(s2)
CREATE (e5)-[:USA {fecha_inicio: "2026-09-15", estado: "Activo", progreso: 70}]->(s1)
CREATE (e5)-[:USA {fecha_inicio: "2026-10-05", estado: "Activo", progreso: 30}]->(s4);
```


## Consultas

### Consulta 1: Servicios usados por un estudiante específico
Permite consultar qué servicios está consumiendo un estudiante en particular (por ejemplo, Peter Parker), mostrando detalles de la relación como el progreso y el estado

```cypher
MATCH (e:Estudiante {nombre: "Peter Parker"})-[r:USA]->(s:Servicio)
RETURN e.nombre AS Estudiante, 
       s.nombre AS Servicio, 
       s.tipo AS Tipo, 
       r.estado AS Estado, 
       r.progreso AS Progreso_Porcentaje;
```

### Consulta 2: Estudiantes que comparten un servicio
Agrupa los servicios para identificar qué estudiantes están inscritos o utilizando exactamente el mismo recurso (ideal para ver afinidades de grupo)

```cypher
MATCH (e:Estudiante)-[r:USA]->(s:Servicio)
RETURN s.nombre AS Servicio, 
       collect(e.nombre) AS Estudiantes_Inscritos, 
       count(e) AS Total_Estudiantes;
```

### Consulta 3: Recomendación básica basa en relaciones
Recomienda servicios a un estudiante basándose en lo que otros compañeros (con quienes comparte al menos un servicio en común) están utilizando, pero que él o ella aún no ha tomado.

```cypher
MATCH (objetivo:Estudiante {nombre: "Peter Parker"})-[:USA]->(:Servicio)<-[:USA]-(companero:Estudiante)-[:USA]->(recomendado:Servicio)
WHERE NOT (objetivo)-[:USA]->(recomendado)
RETURN DISTINCT recomendado.nombre AS Servicio_Recomendado, 
       recomendado.tipo AS Categoria, 
       collect(DISTINCT companero.nombre) AS Recomendado_Por_Conexion_Con;
```

## Actualización controlada
Se actualiza la relación entre Peter Parker (EST-001) y el Laboratorio de Contenedores Docker (SRV-LAB-101) para reflejar que la actividad ha sido completada al 100%.


```cypher
MATCH (e:Estudiante {estudiante_id: "EST-001"})-[r:USA]->(s:Servicio {servicio_id: "SRV-LAB-101"})
SET r.progreso = 100, r.estado = "Completado"
RETURN e.nombre AS Estudiante, 
       s.nombre AS Servicio, 
       r.estado AS Nuevo_Estado, 
       r.progreso AS Nuevo_Progreso;
```