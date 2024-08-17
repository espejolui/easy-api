import { pool } from "../db.js";

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
