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