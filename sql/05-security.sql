USE master;
GO

-- Crear un login
CREATE LOGIN consulta_campus
WITH PASSWORD = 'P@sswordConsulta123!';
GO

-- SELECCIONAMOS CampusCloud2 y creamos el usuario Asociado
USE CampusCloud2;
GO

CREATE USER consulta_campus
FOR LOGIN consulta_campus;
GO

-- CREAR ROL rol_consulta
CREATE ROLE rol_consulta;
GO

-- Permisos de lectura
GRANT SELECT TO rol_consulta;
GO

-- Agregamos el usuario  al rol
ALTER ROLE rol_consulta 
ADD MEMBER consulta_campus;
GO

-- Login Operador

USE master;
GO

CREATE LOGIN operador_campus
WITH PASSWORD = 'P@sswordOperador123!';
GO

USE CampusCloud2;
GO

CREATE USER operador_campus
FOR LOGIN operador_campus;
GO

CREATE ROLE rol_operador;
GO

GRANT SELECT, INSERT, UPDATE 
TO rol_operador ;
GO

ALTER ROLE rol_operador
ADD MEMBER operador_campus;
GO

USE master;
GO

CREATE LOGIN admin_campus
WITH PASSWORD = 'P@sswordAdmin123!';
GO

USE CampusCloud2;
GO

CREATE USER admin_campus
FOR LOGIN admin_campus;
GO

ALTER ROLE db_owner
ADD MEMBER admin_campus;
GO