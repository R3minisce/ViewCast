export class Group {
    constructor() {
        this.displays = [];
    }
    initFromObj(o) {
        this.id = o.id;
        this.name = o.name;
        this.description = o.description;
        this.stream_id = o.stream_id;
    }
    get Displays() {
        return this.displays;
    }
    set Displays(displays){
        this.displays = displays;
    }
    addDisplay(display) {
        if (this.displays.find(d => d.Id === display.Id) === undefined) {
            this.displays.push(display);
        }
    }
    removeDisplay(display) {
        let index = this.displays.findIndex(d => d === display);
        if (index !== -1) {
            this.displays[index].GroupId = null;
            this.displays.splice(index, 1);
        }
    }
    updateFromGroup(group){
        this.stream_id = group.StreamId;
    }

    get Id() {
        return this.id;
    }
    get Name() {
        return this.name;
    }
    set Name(name) {
        this.name = name;
    }
    get Description() {
        return this.description;
    }
    set Description(description) {
        this.description = description;
    }
    get StreamId() {
        return this.stream_id;
    }
    set StreamId(streamId) {
        this.stream_id = streamId;
    }


}
