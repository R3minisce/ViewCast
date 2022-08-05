import axios from "axios";
import { Config } from "./config.js";

export class GroupService {
    static getGroupById(groupId) {
        return axios.get(Config.GROUPURL + groupId);
    }
}
