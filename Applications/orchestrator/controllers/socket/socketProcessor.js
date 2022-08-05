import { DisplaysService } from "../../services/displays.service.js";
import { Display } from "../../models/display.js";
import { StreamsSocketManager } from "../../managers/streams/streamsSocketManager.js";
import { GroupService } from "../../services/group.service.js";
import { Group } from "../../models/group.js";
import { StreamService } from "../../services/stream.service.js";
import { Stream } from "../../models/stream.js";
import { TopicService } from "../../services/topic.service.js";
import { Topic } from "../../models/topic.js";
import { EventService } from "../../services/event.service.js";
import { EventStream } from "../../models/eventStream.js";
import { Utils } from "../../services/utils.js";
export class SocketProcessor {
    constructor() {
        this.displays = [];
        this.groupsArray = [];
        this.streamsManager = new StreamsSocketManager();
    }

    async connectClient(displayId, client) {
        let currentDisplay = this.displays.find(d => d.Id === displayId);
        if (currentDisplay !== undefined) {
            currentDisplay.Socket = client;
            if (Utils.checkHasValue(currentDisplay.GroupId)) {
                let selectedGroup = this.groupsArray.find(g => g.Id === currentDisplay.GroupId);
                if (selectedGroup !== undefined) {
                    if (Utils.checkHasValue(selectedGroup.StreamId)) {
                        let selectedStreamSocket = this.streamsManager.findStreamSocketById(selectedGroup.StreamId);
                        if (selectedStreamSocket !== undefined) {
                            selectedStreamSocket.emitCurrentFile(currentDisplay.Socket, currentDisplay.GroupId);
                        }
                    }
                }
            }
        } else {
            let reqDisplay = await DisplaysService.getDisplayById(displayId).catch(() => { });
            if (reqDisplay !== undefined) {
                let display = new Display();
                display.initFromObj(this.getDataFromRequest(reqDisplay));
                display.Socket = client;
                this.addDisplay(display);
                if (Utils.checkHasValue(display.GroupId)) {
                    let groupLoaded = this.findGroupById(display.GroupId);
                    if (groupLoaded === undefined) {
                        await this.loadNewGroup(display);
                    } else {
                        groupLoaded.addDisplay(display);
                        if (Utils.checkHasValue(groupLoaded.StreamId)) {
                            let selectedStreamSocket = this.streamsManager.findStreamSocketById(groupLoaded.StreamId);
                            if (selectedStreamSocket !== undefined) {
                                selectedStreamSocket.emitCurrentFile(display.Socket, display.GroupId);
                            }
                        }
                    }
                }
            }
        }
    }

    getDataFromRequest(req) {
        return JSON.parse(JSON.stringify(req.data));
    }
    findGroupById(groupId) {
        return this.groupsArray.find(g => g.Id === groupId);
    }
    addDisplay(display) {
        if (this.displays.find(d => d.Id === display.Id) === undefined) {
            this.displays.push(display);
        }
    }
    addGroupToArray(group) {
        if (this.findGroupById(group.Id) === undefined) {
            this.groupsArray.push(group);
        }
    }

    async loadNewGroup(fromDisplay) {
        let reqGroup = await GroupService.getGroupById(fromDisplay.GroupId).catch(() => { });
        if (reqGroup !== undefined) {
            let newGroup = new Group();
            newGroup.initFromObj(this.getDataFromRequest(reqGroup));
            newGroup.addDisplay(fromDisplay);
            this.addGroupToArray(newGroup);
            if (Utils.checkHasValue(newGroup.StreamId)) {
                let streamLoaded = this.streamsManager.findStreamById(newGroup.StreamId);
                if (streamLoaded === undefined) {
                    await this.loadNewStreamSocket(newGroup);
                } else {
                    streamLoaded.addGroup(newGroup);
                    let streamSocket = this.streamsManager.findStreamSocketById(streamLoaded.Id);
                    if (streamSocket !== undefined) {
                        streamSocket.emitCurrentFile(fromDisplay.Socket, fromDisplay.GroupId);
                    }
                }
            }
        }
    }
    async loadNewStreamSocket(fromGroup) {
        let reqStream = await StreamService.getStreamById(fromGroup.StreamId).catch(() => { });
        if (reqStream !== undefined) {
            let newStream = new Stream();
            newStream.initFromObj(this.getDataFromRequest(reqStream));
            newStream.addGroup(fromGroup);
            this.streamsManager.createStreamSocket(newStream);
        }
    }
    addClientToDashboardGroup(socket) {
        let d = this.displays.find(display => display.Socket.id === socket.id);
        if (d === undefined) {
            d = new Display();
            d.id = Utils.getRandomUUID();
            d.Socket = socket;
            this.displays.push(d);
        }
        this.streamsManager.addDisplayToDashboardGroup(d);
    }
    disconnectClient(socket) {
        let index = this.displays.findIndex(display => display.Socket.id === socket.id);
        if (index !== -1) {
            let display = this.displays[index];
            this.streamsManager.removeDisplayFromDashboardGroup(display);
            if (Utils.checkHasValue(display.GroupId)) {
                let selectedGroup = this.groupsArray.find(g => g.Id === display.GroupId);
                if (selectedGroup !== undefined) {
                    selectedGroup.removeDisplay(display);
                    this.emitNull(display.Socket);
                }
            }
            this.displays.splice(index, 1);
        }
        //socket.conn.close();
    }

    // ------------------ UPDATE FROM API ---------------------------- //
    async updateDisplay(displayId) {
        let displayLoaded = this.displays.find(d => d.Id === displayId);
        if (displayLoaded !== undefined) {
            let reqUpdateDisplay = await DisplaysService.getDisplayById(displayId).catch(() => { });
            if (reqUpdateDisplay !== undefined) {
                let displayUpdated = new Display();
                displayUpdated.initFromObj(this.getDataFromRequest(reqUpdateDisplay));
                this.emitNull(displayLoaded.Socket);
                if (displayLoaded.GroupId !== displayUpdated.GroupId) {
                    if (Utils.checkHasValue(displayLoaded.GroupId)) {
                        let oldGroup = this.groupsArray.find(g => g.Id === displayLoaded.GroupId);
                        if (oldGroup !== undefined) {
                            oldGroup.removeDisplay(displayLoaded);
                        }
                    }
                    displayLoaded.updateFromDisplay(displayUpdated);
                    if (Utils.checkHasValue(displayLoaded.GroupId)) {
                        let newGroup = this.groupsArray.find(g => g.Id === displayLoaded.GroupId);
                        if (newGroup === undefined) {
                            await this.loadNewGroup(displayLoaded);
                        } else {
                            newGroup.addDisplay(displayLoaded);
                            if (Utils.checkHasValue(newGroup.StreamId)){
                                let streamSocket = this.streamsManager.findStreamSocketById(newGroup.StreamId);
                                if(streamSocket !== undefined){
                                    streamSocket.emitCurrentFile(displayLoaded.Socket, displayLoaded.GroupId);
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    deleteDisplay(displayId){
        let displayLoaded = this.displays.find(d => d.Id === displayId);
        if (displayLoaded !== undefined) {
            this.disconnectClient(displayLoaded.Socket);
        }
    }

    async updateStream(streamId) {
        //let streamLoaded = this.streamsManager.findStreamById(streamId);
       //if (streamLoaded !== undefined) {
            let reqUpdateStream = await StreamService.getStreamById(streamId).catch(() => { });
            if (reqUpdateStream !== undefined) {
                let streamUpdated = new Stream();
                let data = this.getDataFromRequest(reqUpdateStream);
                streamUpdated.initFromObj(data);
                this.streamsManager.deleteStreamSocket(streamId);
                for(let g of data.groups){
                    let selectedGroup = this.groupsArray.find(gr =>gr.Id === g.id);
                    if(selectedGroup!== undefined){
                        selectedGroup.StreamId = streamId;
                        streamUpdated.addGroup(selectedGroup);
                    }
                }
                let create = false;
                for(let g of streamUpdated.Groups){
                    if(g.Displays.length >0){
                        create = true;
                        break;
                    }
                }
                if(create){
                    this.streamsManager.createStreamSocket(streamUpdated);
                }
            }
        //}
    }
    deleteStream(streamId){
       this.streamsManager.deleteStreamSocket(streamId);
    }
    deleteGroup(groupId){
        let index = this.groupsArray.findIndex(g=>g.Id === groupId);
        if(index !== -1){
            let selectedGroup = this.groupsArray[index];
            for(let display of selectedGroup.Displays){
                display.GroupId = null;
                this.emitNull(display.Socket);
            }
            if(Utils.checkHasValue(selectedGroup.StreamId)){
                let selectedStream = this.streamsManager.findStreamById(selectedGroup.StreamId);
                if(selectedStream !== undefined){
                    selectedStream.removeGroup(selectedGroup.Id);
                    for(let dashboardDisplay of this.streamsManager.DashboardGroup.Displays){
                        this.emitNullDashboard(dashboardDisplay.Socket, selectedGroup.streamId);
                    }
                }
            }
            this.groupsArray.splice(index,1);
        }
    }
    async updateEvent(eventId) {
        let reqUpdateEvent = await EventService.getEventById(eventId).catch(() => { });
        if (reqUpdateEvent !== undefined) {
            let eventUpdated = new EventStream();
            eventUpdated.initFromObj(this.getDataFromRequest(reqUpdateEvent));
            let oldStream = this.getStreamByEventId(eventId);
            if (oldStream === null) {
                let newStream = this.streamsManager.findStreamById(eventUpdated.StreamId);
                if (newStream !== undefined) {
                    await this.updateStream(newStream.Id);
                }
            } else {
                await this.updateStream(oldStream.Id);
                if (oldStream.Id !== eventUpdated.StreamId) {
                    await this.updateStream(eventUpdated.StreamId);
                }
            }

        }
    }
    async deleteEvent(eventId) {
        for (let s of this.streamsManager.StreamsSocket) {
            for (let ev of s.Stream.Events) {
                if (ev.Id === eventId) {
                    await this.updateStream(s.Stream.Id);
                    return;
                }
            }
        }
    }
    getStreamByEventId(eventId) {
        for (let s of this.streamsManager.StreamsSocket) {
            for (let ev of s.Stream.Events) {
                if (ev.Id === eventId) {
                    return s.Stream;
                }
            }
        }
        return null;
    }
    async updateTopic(topicId) {
        let reqUpdateTopic = await TopicService.getTopicById(topicId).catch(() => { });
        if (reqUpdateTopic !== undefined) {
            let topicUpdated = new Topic();
            topicUpdated.initFromObj(this.getDataFromRequest(reqUpdateTopic));
            for (let s of this.streamsManager.StreamsSocket) {
                for (let ev of s.Stream.Events) {
                    if (Utils.checkHasValue(ev.Topic)) {
                        if (ev.Topic.Id === topicId) {
                            ev.Topic.updateFromTopic(topicUpdated);
                        }
                    }
                }
            }
        }
    }
    async deleteTopic(topicId) {
        for (let s of this.streamsManager.StreamsSocket) {
            for (let ev of s.Stream.Events) {
                if (Utils.checkHasValue(ev.Topic)) {
                    if (ev.Topic.Id === topicId) {
                        await this.updateStream(s.Stream.Id);
                        break;
                    }
                }
            }
        }
    }
    emitNull(socket){
        socket.emit("load file", { stream_id: null, file_id: null, timer: null, dashboard: null});
    }
    emitNullDashboard(socket, streamId){
        socket.emit("load file", { stream_id: streamId, file_id: null, timer: null, dashboard: null});
    }
    // --------------------------------------------------------------- //
}
// un event peut être déplacé dans un autre stream
// un topic peut exister dans plusieurs events
