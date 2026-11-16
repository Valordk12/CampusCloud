use empresaVentas;
GO

SELECT 
SUSER_NAME() AS LoginActual,
USER_NAME() AS UsuarioActual,
DB_NAME() AS BaseActual

SELECT * FROM dbo.productos;
SELECT * FROM dbo.ventas;
SELECT * FROM dbo.cliente;
SELECT * FROM rh.nomina;

INSERT INTO dbo.ventas
VALUES (6,1,'2026-10-14', 2500.00)

INSERT INTO dbo.productos
VALUES (6, 'Tablet', 785.36, 34);

--Operaciones no permitidas
UPDATE dbo.ventas
SET Total = 30000.0
WHERE IdVentas = 6;
GO

DELETE FROM dbo.ventas
WHERE IdVentas = 6;
GO