import { pool } from "../db.js";

export const getRecipes = async (req, res) => {
  res.header("Access-Control-Allow-Origin", "*");

  const [response] = await pool.query(
    "SELECT r.id, r.title, r.preparation, d.day_week, t.type_food FROM recipe r JOIN day d ON r.day_id = d.id JOIN type t ON r.type_id = t.id;"
  );
  res.json(response);
};
