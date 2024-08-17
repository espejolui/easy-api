import { Router } from "express"; // 1. Método para manejar las rutas
import { getRecipes, getRecipe, getRecipeIngredient } from "../controllers/get.js"
import { createRecipe } from "../controllers/create.js";
import { addIngredientsRecipe } from "../controllers/relationAdd.js";
import { deleteRecipe } from "../controllers/delete.js";
import { updateRecipe,} from "../controllers/update.js";

const router = Router(); // 2. almacenando rutas en la variable router

router.get("/recipes", getRecipes);
router.get("/recipes/:id", getRecipe);
router.get("/recipes/join", getRecipeIngredient);

router.post("/recipes", createRecipe);
router.post("/recipes/relation-add", addIngredientsRecipe);

router.put("/recipes/:id", updateRecipe);
router.delete("/recipes/:id", deleteRecipe);

export default router; // 3. Exportando todas las rutas por defecto
