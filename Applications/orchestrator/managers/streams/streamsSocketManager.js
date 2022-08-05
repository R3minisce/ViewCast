import { StreamSocket } from "./streamSocket.js";
import {Group} from "../../models/group.js";

export class StreamsSocketManager {

    constructor() {
        this.streamsSocket = [];
        this.dashboardGroup = new Group();
        this.dashboardGroup.id = "dashboard";
    }
    createStreamSocket(stream) {
        let selectedStreamSocket = this.findStreamSocketById(stream.Id);
        if (selectedStreamSocket === undefined) {
            stream.addGroup(this.dashboardGroup);
            selectedStreamSocket = new StreamSocket(stream, this);
            this.streamsSocket.push(selectedStreamSocket);
        }
        return selectedStreamSocket;
    }
    findStreamById(streamId) {
        if (streamId === undefined || streamId === null)
            return undefined;

        let streamSocket = this.streamsSocket.find(s => s.Id === streamId);
        if (streamSocket !== undefined) {
            return streamSocket.Stream;
        }
        return undefined;
    }
    findStreamSocketById(streamId) {
        if (streamId === undefined)
            return undefined;
        return this.streamsSocket.find(s => s.Id === streamId);
    }
    deleteStreamSocket(streamId){
        let index = this.streamsSocket.findIndex(s => s.Id === streamId);
        if (index !== -1) {
            this.streamsSocket[index].closeStream();
            this.streamsSocket.splice(index, 1);
        }
    }
    get StreamsSocket(){
        return this.streamsSocket;
    }
    get DashboardGroup(){
        return this.dashboardGroup;
    }
    addDisplayToDashboardGroup(display){
        this.dashboardGroup.addDisplay(display);
        for(let s of this.streamsSocket){
            s.emitCurrentFile(display.Socket, "dashboard");
        }
    }

    removeDisplayFromDashboardGroup(display){
        let index = this.dashboardGroup.Displays.findIndex(d=>d.Socket.id === display.Socket.id);
        if(index !== -1){
          this.dashboardGroup.Displays.splice(index,1);
        }
    }


}
