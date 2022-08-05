import { Topic } from "./topic.js";
import { Utils } from "../services/utils.js";
export class EventStream {
    initFromObj(o) {
        this.id = o.id;
        this.name = o.name;
        this.start_hour = o.start_hour;
        this.end_hour = o.end_hour;
        this.days = o.days;
        this.specific_date = o.specific_date;
        this.timer = o.timer;
        if (Utils.checkHasValue(o.topic)) {
            let top = new Topic();
            top.initFromObj(o.topic);
            this.topic = top;
        }
        this.stream_id = o.stream_id;
    }

    get Id() {
        return this.id;
    }
    get Name() {
        return this.name;
    }
    get StartHour() {
        return this.start_hour;
    }
    get EndHour() {
        return this.end_hour;
    }
    get Days() {
        return this.days;
    }
    get SpecificDate() {
        return this.specific_date;
    }
    get Timer() {
        return this.timer;
    }
    get Topic() {
        return this.topic;
    }
    get StreamId(){
        return this.stream_id;
    }
    isRecurrent() {
        return this.specific_date === null || this.specific_date === undefined;
    }
}
