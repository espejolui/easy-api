// 1. Utilidad para manejar las rutas
import { Router } from "express";
import {
  getRecipes,
  getRecipe,
  createRecipe,
  deleteRecipe,
  updateRecipe,
} from "../controllers/recipes.controllers.js";

// 3. Constante para exportar las diferentes rutas con ayuda del modulo Routes
const router = Router();

// 4. Cuando se consulte /recipes devuelve la respuesta del controlador recipesControllers
router.get("/recipes", getRecipes);
router.get("/recipes/:id", getRecipe);
router.post("/recipes", createRecipe);
router.put("/recipes/:id", updateRecipe);
router.delete("/recipes/:id", deleteRecipe);

export default router;
