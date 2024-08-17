import { pool } from "../db.js";

export const addIngredients = async (req, res) => {
  try {
  } catch (err) {
    console.log("Error al añadir ingredientes:", err);
    res.status(500).json({ mensaje: "Error interno del servidor" });
  }
};
