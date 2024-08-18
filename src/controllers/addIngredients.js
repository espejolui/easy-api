import { pool } from "../db.js";

export const addIngredients = async (req, res) => {
  const ingredients = req.body;

  try {
    if (!Array.isArray(ingredients) || ingredients.length === 0) {
      return res
        .status(400)
        .json({ mensaje: "Se requiere un array de ingredientes" });
    }

    // Verificar existencia de recetas, ingredientes y unidades en una sola consulta
    const recipeIds = [...new Set(ingredients.map((i) => i.recipe_id))];
    const ingredientIds = [...new Set(ingredients.map((i) => i.ingredient_id))];
    const unitIds = [...new Set(ingredients.map((i) => i.unit_id))];

    const [recipes, ingredientsData, units] = await Promise.all([
      pool.query("SELECT id FROM recipe WHERE id = ANY($1::uuid[])", [
        recipeIds,
      ]),
      pool.query("SELECT id FROM ingredient WHERE id = ANY($1::uuid[])", [
        ingredientIds,
      ]),
      pool.query("SELECT id FROM unit WHERE id = ANY($1::uuid[])", [unitIds]),
    ]);

    const validRecipeIds = new Set(recipes.rows.map((row) => row.id));
    const validIngredientIds = new Set(
      ingredientsData.rows.map((row) => row.id),
    );
    const validUnitIds = new Set(units.rows.map((row) => row.id));

    // Verificar que todos los IDs sean válidos
    for (const ingredient of ingredients) {
      const { recipe_id, ingredient_id, unit_id, quantity } = ingredient;

      if (
        !validRecipeIds.has(recipe_id) ||
        !validIngredientIds.has(ingredient_id) ||
        !validUnitIds.has(unit_id)
      ) {
        return res.status(400).json({
          mensaje: `Datos inválidos para: ${JSON.stringify(ingredient)}`,
        });
      }
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
