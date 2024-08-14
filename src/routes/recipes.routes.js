import { Router } from "express"; // 1. Método para manejar las rutas
import {
  getRecipes,
  getRecipe,
  createRecipe,
  deleteRecipe,
  updateRecipe,
} from "../controllers/recipes.controllers.js";

const router = Router(); // 2. almacenando rutas en la variable router

router.get("/recipes", getRecipes);
router.get("/recipes/:id", getRecipe);
router.post("/recipes", createRecipe);
router.put("/recipes/:id", updateRecipe);
router.delete("/recipes/:id", deleteRecipe);

export default router; // 3. Exportando todas las rutas por defecto
