-- 1. Crear base de datos
CREATE DATABASE easyfood;

-- 2. Conectarse a la base de datos
\c easyfood

-- 2. Eliminar la tabla si existe
DROP TABLE IF EXISTS day;

-- 2.1. Crear la tabla 'day'
CREATE TABLE day (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    day_week VARCHAR(10) NOT NULL UNIQUE
);

-- 2.2. Insertar datos en la tabla 'day'
INSERT INTO day(day_week) VALUES
    ('lunes'),
    ('martes'),
    ('miercoles'),
    ('jueves'),
    ('viernes');

-- 2.3. Leer datos de la tabla 'day'
SELECT id, day_week FROM day;

-- 3. Eliminar la tabla si existe
DROP TABLE IF EXISTS type;

-- 3.1. Crear la tabla 'type'
CREATE TABLE type (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    type_food VARCHAR(10) NOT NULL UNIQUE
);

-- 3.2. Insertar datos en la tabla 'type'
INSERT INTO type(type_food) VALUES
    ('desayuno'),
    ('almuerzo'),
    ('cena');

-- 3.3. Leer datos de la tabla 'type'
SELECT id, type_food FROM type;

-- 4. Eliminar la tabla si existe
DROP TABLE IF EXISTS recipe;

-- 4.1. Crear la tabla 'recipe'
CREATE TABLE recipe (
    id SERIAL PRIMARY KEY,
    title VARCHAR(100) NOT NULL,
    preparation TEXT NOT NULL,
    photo VARCHAR(255) NOT NULL,
    day_id UUID,
    type_id UUID,
    FOREIGN KEY (day_id) REFERENCES day(id),
    FOREIGN KEY (type_id) REFERENCES type(id)
);

-- 4.2. Insertar datos en la tabla 'recipe'
INSERT INTO recipe(
    title, preparation, photo, day_id, type_id)
VALUES
    ('Yogurt con cereal y frutas',
    'Colocar el yogurt en un bol, añadir el cereal y las frutas por encima y servir inmediatamente.',
    'https://res.cloudinary.com/dopllrjwh/image/upload/v1720296686/Yogur_con_Cereal_y_Frutas_vqppsb.webp',
    (SELECT id FROM day WHERE day_week = 'lunes'),
    (SELECT id FROM type WHERE type_food = 'desayuno'));

-- 4.3 Leer datos de la tabla 'recipe'
SELECT id, title FROM recipe;

-- 4.4 Leer datos de la tabla 'recipe' con joins
SELECT r.id, r.title, d.day_week, t.type_food
FROM recipe r
JOIN day d ON r.day_id = d.id
JOIN type t ON r.type_id = t.id;

-- 5. Crear la tabla 'ingredient'
CREATE TABLE ingredient (
    id SERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    amount VARCHAR(50) NOT NULL
);

-- 6. Crear la tabla para relación tabla "recipe" con tabla "ingresient"
CREATE TABLE recipe_ingredient (
    recipe_id INT,
    ingredient_id INT,
    PRIMARY KEY (recipe_id, ingredient_id),
    FOREIGN KEY (recipe_id) REFERENCES recipe(id),
    FOREIGN KEY (ingredient_id) REFERENCES ingredient(id)
);
