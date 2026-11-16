-- Creación del keyspace
CREATE KEYSPACE campuscloud_eventos
WITH replication = {'class': 'SimpleStrategy', 'replication_factor': 1};

USE campuscloud_eventos;

-- Creación de la tabla eventos_estudiante
CREATE TABLE eventos_estudiante (
estudiante_id text,
nombre_Estudiante text,
fecha_evento date,
evento_id timeuuid,
tipo_evento text,
detalles text,
PRIMARY KEY ((estudiante_id), fecha_evento, evento_id)
)WITH CLUSTERING ORDER BY (fecha_evento DESC, evento_id DESC);

SELECT * FROM eventos_estudiante

-- Inserción de 12 eventos
INSERT INTO eventos_estudiante (estudiante_id, nombre_estudiante, fecha_evento, evento_id, tipo_evento, detalles) 
VALUES ('EST-001', 'Peter Parker', '2026-10-01', now(), 'LOGIN', 'Inicio de sesión desde la app móvil');

INSERT INTO eventos_estudiante (estudiante_id, nombre_estudiante, fecha_evento, evento_id, tipo_evento, detalles) 
VALUES ('EST-001', 'Peter Parker', '2026-10-05', now(), 'ACCESO_CURSO', 'Inscripción a Arquitectura de Bases de Datos');

INSERT INTO eventos_estudiante (estudiante_id, nombre_estudiante, fecha_evento, evento_id, tipo_evento, detalles) 
VALUES ('EST-001', 'Peter Parker', '2026-10-12', now(), 'ENTREGA_TAREA', 'Subida de práctica Docker');

INSERT INTO eventos_estudiante (estudiante_id, nombre_estudiante, fecha_evento, evento_id, tipo_evento, detalles) 
VALUES ('EST-001', 'Peter Parker', '2026-10-20', now(), 'LOGOUT', 'Cierre de sesión');

-- Estudiante 2: Wanda Maximoff (EST-002) - 4 eventos
INSERT INTO eventos_estudiante (estudiante_id, nombre_estudiante, fecha_evento, evento_id, tipo_evento, detalles) 
VALUES ('EST-002', 'Wanda Maximoff', '2026-10-02', now(), 'LOGIN', 'Inicio de sesión desde portal web');

INSERT INTO eventos_estudiante (estudiante_id, nombre_estudiante, fecha_evento, evento_id, tipo_evento, detalles) 
VALUES ('EST-002', 'Wanda Maximoff', '2026-10-06', now(), 'ACCESO_LAB', 'Reserva de Laboratorio Cifrado');

INSERT INTO eventos_estudiante (estudiante_id, nombre_estudiante, fecha_evento, evento_id, tipo_evento, detalles) 
VALUES ('EST-002', 'Wanda Maximoff', '2026-10-15', now(), 'CONSULTA_RECURSOS', 'Descarga de manual de seguridad');

INSERT INTO eventos_estudiante (estudiante_id, nombre_estudiante, fecha_evento, evento_id, tipo_evento, detalles) 
VALUES ('EST-002', 'Wanda Maximoff', '2026-10-21', now(), 'LOGOUT', 'Cierre de sesión');

-- Estudiante 3: Shuri Udaku (EST-003) - 4 eventos
INSERT INTO eventos_estudiante (estudiante_id, nombre_estudiante, fecha_evento, evento_id, tipo_evento, detalles) 
VALUES ('EST-003', 'Shuri Udaku', '2026-10-03', now(), 'LOGIN', 'Inicio de sesión CLI');

INSERT INTO eventos_estudiante (estudiante_id, nombre_estudiante, fecha_evento, evento_id, tipo_evento, detalles) 
VALUES ('EST-003', 'Shuri Udaku', '2026-10-08', now(), 'MODIFICACION_PERFIL', 'Actualización de clave de cifrado');

INSERT INTO eventos_estudiante (estudiante_id, nombre_estudiante, fecha_evento, evento_id, tipo_evento, detalles) 
VALUES ('EST-003', 'Shuri Udaku', '2026-10-14', now(), 'ACCESO_CURSO', 'Ingreso a módulo Cloud avanzado');

INSERT INTO eventos_estudiante (estudiante_id, nombre_estudiante, fecha_evento, evento_id, tipo_evento, detalles) 
VALUES ('EST-003', 'Shuri Udaku', '2026-10-22', now(), 'LOGOUT', 'Cierre de sesión');


-- Consulta de Actividad en un Intervalo Compatible con la Clave
SELECT fecha_evento, tipo_evento, detalles 
FROM eventos_estudiante 
WHERE estudiante_id = 'EST-001' 
  AND fecha_evento >= '2026-10-01' 
  AND fecha_evento <= '2026-10-15';

-- Actualización Controlada 
UPDATE eventos_estudiante
SET detalles = 'Inicio de sesión verificador con doble factor (2FA)'
WHERE estudiante_id = 'EST-001'
AND fecha_evento = '2026-10-01'
AND evento_id = 5c76f550-e171-11f1-94af-759f799efd7f;

-- Verificar los resultados del UPDATE consulta el registro
SELECT fecha_evento, tipo_evento, detalles 
FROM eventos_estudiante 
WHERE estudiante_id = 'EST-001' 
AND fecha_evento = '2026-10-01';

SELECT * FROM eventos_estudiante

-- Eliminación Contralada
DELETE FROM eventos_estudiante 
WHERE estudiante_id = 'EST-001' 
AND fecha_evento = '2026-10-20' 
AND evento_id = 5cc58a80-e171-11f1-94af-759f799efd7f;

-- Verificar los resultados del DELETE consultando todo el historial del estudiante para comprobar que desapareció
SELECT fecha_evento, tipo_evento, detalles 
FROM eventos_estudiante 
WHERE estudiante_id = 'EST-001';
