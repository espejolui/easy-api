// 1. Promise para poder manejar el async await
import { createPool } from "mysql2/promise";

process.loadEnvFile();

// 2. Configuración con los datos de mi db usando el objeto creayePool de Express
export const pool = createPool({
  host: process.env.HOST_DEV,
  user: process.env.USER_DEV,
  password: process.env.PASSWORD_DEV,
  port: process.env.PORT_DEV,
  database: process.env.DATABASE_DEV,
});
