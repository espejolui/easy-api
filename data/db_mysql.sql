CREATE DATABASE IF NOT EXISTS easyfood;
SHOW DATABASES;
USE easyfood;

/* ---------------   1   --------------- */
DROP TABLE IF EXISTS day;
CREATE TABLE IF NOT EXISTS day(
    id BINARY(16) PRIMARY KEY,
    day_week VARCHAR(10) NOT NULL UNIQUE
);

SHOW TABLES;
DESCRIBE day;

INSERT INTO day(id, day_week) VALUES
    (UUID_TO_BIN(UUID(),true), 'lunes'),
    (UUID_TO_BIN(UUID(),true), 'martes'),
    (UUID_TO_BIN(UUID(),true), 'miercoles'),
    (UUID_TO_BIN(UUID(),true), 'jueves'),
    (UUID_TO_BIN(UUID(),true), 'viernes');

-- Hago transofrmación para leer más comodo y no el binario
SELECT BIN_TO_UUID(id), day_week FROM day;

/* ---------------   2   --------------- */
DROP TABLE IF EXISTS type;
CREATE TABLE IF NOT EXISTS type(
    id BINARY(16) PRIMARY KEY,
    type_food VARCHAR(10) NOT NULL UNIQUE
);

SHOW TABLES;
DESCRIBE type;

INSERT INTO type(id, type_food) VALUES
    (UUID_TO_BIN(UUID(),true), 'desayuno'),
    (UUID_TO_BIN(UUID(),true), 'almuerzo'),
    (UUID_TO_BIN(UUID(),true), 'cena');

SELECT BIN_TO_UUID(id), type_food FROM type;

/* ---------------   3   --------------- */
DROP TABLE IF EXISTS recipe;
CREATE TABLE IF NOT EXISTS recipe(
    id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(100) NOT NULL,
    preparation TEXT NOT NULL,
    photo VARCHAR(255) NOT NULL,
    day_id BINARY(16),
    type_id BINARY(16),
    FOREIGN KEY (day_id) REFERENCES day(id),
    FOREIGN KEY (type_id) REFERENCES type(id)
);

SHOW TABLES;
DESCRIBE recipe;

SET @day_uuid = (SELECT id FROM day WHERE day_week = 'lunes');

SET @type_uuid = (SELECT id FROM type WHERE type_food = 'desayuno');

INSERT INTO recipe(
    title, preparation, photo, day_id, type_id)
    VALUES
    ('Yogurt con cereal y frutas', 
    'Colocar el yogurt en un bol, añadir el cereal y las frutas por encima y servir inmediatamente.',
    'https://res.cloudinary.com/dopllrjwh/image/upload/v1720296686/Yogur_con_Cereal_y_Frutas_vqppsb.webp',
    @day_uuid, @type_uuid);

SELECT id, title FROM recipe;

SELECT r.id, r.title, d.day_week, t.type_food
FROM recipe r
JOIN day d ON r.day_id = d.id
JOIN type t ON r.type_id = t.id;

/* ---------------   4   --------------- */
CREATE TABLE ingredient(
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    amount VARCHAR(50) NOT NULL
);

SHOW TABLES;
DESCRIBE ingredient;

/* ---------------   5   --------------- */
CREATE TABLE recipe_ingredient(
    recipe_id INT,
    ingredient_id INT,
    PRIMARY KEY (recipe_id, ingredient_id),
    FOREIGN KEY (recipe_id) REFERENCES recipe(id),
    FOREIGN KEY (ingredient_id) REFERENCES ingredient(id)
);

SHOW TABLES;
DESCRIBE recipe_ingredient;
