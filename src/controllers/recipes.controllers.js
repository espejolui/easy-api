import { pool } from "../db.js";

export const getRecipes = async (req, res) => {
  res.header("Access-Control-Allow-Origin", "*");

  const [response] = await pool.query("SELECT * FROM fruits");
  res.json(response);
};
