import { pool } from "../db.js";

export const getRecipes = async (req, res) => {
  const { page = 1, limit = 10 } = req.query; // Obtener parámetros de paginación
  const offset = (page - 1) * limit;

  try {
    const { rows } = await pool.query(
      `SELECT
         r.id,
         r.title,
         r.photo,
         i.name AS ingredient_name,
         u.name AS unit,
         riu.quantity
       FROM recipe r
       LEFT JOIN recipe_ingredient_unit riu ON r.id = riu.recipe_id
       LEFT JOIN ingredient i ON riu.ingredient_id = i.id
       LEFT JOIN unit u ON riu.unit_id = u.id
       LIMIT $1 OFFSET $2`,
      [limit, offset],
    );

    // Agrupar ingredientes por receta
    const recipes = {};

    rows.forEach((row) => {
      if (!recipes[row.id]) {
        recipes[row.id] = {
          title: row.title,
          photo: row.photo,
          ingredients: [],
        };
      }
      if (row.ingredient_name) {
        // Solo añadir ingredientes si existen
        recipes[row.id].ingredients.push({
          ingredient_name: row.ingredient_name,
          unit: row.unit,
          quantity: row.quantity,
        });
      }
    });

    // Convertir el objeto de recetas en un array
    const result = Object.values(recipes);

    res.json(result);
  } catch (err) {
    console.log("Error al obtener recetas:", err);
    res.status(500).json({ mensaje: "Error interno del servidor" });
  }
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
