
use bolsaempleo;

CREATE TABLE postulante (
  idpostulantes int NOT NULL AUTO_INCREMENT,
  especialidad varchar(45) DEFAULT NULL,
  experiencia int DEFAULT NULL,
  estado varchar(45) DEFAULT NULL,
  idpersonas int DEFAULT NULL,
  PRIMARY KEY (idpostulantes)
)
ENGINE = INNODB,
CHARACTER SET utf8mb4,
COLLATE utf8mb4_0900_ai_ci,
ROW_FORMAT = DYNAMIC;

--
-- Create foreign key
--
ALTER TABLE postulante
ADD COLUMN nombres VARCHAR(100) DEFAULT NULL,
ADD COLUMN apellidos VARCHAR(100) DEFAULT NULL,
ADD COLUMN cedula VARCHAR(20) DEFAULT NULL,
ADD COLUMN direccion VARCHAR(200) DEFAULT NULL,
ADD COLUMN correoElectronico VARCHAR(150) DEFAULT NULL,
ADD COLUMN fechaNacimiento DATE DEFAULT NULL;


DELIMITER //

-- Procedimiento para insertar un postulante
CREATE PROCEDURE sp_InsertarPostulante(
    IN p_nombres VARCHAR(100),
    IN p_apellidos VARCHAR(100),
    IN p_cedula VARCHAR(20),
    IN p_direccion VARCHAR(200),
    IN p_correoElectronico VARCHAR(150),
    IN p_fechaNacimiento DATE,
    IN p_especialidad VARCHAR(100),
    IN p_experiencia TEXT,
    IN p_estado VARCHAR(50)
)
BEGIN
    INSERT INTO Postulante (nombres, apellidos, cedula, direccion, correoElectronico, fechaNacimiento, especialidad, experiencia, estado)
    VALUES (p_nombres, p_apellidos, p_cedula, p_direccion, p_correoElectronico, p_fechaNacimiento, p_especialidad, p_experiencia, p_estado);
END //

-- Procedimiento para buscar un postulante por cédula
CREATE PROCEDURE sp_BuscarPostulante(
    IN p_cedula VARCHAR(20)
)
BEGIN
    SELECT idPostulante, nombres, apellidos, cedula, correoElectronico, estado
    FROM Postulante
    WHERE cedula LIKE p_cedula;
END //

-- Procedimiento para listar todos los postulantes
CREATE PROCEDURE sp_listaPostulante()
BEGIN
    SELECT idPostulante, nombres, apellidos, cedula, correoElectronico, estado
    FROM Postulante;
END //

-- Procedimiento para actualizar un postulante
CREATE PROCEDURE sp_ActualizarPostulante(
    IN p_id INT,
    IN p_nombres VARCHAR(100),
    IN p_apellidos VARCHAR(100),
    IN p_cedula VARCHAR(20),
    IN p_direccion VARCHAR(200),
    IN p_correoElectronico VARCHAR(150),
    IN p_fechaNacimiento DATE,
    IN p_especialidad VARCHAR(100),
    IN p_experiencia TEXT,
    IN p_estado VARCHAR(50)
)
BEGIN
    UPDATE Postulante
    SET nombres = p_nombres,
        apellidos = p_apellidos,
        cedula = p_cedula,
        direccion = p_direccion,
        correoElectronico = p_correoElectronico,
        fechaNacimiento = p_fechaNacimiento,
        especialidad = p_especialidad,
        experiencia = p_experiencia,
        estado = p_estado
    WHERE idPostulante = p_id;
END //

-- Procedimiento para eliminar un postulante
CREATE PROCEDURE sp_EliminarPostulante(
    IN p_cedula VARCHAR(20)
)
BEGIN
    DELETE FROM Postulante
    WHERE cedula = p_cedula;
END //

DELIMITER ;

CALL sp_InsertarPostulante(
    'Juan',
    'Pérez',
    '1234567890',
    'Av. Principal #123',
    'juan.perez@gmail.com',
    '1990-05-15',
    'Ingeniero en Sistemas',
    '5 años de experiencia en desarrollo web',
    'Activo'
);


CALL sp_BuscarPostulante('%1234567890%');

CALL sp_listaPostulante();

CALL sp_ActualizarPostulante(
    1, -- ID del postulante
    'Juan Carlos',
    'Pérez López',
    '1234567890',
    'Av. Secundaria #456',
    'juan.perez@correo.com',
    '1990-05-15',
    'Ingeniero en Redes',
    '6 años de experiencia en administración de redes',
    'Inactivo'
);
CALL sp_EliminarPostulante('1234567890');

