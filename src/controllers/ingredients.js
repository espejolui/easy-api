import { pool } from "../db.js"; // Método para crear el pool y escuchar la db

// 6. Añadir ingredientes a una receta
export const addIngredients = async (req, res) => {
  const { recipe_id, ingredients } = req.body;

  try {
    if (!recipe_id || !Array.isArray(ingredients) || ingredients.length === 0) {
      return res.status(400).json({ mensaje: "Datos inválidos" });
    }

    // Insertar en la tabla de relación
    const insertQueries = ingredients.map((ingredient) =>
      pool.query(
        "INSERT INTO recipe_ingredient (recipe_id, ingredient_id, quantity, unit_id) VALUES ($1, $2, $3, $4)",
        [
          recipe_id,
          ingredient.ingredient_id,
          ingredient.quantity,
          ingredient.unit_id,
        ],
      ),
    );
    await Promise.all(insertQueries);

    res
      .status(201)
      .json({ mensaje: "Ingredientes añadidos a la receta con éxito" });
  } catch (err) {
    console.error("Error al añadir ingredientes:", err);
    res.status(500).json({ mensaje: "Error interno del servidor" });
  }
};
