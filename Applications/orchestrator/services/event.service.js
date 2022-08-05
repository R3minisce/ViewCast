import axios from "axios";
import {Config} from "./config.js";

export class EventService{
    static getEventById(eventId) {
        return axios.get(Config.EVENTURL + eventId + "/full");
    }
}
