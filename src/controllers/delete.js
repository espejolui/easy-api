import { pool } from "../db.js";

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