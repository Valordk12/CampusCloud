
// Importar express, que se instalo previamente
import express from "express";

// Importar el router salud
import saludRoutes from "./routes/salud.routes.js"

// Crea una aplicación Express, apartir de este objeto
// se podran configurar rutas y middlewares

const app = express();

// Agrega un middleware que permite interpretar cuerpos JSON de las peticiones HTTP
app.use(express.json());

// Registrar la ruta
app.use(saludRoutes);

export default app;