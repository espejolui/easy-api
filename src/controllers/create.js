import { pool } from "../db.js";

// Crear una receta
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
      console.log("Error al crear la receta:", err);
      res.status(500).json({ mensaje: "Error interno del servidor" });
    }
  };