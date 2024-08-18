import { pool } from "../db.js";

export const addIngredients = async (req, res) => {
  const ingredients = req.body;

  try {
    if (!Array.isArray(ingredients) || ingredients.length === 0) {
      return res
        .status(400)
        .json({ mensaje: "Se requiere un array de ingredientes" });
    }

    // Verificar existencia de recetas, ingredientes y unidades
    for (const ingredient of ingredients) {
      const { recipe_id, ingredient_id, unit_id, quantity } = ingredient;

      if (!recipe_id || !ingredient_id || !unit_id || quantity === undefined) {
        return res.status(400).json({
          mensaje: "Todos los campos son necesarios para cada ingrediente",
        });
      }

      await pool.query("SELECT 1 FROM recipe WHERE id = $1", [recipe_id]);
      await pool.query("SELECT 1 FROM ingredient WHERE id = $1", [
        ingredient_id,
      ]);
      await pool.query("SELECT 1 FROM unit WHERE id = $1", [unit_id]);
    }

    // Insertar todos los ingredientes
    const insertPromises = ingredients.map((ingredient) =>
      pool.query(
        "INSERT INTO recipe_ingredient_unit (recipe_id, ingredient_id, unit_id, quantity) VALUES ($1, $2, $3, $4) RETURNING *",
        [
          ingredient.recipe_id,
          ingredient.ingredient_id,
          ingredient.unit_id,
          ingredient.quantity,
        ],
      ),
    );

    const results = await Promise.all(insertPromises);

    res.status(201).json({
      mensaje: "Ingredientes añadidos",
      data: results.map((result) => result.rows[0]),
    });
  } catch (err) {
    console.log("Error al añadir ingredientes:", err);
    res.status(500).json({ mensaje: "Error interno del servidor" });
  }
};
