-- 1. Gestión de Roles Fijos

-- A a nivel de servidor
USE master;
GO

CREATE LOGIN admin_sql2
WITH PASSWORD = 'p@SSWORD';
GO

-- AGREGAR UN INICIO DE SESION (LOGIN) AL ROL DE ADMINISTRADOR DE SERVIDOR
ALTER SERVER ROLE sysadmin
ADD MEMBER admin_sql2;
GO

CREATE LOGIN admin_sql3
WITH PASSWORD = 'p@SSWORD';
GO

-- AGREGAR AL ROL DE CREADOR DE BASE DE DATOS
ALTER SERVER ROLE dbcreator 
ADD MEMBER admin_sql3;
GO

DROP LOGIN admin_sql3;
GO

-- B A nivel de base de datos
USE CampusCloud2;
GO

CREATE USER admin_sql3
FOR LOGIN admin_sql3;
GO

DROP USER lector_campus;
GO

-- Permitir solo lecturra (Select en todas las tablas y vistas)
ALTER ROLE db_datareader
ADD MEMBER admin_sql3;
GO

EXECUTE AS USER = 'admin_sql3';

SELECT * FROM servicios;

DELETE FROM servicios 
WHERE id_servicio = 1;

ALTER ROLE db_datareader
DROP MEMBER admin_sql3;

ALTER ROLE db_datawriter
DROP MEMBER admin_sql3;

ALTER ROLE db_ddladmin
DROP MEMBER admin_Sql3;

-- Permitir solo escritura (INSERT, UPDATE, DELETE en todas las tablas)
ALTER ROLE db_datawriter
ADD MEMBER admin_sql3;

ALTER ROLE db_datareader
ADD MEMBER admin_sql3;

ALTER ROLE db_ddladmin
ADD MEMBER admin_sql3;
GO

EXECUTE AS USER = 'admin_sql3';

SELECT SUSER_NAME() AS [LOGIN],
USER_NAME() AS [USUARIO_ACTUAL];

SELECT * FROM Servicios;

INSERT INTO Servicios
VALUES (4, 'Cafeteria', 'Pura comida buena');

UPDATE Servicios
SET nombre = 'Cafeteria2'
WHERE id_servicio = 4;

DELETE FROM Servicios
WHERE id_servicio = 4;

SELECT* FROM Servicios

SELECT 
pr.name AS Principal,
pe.permission_name AS Permiso,
pe.state_desc AS estado,
OBJECT_NAME(pe.major_id) AS Objeto
FROM sys.database_permissions AS pe
INNER JOIN sys.database_principals AS pr
ON pe.grantee_principal_id = pr.principal_id
WHERE pr.name = 'admin_sql3';
GO

-- permite administración de objetos (DDL: create, drop)

SELECT * FROM Servicios;

CREATE TABLE prueba (
id INT NOT NULL,
nombre VARCHAR(100)
);
GO

ALTER TABLE prueba
ADD edad INT NOT NULL

DROP TABLE prueba;


REVERT;
GO

