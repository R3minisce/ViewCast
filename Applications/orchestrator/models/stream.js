import { EventStream } from "./eventStream.js";

export class Stream {
    constructor() {
        this.groups = [];
        this.events = [];
    }

    initFromObj(o) {
        this.id = o.id;
        this.events = []
        if (o.events !== undefined) {
            for (let e of o.events) {
                let ev = new EventStream();
                ev.initFromObj(e);
                this.events.push(ev);
            }
        }
    }
    /*
    updateEventsFromStream(stream){
        this.events = []
        for (let e of stream.Events) {
            let ev = new EventStream();
            ev.initFromObj(e);
            this.events.push(ev);
        }
    }
    */
    get Id() {
        return this.id;
    }
    get Groups() {
        return this.groups;
    }
    set Groups(groups){
        this.groups = groups;
    }
    addGroup(group) {
        if (this.groups.find(g => g.Id === group.Id) === undefined) {
            this.groups.push(group);
        }
    }
    removeGroup(groupId) {
        let index = this.groups.findIndex(g => g.Id === groupId);
        if (index !== -1) {
            this.groups[index].StreamId = null;
            this.groups.splice(index, 1);
        }
    }
    get Events() {
        return this.events
    }
}
