// 1. Promise para poder manejar el async await
import { createPool } from "mysql2/promise";

// 2. Configuración con los datos de mi db usando el objeto creayePool de Express
export const pool = createPool({
  host: "localhost",
  user: "root",
  password: "Camaro@3186",
  port: 31061,
  database: "easyfood",
});
