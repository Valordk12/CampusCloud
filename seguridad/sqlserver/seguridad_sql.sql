-- Comprobar el login actual

SELECT SUSER_NAME () AS LoginActual;
GO

-- Verificar los privilegios sysadmin(rol de servidor)

SELECT IS_SRVROLEMEMBER('sysadmin') AS [EsSysAdmin];
GO

-- 1 -> Pertenece al rol consultado
-- 0 -> No pertenece a ese rol
-- NULL -> No se puede determinar

SELECT  
	SUSER_NAME () AS LoginActual,
	IS_SRVROLEMEMBER('sysadmin') AS [EsSysAdmin];
GO

-- Consultar el estado de sa

SELECT
	name,
	type_desc,
	is_disabled
FROM sys.server_principals
WHERE name = 'sa';

-- name -> Nombre del principal
-- type-desc -> Tipo de principal, para este caso el principal es SQL_LOGIN
-- is_disabled -> 0 significa habilidado y el 1 deshabilidado

-- Verificar la base de datos actual

SELECT 
	DB_NAME() AS BaseActual;
GO

-- Consulta completa del contexto

SELECT
	SUSER_NAME() AS LoginACtual,
	USER_NAME () AS UsuarioBase,
	DB_NAME () AS BaseActual,
	IS_SRVROLEMEMBER ('sysadmin') AS EsSysAdmin;

-- Creaci�n y Prueba de un administrador alternativo

-- Para hacer un login siempre debemos estar en master

USE master;
GO

-- crear el login admin_Sql

CREATE LOGIN admin_sql
WITH PASSWORD = 'Admin@cloud#12',
CHECK_POLICY = ON;

-- Verificar si existe y est� habilitado

SELECT
	name,
	type_desc,
	is_disabled
FROM sys.server_principals
WHERE name = 'admin_Sql';
GO

-- Demostrar que crear un login no lo hace administrado

SELECT IS_SRVROLEMEMBER('sysadmin', 'admin_sql') AS EsSysAdmin

-- Agregar adin_Sql al rol de servidor sysadmin

ALTER SERVER ROLE sysadmin
ADD MEMBER admin_sql;
GO

-- Validar la nueva membresia

SELECT IS_SRVROLEMEMBER('sysadmin', 'admin_sql') AS EsSysAdmin

