import { pool } from "../db.js"; // Método para crear el pool y escuchar la db

// 1. Obtener todas las recetas
export const getRecipes = async (req, res) => {
  res.header("Access-Control-Allow-Origin", "*");

  const { rows } = await pool.query(
    "SELECT r.title, r.photo, d.day_week, t.type_food, STRING_AGG(i.name || ' (' || ri.quantity || ' ' || u.name || ')', ', ') AS ingredients FROM recipe r JOIN day d ON r.day_id = d.id JOIN type t ON r.type_id = t.id JOIN recipe_ingredient ri ON r.id = ri.recipe_id JOIN ingredient i ON ri.ingredient_id = i.id JOIN unit u ON ri.unit_id = u.id GROUP BY r.title, r.photo, d.day_week, t.type_food;",
  );
  res.json(rows);
};

// 2. Obtener una receta por su id
export const getRecipe = async (req, res) => {
  res.header("Access-Control-Allow-Origin", "*");

  const { id } = req.params;
  const { rows } = await pool.query("SELECT * FROM recipe WHERE id = $1", [id]);

  if (rows.length === 0) {
    return res.status(404).json({ mensaje: "¡Ups! No existe la receta" });
  }
  res.json(rows[0]);
};

// 3. Crear una receta
export const createRecipe = async (req, res) => {
  const { title, preparation, photo, day_week, type_food } = req.body;

  try {
    if (!title || !preparation || !photo || !day_week || !type_food) {
      return res
        .status(400)
        .json({ mensaje: "Todos los campos son necesarios" });
    }

    const dayResult = await pool.query(
      "SELECT id FROM day WHERE day_week = $1",
      [day_week],
    );
    const typeResult = await pool.query(
      "SELECT id FROM type WHERE type_food = $1",
      [type_food],
    );

    if (dayResult.rows.length === 0 || typeResult.rows.length === 0) {
      return res
        .status(400)
        .json({ message: "Día o tipo de comida no encontrados" });
    }

    const day_id = dayResult.rows[0].id;
    const type_id = typeResult.rows[0].id;

    const { rows } = await pool.query(
      "INSERT INTO recipe ( title, preparation, photo, day_id, type_id) VALUES ($1, $2, $3, $4, $5) RETURNING *",
      [title, preparation, photo, day_id, type_id],
    );

    res.status(201).json({ rows });
  } catch (err) {
    console.err("Error al crear la receta:", err);
    res.status(500).json({ mensaje: "Error interno del servidor" });
  }
};

// 4. Eliminar una receta por su id
export const deleteRecipe = async (req, res) => {
  const { id } = req.params;
  const { rows, rowCount } = await pool.query(
    "DELETE FROM recipe WHERE id = $1 RETURNING *",
    [id],
  );
  if (rowCount === 0) {
    return res.status(404).json({ mensaje: "Receta eliminada o inexistente" });
  }

  return res.json(rows);
};

// 5. Actualizar recetas
export const updateRecipe = async (req, res) => {
  const { id } = req.params;
  const data = req.body;

  const { rows } = await pool.query(
    "UPDATE recipe SET title = $1, preparation = $2, photo = $3 WHERE id = $4 RETURNING *",
    [data.title, data.preparation, data.photo, id],
  );

  res.json(rows[0]);
};
