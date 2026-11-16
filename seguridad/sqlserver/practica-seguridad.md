# Administración de seguridad en SQLSERVER

## Fundamentos 

| Concepto | Nivel | Propósito | Ejemplo |
| --- | --- | --- | --- |
|**Login**| Instancia de SQL Server | Autenticar una identidad ante el Servidor | `àdmin_sql` |
|**User**| Base de datos | Representa la identidad ante el servidor | `dbo` |
|**Rol de Servidor**|Instancia |Agrupa privilegioos administrados a nivel de servidor | `sysadmin` |
|**Base de Datos Actual**| Sesión | Determinar el contexto de ejecución de una consulta | `master` |


# 1. Diagnóstico de la conexión Administrativa

```sql

-- Comprobar el login actual

SELECT SUSER_NAME () AS LoginActual;
GO

-- Verificar los privilegios sysadmin(rol de servidor)

SELECT IS_SRVROLEMEMBER('sysadmin') AS [EsSysAdmin];
GO
```


| Resultado | Interpretación |
| --- | --- | 
|1|Pertenece al rol consultado|
|0|No pertenece a ese rol|
|NULL|No se puede determinar|

```sql

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

```

| Resultado | Interpretación |
| --- | --- | 
|name|Nombre del principal|
|type_desc|Tipo de principal, para este caso el principal es SQL_LOGIN|
|is_disabled|significa habilidado y el 1 deshabilidado|


```sql

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

```

## CREACIÓN Y PRUEBA DE UN ADMINISTRADOR ALTERNATIVO

```sql
-- Para hacer un login siempre debemos estar en master

USE master;
GO

-- crear el login admin_Sql

CREATE LOGIN admin_sql
WITH PASSWORD = 'Admin@cloud#12',
CHECK_POLICY = ON;
```

`CREATE LOGIN admin_sql` : Crea una identidad que puede autenticarse ante la instancia del servidor

`WITH PASSWORD` : Define una constraseña de autenticación SQL Server

`CHECK_POLICY = ON` : Solcita aplicar la política de contraseña correspondiente cuando está disponible

```sql
-- Verificar si existe y esta habilitado

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
```

## DESABILITACIÓN CONTROLADA DE SA

```sql
use master;
go

SELECT 
SUSER_NAME () AS LoginActual,
USER_NAME () AS UsuarioActual,
DB_NAME () AS BaseActual,
IS_SRVROLEMEMBER ('sysadmin') AS EsSysAdmin;
GO

-- Deshabilitación controlada de sa

SELECT
	name,
	type_desc,
	is_disabled
FROM sys.server_principals
WHERE name = 'sa';

-- Deshabilita sa

ALTER LOGIN sa DISABLE;
```