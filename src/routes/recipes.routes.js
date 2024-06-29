// Utilidad para manejar las rutas
import { Router } from "express";
import { recipesControllers } from "../controllers/recipes.controllers.js";

const router = Router();
// Cuando se enrute a /recipes devuelve la respuesta del controlador recipes
router.get("/recipes", recipesControllers);
export default router;
