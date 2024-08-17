-- 1. Insertar datos en la tabla 'day'
INSERT INTO day(day_week) VALUES
  ('lunes'),
  ('martes'),
  ('miercoles'),
  ('jueves'),
  ('viernes');

-- 2. Insertar datos en la tabla 'type'
INSERT INTO type(type_food) VALUES
  ('desayuno'),
  ('almuerzo'),
  ('cena');

-- 3. Insertar datos en la tabla 'recipe' desde postgres, si es con el endpoint es de otra forma
INSERT INTO recipe(title, preparation, photo, day_id, type_id)
  VALUES('Yogurt con cereal y frutas',
      'Colocar el yogurt en un bol, añadir el cereal y las frutas por encima y servir inmediatamente.',
      'https://res.cloudinary.com/dopllrjwh/image/upload/v1720296686/Yogur_con_Cereal_y_Frutas_vqppsb.webp',
      (SELECT id FROM day WHERE day_week = 'lunes'),
      (SELECT id FROM type WHERE type_food = 'desayuno'));

-- 4. Leer datos de la tabla 'recipe' con joins usando alias sobre las tablas
SELECT r.id, r.title, d.day_week, t.type_food
  FROM recipe r
  JOIN day d ON r.day_id = d.id
  JOIN type t ON r.type_id = t.id;

-- 5. Insertar datos en la tabla 'ingredient'
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

-- 6. Insertando datos en la tabla 'unit'
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