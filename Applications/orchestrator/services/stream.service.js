import axios from "axios";
import { Config } from "./config.js";

export class StreamService {
    static getStreamById(streamId) {
        return axios.get(Config.STREAMURL + streamId + "/full");
    }
}
