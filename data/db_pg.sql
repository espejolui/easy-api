-- 1. Crear base de datos
CREATE DATABASE easyfood;

-- 2. Conectarse a la base de datos
-- En psql desde la terminal: \c easyfood
-- En pgAdmin: click derecho en la db "easyfood" y sacar un querytool

-- 3. Crear tabla 'day'
CREATE TABLE day (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    day_week VARCHAR(10) NOT NULL UNIQUE
);

-- 4. Crear tabla 'type'
CREATE TABLE type (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    type_food VARCHAR(10) NOT NULL UNIQUE
);

-- 5. Crear tabla 'recipe'
CREATE TABLE recipe (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    title VARCHAR(100) NOT NULL UNIQUE,
    preparation TEXT NOT NULL,
    photo VARCHAR(255) NOT NULL,
    day_id UUID,
    type_id UUID,
    FOREIGN KEY (day_id) REFERENCES day(id),
    FOREIGN KEY (type_id) REFERENCES type(id)
);

-- 6. Crear tabla 'ingredient'
CREATE TABLE ingredient (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    name VARCHAR(50) NOT NULL UNIQUE
);

-- 7. Crear tabla 'unit'
CREATE TABLE unit (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    name VARCHAR(50) NOT NULL UNIQUE
);

-- 8. Crear tabla para relación "recipe" con "ingredient" y con "unit"
CREATE TABLE recipe_ingredient_unit (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    recipe_id UUID,
    ingredient_id UUID,
    unit_id UUID,
    quantity NUMERIC(10, 2),
    FOREIGN KEY (recipe_id) REFERENCES recipe(id),
    FOREIGN KEY (ingredient_id) REFERENCES ingredient(id),
    FOREIGN KEY (unit_id) REFERENCES unit(id)
);
