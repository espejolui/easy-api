import express from "express"; // 1. Usando express
import recipes from "./routes/recipes.routes.js"; // 2. Mis rutas definidas

const app = express(); // 3. Levanatando servidor
app.use(express.json()); // 4. Formatendo salidas a json

app.use("/api", recipes);

const PORT = 1234;
app.listen(PORT); // Escuchando el puerto
