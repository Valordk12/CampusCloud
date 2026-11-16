USE CampusCloud2;
GO

INSERT INTO Estudiantes (id_estudiante, matricula, nombre, correo)
VALUES (1,'2026001', 'Ana Lopez', 'ana@universidad.com'),
	   (2,'2026002', 'Carlos Hernandez', 'carlos@universidad.com');
GO

INSERT INTO Servicios(id_servicio,nombre,descripcion)
VALUES (1,'Constancia de Estudios', 'Solicitud de constancia académica'),
	   (2,'Prestamo de Laboratorio', 'Se Reservo equipo o espacio de laboratorio');
	   GO

INSERT INTO Solicitudes(id_solicitud,id_estudiante,id_servicio, fecha,estado)
VALUES (1001, 1,1,'2026-10-21','Pendiente'),
	   (1002, 2,2,'2026-10-22','Pendiente');
	   GO

SELECT * FROM Estudiantes;
SELECT * FROM Servicios;
SELECT * FROM Solicitudes;