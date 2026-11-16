-- Seleccionar a master y crear ka base de datis

USE master;
GO

CREATE DATABASE empresaVentas;
GO

-- Verificar que la base de datos existe

SELECT
	name,
	state_desc
FROM sys.databases
WHERE name = 'empresaVentas'
GO

use empresaVentas;
GO

CREATE TABLE dbo.productos (
	Idproductos INT PRIMARY KEY,
	Nombre VARCHAR (100) NOT NULL,
	Precio DECIMAL (10,2) NOT NULL,
	Existencia INT NOT NULL
);
GO

CREATE TABLE dbo.cliente (
	IdCliente INT PRIMARY KEY,
	Nombre VARCHAR (100) NOT NULL,
	Correo VARCHAR (150)
);
GO

CREATE TABLE dbo.ventas (
	IdVentas INT PRIMARY KEY,
	IdCliente INT NOT NULL,
	Fecha DATE NOT NULL,
	Total DECIMAL (10,2) NOT NULL
);
GO

CREATE SCHEMA rh --Dar permisos a nivel de esquema
GO

CREATE TABLE rh.nomina (
	id INT PRIMARY KEY IDENTITY(1,1),
	numero_nomina VARCHAR(50) NOT NULL UNIQUE,
	total DECIMAL(10,2) NOT NULL 
	CHECK (total > 0.0)
);

INSERT INTO dbo.productos (Idproductos,Nombre, Precio, Existencia)
VALUES
(1, 'Laptop', 18000.0, 10),
(2, 'Monitor', 4500.0, 20),
(3, 'Tec', 850.00, 35),
(4, 'Mouse', 450.0, 50),
(5, 'Impresora', 6200.00, 8);

INSERT INTO dbo.cliente (IdCliente, Nombre,Correo)
VALUES
(1, 'Empresa Alfa', 'Contacto@gamil.com'),
(2, 'Empresa Beta', 'ventas@gmail.com'),
(3, 'Comercial Gamma', 'compras@gamma.com'),
(4, 'Servicios Delta', 'contacto@delta.com'),
(5, 'Industrias Omega', 'ventas@omega.com');

INSERT INTO dbo.ventas (IdVentas, IdCliente, Fecha, Total)
VALUES (1,1,'2026-10-01', 18000.0),
	   (2,2,'2026-10-02', 4500),
       (3,3,'2026-10-03', 1300);

SELECT * FROM productos
SELECT *FROM ventas
SELECT * FROM cliente

-- Crear login operativo vendedor1

-- 1.- Usar master
USE master;
GO

SELECT DB_NAME() AS [Base de datos actual];
GO

-- Crear login desde un usuario administrador

CREATE LOGIN vendedor1
WITH PASSWORD = 'v@ndedor#1',
CHECK_POLICY = ON;
GO

--	Verificar que el login existe
SELECT 
	name, 
	type_desc,
	is_disabled
FROM sys.server_principals
WHERE name = 'vendedor1';
GO

-- Verificar que este login no sea sysadmin
SELECT 
	IS_SRVROLEMEMBER ('sysadmin', 'vendedor1') AS EsSysAdmin;
GO

-- Crear el usuario asociado al login

USE empresaVentas;
GO

CREATE USER vendedor1
FOR LOGIN vendedor1;

SELECT 
	name,
	type_desc,
	authentication_type_desc
FROM sys.database_principals
WHERE name = 'vendedor1';

-- Concederle permisos de SELECT directamente al usuario

GRANT SELECT 
ON dbo.productos
TO vendedor1;
GO

REVOKE SELECT 
ON dbo.productos
FROM vendedor1;
GO

SELECT 
pr.name AS Principal,
pe.permission_name AS Permiso,
pe.state_desc AS estado,
OBJECT_NAME(pe.major_id) AS Objeto
FROM sys.database_permissions AS pe
INNER JOIN sys.database_principals AS pr
ON pe.grantee_principal_id = pr.principal_id
WHERE pr.name = 'vendedor1';
GO

-- Conceder varios permisos al usuario

GRANT SELECT
ON dbo.productos
TO vendedor1;
GO

GRANT SELECT
ON dbo.cliente
TO vendedor1;
GO

GRANT SELECT
ON dbo.ventas
TO vendedor1;
GO

GRANT INSERT
ON dbo.ventas
TO vendedor1;
GO

GRANT INSERT
ON rh.nomina
TO vendedor1;
GO

-- Crear un rol vendedor y administraci�n de permisos mediante roles

USE empresaVentas;

-- Crear el rol
CREATE ROLE rol_vendedor;
GO

-- Verificar el rol
SELECT
	name,
	type_desc
FROM sys.database_principals
WHERE name = 'rol_vendedor';
GO

-- Quitar el permiso de SELECTS a iNSERTS a vendedor1 de las tablas productos, ventas y cliente
REVOKE SELECT
ON dbo.productos
FROM vendedor1;
GO

REVOKE SELECT
ON dbo.ventas
FROM vendedor1;
GO

REVOKE SELECT 
ON dbo.cliente
FROM vendedor1;
GO

REVOKE SELECT 
ON rh.nomina
FROM vendedor1;
GO

REVOKE INSERT 
ON dbo.ventas
FROM vendedor1;
GO

-- Agregar vendedor1 al rol rol_vendedor
ALTER ROLE rol_vendedor
ADD MEMBER vendedor1;
GO

ALTER ROLE rol_vendedor
ADD MEMBER vendedor2;
GO

-- Verificar la membresia del usuario en el rol

SELECT
	r.name AS [Rol],
	u.name AS [Usuario]
FROM sys.database_role_members AS drm
INNER JOIN sys.database_principals AS r
ON drm.role_principal_id = r.principal_id
INNER JOIN sys.database_principals AS u
ON drm.member_principal_id = u.principal_id
WHERE r.name = 'rol_vendedor';
GO

-- Conceder permisos de SELECT sobre las tablas de empresaVentas al ROL

GRANT SELECT
ON dbo.productos
TO rol_vendedor;
GO

GRANT SELECT
ON dbo.ventas
TO rol_vendedor;
GO

GRANT SELECT, INSERT, UPDATE
ON dbo.cliente
TO rol_vendedor;
GO

GRANT SELECT
ON rh.nomina
TO rol_vendedor;
GO

-- Crear login de vendedor2

USE master;
GO

CREATE LOGIN vendedor2
WITH PASSWORD = 'v@ndedor#2',
CHECK_POLICY = ON;
GO

-- Crear un user vendedor2 asociado a el login vendedor2
-- Los users son por base de datos

USE empresaVentas;
GO

CREATE USER vendedor2
FOR LOGIN vendedor2;

-- Agregar como miembro del rol rol_vendedor al user vendedor2
ALTER ROLE rol_vendedor
ADD MEMBER vendedor2;
GO

-- Consulta para saber los permisos que tiene ese rol

SELECT 
pr.name AS Principal,
pe.permission_name AS Permiso,
pe.state_desc AS estado,
OBJECT_NAME(pe.major_id) AS Objeto
FROM sys.database_permissions AS pe
INNER JOIN sys.database_principals AS pr
ON pe.grantee_principal_id = pr.principal_id
WHERE pr.name = 'rol_vendedor';
GO