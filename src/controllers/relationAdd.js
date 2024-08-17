import { pool } from "../db.js";

// Asociar ingredientes a una receta en especifico
export const addIngredientsRecipe = async (req, res) => {
    const { recipe_id, ingredients } = req.body;

    try {
        if (!recipe_id || !ingredients || !Array.isArray(ingredients)) {
            return res.status(400).json({ mensaje: "El ID y los ingredientes son necesarios" });
        }

        // Hacer una consulta de inserción en lote
        const insertQueries = ingredients.map(ingredient => {
            return pool.query(
                "INSERT INTO recipe_ingredient (recipe_id, ingredient_id, quantity, unit_id) VALUES ($1, (SELECT id FROM ingredient WHERE name = $2), $3, (SELECT id FROM unit WHERE name = $4))",
                [recipe_id, ingredient.name, ingredient.quantity, ingredient.unit]
            );
        });

        // Ejecutar todas las consultas en paralelo
        await Promise.all(insertQueries);

        res.status(201).json({ mensaje: "¡La relación se hizo con éxito!" });
    } catch (err) {
        console.log("Error al asociar ingredientes a la receta:", err);
        res.status(500).json({ mensaje: "Error interno del servidor" });
    }
};
