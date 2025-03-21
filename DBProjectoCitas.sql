CREATE DATABASE `projectocitas` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;

USE projectocitas;

-- Tabla Especialidad
CREATE TABLE IF NOT EXISTS `especialidad` (
  `especialidad_id` int NOT NULL AUTO_INCREMENT,
  `especialidad_nombre` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`especialidad_id`)
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Tabla Localidad
CREATE TABLE IF NOT EXISTS `localidad` (
  `localidad_id` int NOT NULL AUTO_INCREMENT,
  `localidad_nombre` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`localidad_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Tabla Perfiles
CREATE TABLE IF NOT EXISTS `perfiles` (
  `perfil_id` int NOT NULL AUTO_INCREMENT,
  `perfil_nombre` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`perfil_id`),
  UNIQUE KEY `ID_UNIQUE` (`perfil_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Tabla Permisos
CREATE TABLE IF NOT EXISTS `permisos` (
  `permisos_id` int NOT NULL AUTO_INCREMENT,
  `permisos_nombre` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`permisos_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Tabla PermisosPerfil
CREATE TABLE IF NOT EXISTS `permisosperfil` (
  `perfil_id` int NOT NULL,
  `permiso_id` int NOT NULL,
  PRIMARY KEY (`perfil_id`, `permiso_id`),
  KEY `fk_permiso_idx` (`permiso_id`),
  CONSTRAINT `fk_perfil` FOREIGN KEY (`perfil_id`) REFERENCES `perfiles` (`perfil_id`),
  CONSTRAINT `fk_permiso` FOREIGN KEY (`permiso_id`) REFERENCES `permisos` (`permisos_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Tabla Usuario
CREATE TABLE IF NOT EXISTS `usuario` (
  `usuario_id` varchar(10) NOT NULL,
  `nombre` varchar(50) DEFAULT NULL,
  `apellido` varchar(50) DEFAULT NULL,
  `clave` varchar(50) DEFAULT NULL,
  `perfil_id` int DEFAULT NULL,
  `foto` varchar(255) NULL,
  `resena` TEXT NULL,
  `aprobado` TINYINT(1) DEFAULT 0,
  PRIMARY KEY (`usuario_id`),
  KEY `fk_perfil_idx` (`perfil_id`),
  CONSTRAINT `fk_perfil_usuario` FOREIGN KEY (`perfil_id`) REFERENCES `perfiles` (`perfil_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Tabla Medico
CREATE TABLE IF NOT EXISTS `medico` (
  `medico_id` varchar(10) NOT NULL,
  `costoconsulta` DECIMAL(10,2) DEFAULT NULL,
  `localidad` int DEFAULT NULL,
  `horariosemanal` varchar(500) DEFAULT NULL,
  `frecuencia` int DEFAULT NULL,
  PRIMARY KEY (`medico_id`),
  KEY `fk_medico_localidad_idx` (`localidad`),
  CONSTRAINT `fk_medico_localidad` FOREIGN KEY (`localidad`) REFERENCES `localidad` (`localidad_id`),
  CONSTRAINT `fk_medico_usuario` FOREIGN KEY (`medico_id`) REFERENCES `usuario` (`usuario_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Tabla Cita
CREATE TABLE IF NOT EXISTS `cita` (
  `cita_id` int NOT NULL AUTO_INCREMENT,
  `id_paciente` varchar(10),
  `id_medico` varchar(10),
  `fecha` DATETIME,
  `estado` ENUM('Pendiente', 'Completada', 'Cancelada'),
  `anotaciones` TEXT NULL,
  PRIMARY KEY (`cita_id`),
  FOREIGN KEY (`id_paciente`) REFERENCES `usuario` (`usuario_id`),
  FOREIGN KEY (`id_medico`) REFERENCES `usuario` (`usuario_id`)
) ENGINE=InnoDB;

-- Tabla Perfil Medico
CREATE TABLE IF NOT EXISTS `perfilmedico` (
  `id_cedula` varchar(10) PRIMARY KEY,
  `especialidad` varchar(50),
  `costo_consulta` DECIMAL(10,2),
  `localidad` varchar(50),
  `horario_semanal` varchar(500),
  `frecuencia` int,
  FOREIGN KEY (`id_cedula`) REFERENCES `usuario` (`usuario_id`)
) ENGINE=InnoDB;

-- Tabla Horario
CREATE TABLE IF NOT EXISTS `horario` (
  `horario_id` int NOT NULL AUTO_INCREMENT,
  `id_medico` varchar(10),
  `dia` VARCHAR(10),
  `hora_inicio` TIME,
  `hora_fin` TIME,
  PRIMARY KEY (`horario_id`),
  FOREIGN KEY (`id_medico`) REFERENCES `usuario` (`usuario_id`)
) ENGINE=InnoDB;

-- Tabla Historico Citas
CREATE TABLE IF NOT EXISTS `historicocitas` (
  `historico_id` int NOT NULL AUTO_INCREMENT,
  `id_cita` int,
  `id_paciente` varchar(10),
  `id_medico` varchar(10),
  `fecha` DATETIME,
  `estado` ENUM('Pendiente', 'Completada', 'Cancelada'),
  `anotaciones` TEXT NULL,
  PRIMARY KEY (`historico_id`),
  FOREIGN KEY (`id_cita`) REFERENCES `cita` (`cita_id`),
  FOREIGN KEY (`id_paciente`) REFERENCES `usuario` (`usuario_id`),
  FOREIGN KEY (`id_medico`) REFERENCES `usuario` (`usuario_id`)
) ENGINE=InnoDB;
