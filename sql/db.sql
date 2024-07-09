DROP DATABASE IF EXISTS easyfood;

CREATE DATABASE IF NOT EXISTS easyfood;

SHOW DATABASES;

USE easyfood;

CREATE TABLE recipe (
    id INT AUTO_INCREMENT PRIMARY KEY NOT NULL,
    dayWeek VARCHAR(10) NOT NULL,
    category VARCHAR(10) NOT NULL,
    title VARCHAR(100) NOT NULL,
    preparation TEXT NOT NULL,
    photo VARCHAR(255) NOT NULL
);

SHOW TABLES;
DESCRIBE recipe;

CREATE TABLE ingredient (
    id INT AUTO_INCREMENT PRIMARY KEY NOT NULL,
    name VARCHAR(50) NOT NULL,
    amount VARCHAR(50) NOT NULL
);

SHOW TABLES;
DESCRIBE recipe, ingredient;

/* Tabla de relación */
CREATE TABLE recipe_ingredient (
    recipe_id INT,
    ingredient_id INT,
    PRIMARY KEY (recipe_id, ingredient_id),
    FOREIGN KEY (recipe_id) REFERENCES recipe(id),
    FOREIGN KEY (ingredient_id) REFERENCES ingredient(id)
);

SHOW TABLES;
DESCRIBE recipe, ingredient, recipe_ingredient;