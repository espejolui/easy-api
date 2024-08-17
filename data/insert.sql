-- RECETA #1. Consultar los id de los datos a ingresar
SELECT id, name FROM ingredient WHERE name IN ('puñado de frutas', 'yogurt natural', 'cereal');
SELECT id, name FROM unit WHERE name IN ('unidad', 'taza');

-- Insertar datos en la tabla recipe_ingredient con los ID consultados anteriormente
INSERT INTO recipe_ingredient (recipe_id, ingredient_id, quantity, unit_id)
VALUES
    (1, 17, 0.5, 10),  -- Cereal
    (1, 38, 0.0, 1),  -- Puñado de frutas
    (1, 46, 1.0, 10);  -- Yogurt natural

-- RECETA #2.
INSERT INTO recipe_ingredient (recipe_id, ingredient_id, quantity, unit_id)
VALUES
  (3, (SELECT id FROM ingredient WHERE name = 'papa pastusa'), 4.00, (SELECT id FROM unit WHERE name = 'unidad')),
  (3, (SELECT id FROM ingredient WHERE name = 'cebolla blanca'), 1.00, (SELECT id FROM unit WHERE name = 'unidad')),
  (3, (SELECT id FROM ingredient WHERE name = 'huevos'), 5.00, (SELECT id FROM unit WHERE name = 'unidad')),
  (3, (SELECT id FROM ingredient WHERE name = 'aceite de oliva'), 0.00, (SELECT id FROM unit WHERE name = 'al gusto')),
  (3, (SELECT id FROM ingredient WHERE name = 'sal'), 0.00, (SELECT id FROM unit WHERE name = 'al gusto')),
  (3, (SELECT id FROM ingredient WHERE name = 'pimienta'), 0.00, (SELECT id FROM unit WHERE name = 'al gusto'));

-- RECETA #2. hecha con el endpoint de la API
{
    "recipe_id": 2,
    "ingredients": [
        { "name": "pan integral", "quantity": 2.0, "unit": "rebanada" },
        { "name": "aguacate maduro", "quantity": 1.0, "unit": "unidad" },
        { "name": "huevos", "quantity": 2.0, "unit": "unidad" },
        { "name": "sal", "quantity": 0.0, "unit": "al gusto" },
        { "name": "pimienta", "quantity": 0.0, "unit": "al gusto" },
        { "name": "zanahoria", "quantity": 1.0, "unit": "unidad" },
        { "name": "guisantes", "quantity": 1.0, "unit": "lata" },
        { "name": "tomate", "quantity": 1.0, "unit": "lata" },
        { "name": "caldo de pollo", "quantity": "al gusto", "unit": "unidad" },
        { "name": "aceite de oliva", "quantity": "al gusto", "unit": "unidad" },
        { "name": "sal", "quantity": "al gusto", "unit": "unidad" },
        { "name": "pimienta", "quantity": "al gusto", "unit": "unidad" }
    ]
}

-- RECETA #4. hecha desde psql
{
    "recipe_id": 4,
    "ingredients": [
        { "name": "pan integral", "quantity": 2.0, "unit": "rebanada" },
        { "name": "aguacate maduro", "quantity": 1.0, "unit": "unidad" },
        { "name": "huevos", "quantity": 2.0, "unit": "unidad" },
        { "name": "sal", "quantity": 0.0, "unit": "al gusto" },
        { "name": "pimienta", "quantity": 0.0, "unit": "al gusto" }
    ]
}

{
  "recipe_id": 5,
  "ingredients": [
    { "ingredient_id": 43, "quantity": 1.0, "unit": "kg" },
    { "ingredient_id": 44, "quantity": 2.0, "unit": "unidad" },
    { "ingredient_id": 15, "quantity": 1.0, "unit": "unidad" },
    { "ingredient_id": 5, "quantity": 2.0, "unit": "diente" },
    { "ingredient_id": 35, "quantity": 1.0, "unit": "unidad" },
    { "ingredient_id": 13, "quantity": 1.0, "unit": "taza" },
    { "ingredient_id": 2, "quantity": 2.0, "unit": "cucharada" },
    { "ingredient_id": 42, "quantity": 0.0, "unit": "al gusto" },
    { "ingredient_id": 34, "quantity": 0.0, "unit": "al gusto" }
  ]
}
