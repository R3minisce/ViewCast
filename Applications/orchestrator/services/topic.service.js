import axios from "axios";
import {Config} from "./config.js";

export class TopicService{
    static getTopicById(topicId) {
        return axios.get(Config.TOPICURL + topicId);
    }
}
