import axios from "axios";
import { Config } from "./config.js";

export class DisplaysService {
    static getDisplayById(displayId) {
        return axios.get(Config.DISPLAYURL + displayId);
    }
}
