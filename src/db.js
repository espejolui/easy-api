import pg from "pg";
import { env, loadEnvFile } from "node:process";
loadEnvFile("./.env");

/* --- Configuración con postgreSQL */
export const pool = new pg.Pool({
  host: env.HOST_DB,
  database: env.DATABASE_DB,
  user: env.USER_DB,
  password: env.PASSWORD_DB,
  port: env.PORT_DB,
});

/* --- Configuración con MySQL --- */
//import { createPool } from "mysql2/promise";
/*
export const pool = createPool({
  host: env.HOST_DB,
  database: env.DATABASE_DB,
  user: env.USER_DB,
  password: env.PASSWORD_DB,
  port: env.PORT_DB,
});*/
