// 1. Importando express para usarlo
import express from "express";

// 2. Importando rutas creadas para ser usadas
import recipes from "./routes/recipes.routes.js";

// 3. Creando constante para escuchar en un puerto leventar el servidor
const app = express();

// 4. Rutas importadas | añadiendo palabra "api" antes de dicha ruta simplemente por conveción
app.use("/api", recipes);

// 5. Creando el el puerto y diciendole que escuche por él
const PORT = 5000;
app.listen(PORT);
console.log(`Listen in port: ${PORT}`);
