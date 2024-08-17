import { pool } from "../db.js";

// 1. Obtener todas las recetas
export const getRecipes = async (req, res) => {
  res.header("Access-Control-Allow-Origin", "*");

  const { rows } = await pool.query("SELECT * FROM recipe");
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

// 3. Obtener recetas con JOIN
export const getRecipeIngredient = async (req, res) => {
  res.header("Access-Control-Allow-Origin", "*");

  try {
    const { rows } = await pool.query(`SSELECT
    r.id,
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
    r.id, r.title, d.day_week, t.type_food;`);

    if (rows.length === 0) {
      return res.status(404).json({ mensaje: "¡Ups! No existen recetas." });
    }
    res.json(rows);
  } catch (error) {
    console.error("Error al obtener recetas con JOIN:", error);
    res.status(500).json({ mensaje: "Error al obtener recetas." });
  }
};
