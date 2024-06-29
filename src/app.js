import express from "express";
import recipesRoutes from "./routes/recipes.routes.js";

export const app = express();
app.use(express.json());
app.use("/api", recipesRoutes);
