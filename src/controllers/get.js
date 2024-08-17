import { pool } from "../db.js";

// 1. Obtener todas las recetas
export const getRecipes = async (req, res) => {
  res.header("Access-Control-Allow-Origin", "*");

  const { rows } = await pool.query(
    "SELECT id, title, preparation, photo FROM recipe;",
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
