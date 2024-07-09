// 1. Utilidad para manejar las rutas
import { Router } from "express";
// 2. Usando el controlador que me brinda la respuesta
import { getRecipes } from "../controllers/recipes.controllers.js";

// 3. Constante para esportar las difeentes rutas con ayuda del modulo Routes
const router = Router();

// 4. Cuando se consulte /recipes devuelve la respuesta del controlador recipesControllers
router.get("/recipes", getRecipes);
export default router;
