
import {Router} from "express";
import { obtenerSalud } from "../controllers/salud.controllers.js";
// Crear un objeto router

const router = Router();

router.get("/salud", obtenerSalud);

export default router;