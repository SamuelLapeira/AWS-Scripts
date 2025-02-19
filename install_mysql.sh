#!/bin/bash

# Variables de configuración
DB_NAME="student_db"
DB_USER="phpuser"
DB_PASSWORD="dejame"

# Actualizar la lista de paquetes y asegurarse de que MySQL está instalado
sudo apt update
sudo apt upgrade -y
sudo apt install mysql-server -y

# Iniciar el servicio de MySQL si no está corriendo
sudo systemctl start mysql
sudo systemctl enable mysql

# Iniciar sesión en MySQL y ejecutar el script para crear la base de datos, la tabla, el usuario y los permisos
sudo mysql <<EOF
-- Crear la base de datos
CREATE DATABASE IF NOT EXISTS $DB_NAME;

-- Usar la base de datos
USE $DB_NAME;

-- Crear la tabla 'students'
CREATE TABLE IF NOT EXISTS students (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50),
    email VARCHAR(100) NOT NULL
);

-- Crear el usuario 'phpuser' y asignarle una contraseña
CREATE USER IF NOT EXISTS '$DB_USER'@'%' IDENTIFIED BY '$DB_PASSWORD';

-- Otorgar permisos de SELECT e INSERT al usuario 'phpuser' sobre la base de datos 'student_db'
GRANT SELECT, INSERT ON $DB_NAME.* TO '$DB_USER'@'%';

-- Aplicar los cambios de permisos
FLUSH PRIVILEGES;
EOF