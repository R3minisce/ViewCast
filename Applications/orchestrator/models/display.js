export class Display {
    initFromObj(o) {
        this.id = o.id;
        this.group_id = o.group_id;
    }
    get Id() {
        return this.id;
    }
    get GroupId() {
        return this.group_id;
    }
    set GroupId(groupId){
        this.group_id = groupId;
    }
    get Socket() {
        return this.socket;
    }
    set Socket(socket) {
        this.socket = socket;
    }

    updateFromDisplay(display) {
        this.group_id = display.GroupId;
    }
}
