-- Permisos sobre tablas y vistas
-- Asignación directa a usuarios o roles sobre tablas especificas

EXECUTE AS USER = 'admin_sql3';

SELECT SUSER_NAME() AS [LOGIN],
USER_NAME() AS [USUARIO_ACTUAL];

REVERT;
GO

USE CampusCloud2;
GO

CREATE VIEW v_solicitues_2026
AS
SELECT e.nombre, s.fecha, s.estado
FROM Estudiantes AS e
INNER JOIN Solicitudes AS s
ON e.id_estudiante = s.id_estudiante
WHERE DATEPART(YEAR, s.fecha) = '2026';

SELECT * FROM v_solicitues_2026;

-- Permitir la lectura en una tabla especifica
GRANT SELECT ON dbo.estudiantes TO admin_sql3;

EXECUTE AS USER = 'admin_sql3';

SELECT * FROM Servicios;

REVERT; 
GO

-- Permitir inserción y actualización en una tabla (servicios)
GRANT INSERT, UPDATE ON dbo.servicios TO admin_sql3;

GRANT SELECT ON dbo.servicios TO admin_sql3;

EXECUTE AS USER = 'admin_sql3';

SELECT * FROM Estudiantes

INSERT INTO Servicios 
VALUES (5, 'Becas', 'Mucho Dinero');

UPDATE Servicios
SET descripcion = 'Poco Dinero'
WHERE id_servicio = 5

REVERT;
GO

-- Permiso total de codigo sql DML sobre una tabla
GRANT SELECT, INSERT, UPDATE, DELETE ON dbo.solicitudes TO admin_sql3;

SELECT * FROM Solicitudes;

INSERT INTO Solicitudes
VALUES (1003, 2, 1,'2026-10-23', 'Terminado');

UPDATE Solicitudes
SET estado = 'Pendiente'
WHERE id_solicitud = 1003;

DELETE Solicitudes
WHERE id_solicitud = 1003;

-- Denegar explicitamente la eliminación de registro (Bloque)
DENY DELETE ON dbo.solicitudes TO admin_sql3;

EXECUTE AS USER = 'admin_sql3';

-- Quitar los permisos 
REVOKE UPDATE, DELETE, INSERT, SELECT ON dbo.solicitudes from admin_sql3;

REVERT;
GO

