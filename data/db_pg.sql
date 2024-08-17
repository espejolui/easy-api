-- 1. Crear base de datos
CREATE DATABASE easyfood;

-- 2. Conectarse a la base de datos
\c easyfood -- (sintaxis en psql si es con pgAdmin no es necesario)

-- 3. Crear la tabla 'day'
CREATE TABLE day (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    day_week VARCHAR(10) NOT NULL UNIQUE
);

-- 3.1. Insertar datos en la tabla 'day'
INSERT INTO day(day_week) VALUES
    ('lunes'),
    ('martes'),
    ('miercoles'),
    ('jueves'),
    ('viernes');

-- 4. Crear la tabla 'type'
CREATE TABLE type (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    type_food VARCHAR(10) NOT NULL UNIQUE
);

-- 4.1. Insertar datos en la tabla 'type'
INSERT INTO type(type_food) VALUES
    ('desayuno'),
    ('almuerzo'),
    ('cena');

-- 5. Crear la tabla 'recipe'
CREATE TABLE recipe (
    id SERIAL PRIMARY KEY,
    title VARCHAR(100) NOT NULL UNIQUE,
    preparation TEXT NOT NULL,
    photo VARCHAR(255) NOT NULL,
    day_id UUID,
    type_id UUID,
    FOREIGN KEY (day_id) REFERENCES day(id),
    FOREIGN KEY (type_id) REFERENCES type(id)
);

-- 5.1. Insertar datos en la tabla 'recipe' desde postgres, si es con el endpoint es de otra forma
INSERT INTO recipe(
    title, preparation, photo, day_id, type_id)
VALUES
    ('Yogurt con cereal y frutas',
    'Colocar el yogurt en un bol, añadir el cereal y las frutas por encima y servir inmediatamente.',
    'https://res.cloudinary.com/dopllrjwh/image/upload/v1720296686/Yogur_con_Cereal_y_Frutas_vqppsb.webp',
    (SELECT id FROM day WHERE day_week = 'lunes'),
    (SELECT id FROM type WHERE type_food = 'desayuno'));

-- 5.2 Leer datos de la tabla 'recipe' con joins usando alias sobre las tablas
SELECT r.id, r.title, d.day_week, t.type_food
FROM recipe r
JOIN day d ON r.day_id = d.id
JOIN type t ON r.type_id = t.id;

-- 6. Crear la tabla 'ingredient'
CREATE TABLE ingredient (
    id SERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL UNIQUE
);

-- 6.1. Insertar datos en la tabla 'ingredient'
INSERT INTO ingredient (name) VALUES
    ('aceite'),
    ('aceite de oliva'),
    ('agua'),
    ('aguacate'),
    ('ajo'),
    ('albahaca'),
    ('alcaparras'),
    ('arina de maíz precocida'),
    ('arroz'),
    ('calabacín'),
    ('calabaza'),
    ('caldo de pollo'),
    ('caldo de res'),
    ('caldo de verduras'),
    ('cebolla blanca'),
    ('cebolla morada'),
    ('cereal'),
    ('crema de leche'),
    ('filete de salmón'),
    ('guascas'),
    ('guisantes'),
    ('huevos'),
    ('lechuga romana'),
    ('mantequilla'),
    ('mazorcas en trozos'),
    ('ñame'),
    ('pan integral'),
    ('papa criolla'),
    ('papa pastusa'),
    ('papa sabanera'),
    ('pasta'),
    ('pechuga de pollo'),
    ('pepino'),
    ('pimienta'),
    ('pimiento rojo'),
    ('piñones'),
    ('puerro'),
    ('puñado de frutas'),
    ('queso costeño'),
    ('queso parmesano rallado'),
    ('queso rallado'),
    ('sal'),
    ('sobrebarriga'),
    ('tomate'),
    ('tomate triturado'),
    ('yogurt natural'),
    ('zanahoria'),
    ('zumo de limón'),
    ('lonchas de jamón serrano'),
    ('berenjena');

-- 7. Crear la tabla 'unit'
CREATE TABLE unit (
  id SERIAL PRIMARY KEY,
  name VARCHAR(50) NOT NULL UNIQUE
);

-- 6.1. Insertando datos en la tabla 'unit'
INSERT INTO unit (name) VALUES
    ('al gusto'),
    ('cucharada'),
    ('diente'),
    ('gr'),
    ('kg'),
    ('lata'),
    ('libra'),
    ('litro'),
    ('rebanada'),
    ('taza'),
    ('unidad'),
    ('loncha');

-- 7. Crear la tabla para relación tabla "recipe" con tabla "ingredient"
CREATE TABLE recipe_ingredient (
    recipe_id INTEGER,
    ingredient_id INTEGER,
    quantity NUMERIC(5, 2),
    unit_id INTEGER,
    PRIMARY KEY (recipe_id, ingredient_id),
    FOREIGN KEY (recipe_id) REFERENCES recipe(id),
    FOREIGN KEY (ingredient_id) REFERENCES ingredient(id),
    FOREIGN KEY (unit_id) REFERENCES unit(id)
);

-- 7.1 Consultar los id de los datos a ingresar
SELECT id, name FROM ingredient WHERE name IN ('puñado de frutas', 'yogurt natural', 'cereal');
SELECT id, name FROM unit WHERE name IN ('unidad', 'taza');

-- 7.2. Insertar datos en la tabla recipe_ingredient con los ID consultados anteriormente
INSERT INTO recipe_ingredient (recipe_id, ingredient_id, quantity, unit_id)
VALUES
    (1, 17, 0.5, 10),  -- Cereal
    (1, 38, 0.0, 1),  -- Puñado de frutas
    (1, 46, 1.0, 10);  -- Yogurt natural

-- 7.3. Opcioal para ingresar datos
INSERT INTO recipe_ingredient (recipe_id, ingredient_id, quantity, unit_id)
VALUES
  (3, (SELECT id FROM ingredient WHERE name = 'papa pastusa'), 4.00, (SELECT id FROM unit WHERE name = 'unidad')),
  (3, (SELECT id FROM ingredient WHERE name = 'cebolla blanca'), 1.00, (SELECT id FROM unit WHERE name = 'unidad')),
  (3, (SELECT id FROM ingredient WHERE name = 'huevos'), 5.00, (SELECT id FROM unit WHERE name = 'unidad')),
  (3, (SELECT id FROM ingredient WHERE name = 'aceite de oliva'), 0.00, (SELECT id FROM unit WHERE name = 'al gusto')),
  (3, (SELECT id FROM ingredient WHERE name = 'sal'), 0.00, (SELECT id FROM unit WHERE name = 'al gusto')),
  (3, (SELECT id FROM ingredient WHERE name = 'pimienta'), 0.00, (SELECT id FROM unit WHERE name = 'al gusto'));

SELECT
    r.title,
    d.day_week,
    t.type_food,
    STRING_AGG(i.name || ' (' || ri.quantity || ' ' || u.name || ')', ', ') AS ingredients
FROM
    recipe r
JOIN
    day d ON r.day_id = d.id
JOIN
    type t ON r.type_id = t.id
JOIN
    recipe_ingredient ri ON r.id = ri.recipe_id
JOIN
    ingredient i ON ri.ingredient_id = i.id
JOIN
    unit u ON ri.unit_id = u.id
GROUP BY
    r.title, d.day_week, t.type_food;
