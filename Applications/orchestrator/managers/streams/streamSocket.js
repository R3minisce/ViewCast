import { Utils } from "../../services/utils.js";

export class StreamSocket {
    constructor(stream, streamSocketManager) {
        this.stream = stream;
        this.filesLoop = null;
        this.currentFileIndex = 0;
        this.currentFileId = null;
        this.currentTimer = null;
        this.stopStream = false;
        this.activeEvents = [];
        this.streamSocketManager = streamSocketManager;
        this.init();
    }

    init() {
        let currentEvent = this.getCurrentEvent();
        if (currentEvent !== null) {
            this.startFilesLoop(currentEvent);
        }
        this.setupNextEvent();
    }

    getCurrentEvent() {
        //let currentDate = Utils.convertDateToCurrentUTC(new Date(Date.now()));
        let currentDate = new Date(Date.now());
        for (let e of this.stream.Events) {
            if (this.isCurrentEvent(e, currentDate)) {
                return e;
            }
        }
        return null;
    }
    isCurrentEvent(ev, currentDate) {
        if (ev.isRecurrent()) {
            let currentDay = currentDate.getDay();
            currentDay === 0 ? currentDay = 6 : currentDay -= 1;
            if (parseInt(ev.Days.charAt(currentDay)) === 1) {
                let start = this.getStartDate(currentDate, ev);
                let end = this.getEndDate(currentDate, ev);
                if (currentDate - start >= 0 && end - currentDate > 0) {
                    return true;
                }
            }
        } else {
            let start = this.getStartDate(null, ev);
            let end = this.getEndDate(null, ev);
            if (currentDate - start >= 0 && end - currentDate > 0) {
                return true;
            }
        }
        return false;
    }
    getStartDate(baseDate, ev) {
        if (ev.isRecurrent()) {
            let convertStartHours = Utils.extractHourMinuteFromTime(ev.StartHour);
            return new Date(baseDate.getFullYear(), baseDate.getMonth(), baseDate.getDate(), convertStartHours.hour, convertStartHours.minute);
        } else {
            let convertDate = Utils.convertStringDatetimeToDate(ev.SpecificDate);
            let convertStartHours = Utils.extractHourMinuteFromTime(ev.StartHour);
            return new Date(convertDate.year, convertDate.month - 1, convertDate.day, convertStartHours.hour, convertStartHours.minute);
        }
    }
    getEndDate(baseDate, ev) {
        if (ev.isRecurrent()) {
            let convertEndHours = Utils.extractHourMinuteFromTime(ev.EndHour);
            return new Date(baseDate.getFullYear(), baseDate.getMonth(), baseDate.getDate(), convertEndHours.hour, convertEndHours.minute);
        } else {
            let convertDate = Utils.convertStringDatetimeToDate(ev.SpecificDate);
            let convertEndHours = Utils.extractHourMinuteFromTime(ev.EndHour);
            return new Date(convertDate.year, convertDate.month - 1, convertDate.day, convertEndHours.hour, convertEndHours.minute);
        }
    }
    getNextEvent() {
        let currentDate = new Date(Date.now());
        let nextEvent = null;
        let nextEventTimer = null;
        for (let ev of this.stream.Events) {
            if (ev.isRecurrent()) {
                for (let i = 0; i < ev.Days.length; i++) {
                    if (parseInt(ev.Days.charAt(i)) === 1) {
                        let nextBaseDate;
                        let currentDay = currentDate.getDay();
                        currentDay === 0 ? currentDay = 6 : currentDay -= 1;
                        let dayDiff = i - currentDay;
                        if (dayDiff < 0) {
                            dayDiff = 7 - currentDay + i;
                        }
                        nextBaseDate = new Date(currentDate.getFullYear(), currentDate.getMonth(), currentDate.getDate());
                        nextBaseDate.setDate(nextBaseDate.getDate() + dayDiff);

                        let startDate = this.getStartDate(nextBaseDate, ev);
                        let diff = startDate - currentDate;
                        if (diff > 0) {
                            if (nextEventTimer === null) {
                                nextEvent = ev;
                                nextEventTimer = diff;
                            } else {
                                if (nextEventTimer > diff) {
                                    nextEvent = ev;
                                    nextEventTimer = diff;
                                }
                            }
                        }
                    }
                }
            } else {
                let startDate = this.getStartDate(null, ev);
                let diff = startDate - currentDate;
                if (diff > 0) {
                    if (nextEventTimer === null) {
                        nextEvent = ev;
                        nextEventTimer = diff;
                    } else {
                        if (nextEventTimer > diff) {
                            nextEvent = ev;
                            nextEventTimer = diff;
                        }
                    }
                }
            }
        }
        return {
            nextEvent: nextEvent,
            timer: nextEventTimer
        };
    }

    startFilesLoop(currentEvent) {
        if (this.stopStream)
            return;
        let self = this;
        this.stopFilesLoop();
        this.activeEvents.push(currentEvent);
        let now = new Date(Date.now());
        if(Utils.checkHasValue(currentEvent.Topic.FilesIds)){
            if (currentEvent.Topic.FilesIds.length > 0) {
                this.emitLoadFile(currentEvent.Topic.FilesIds[this.currentFileIndex], currentEvent.Timer);
            }
            setTimeout(function () {
                self.removeActiveEvent(currentEvent);
            }, this.getEndDate(now, currentEvent) - now);
    
            this.filesLoop = setInterval(function () {
                self.currentFileIndex += 1;
                if (self.currentFileIndex >= currentEvent.Topic.FilesIds.length) {
                    self.currentFileIndex = 0;
                }
                if (currentEvent.Topic.FilesIds.length > 0) {
                    self.emitLoadFile(currentEvent.Topic.FilesIds[self.currentFileIndex], currentEvent.Timer);
                }
            }, currentEvent.Timer * 1000);
        }
        this.setupNextEvent();
    }
    stopFilesLoop() {
        if (this.filesLoop !== null) {
            clearInterval(this.filesLoop);
        }
        this.emitStop();
        this.currentFileIndex = 0;
        this.currentFileId = null;
        this.currentTimer = null;
        //this.setupNextEvent()
    }
    setupNextEvent() {
        if (this.stopStream)
            return;
        let nextEventInfo = this.getNextEvent();
        if (nextEventInfo.nextEvent !== null) {
            this.startTimerNextEvent(nextEventInfo.nextEvent, nextEventInfo.timer);
        }
    }
    startTimerNextEvent(ev, ms) {
        if (this.stopStream)
            return;
        let self = this;
        setTimeout(function () {
            self.startFilesLoop(ev);
        }, ms);
    }

    removeActiveEvent(ev){
        let index = this.activeEvents.findIndex(e => e.Id === ev.Id);
        if(index !== -1){
            if(this.activeEvents.length === 1){
                this.stopFilesLoop();
                this.activeEvents.splice(index,1);
            }
            if(this.activeEvents.length > 1){
                if(index === this.activeEvents.length -1){
                    this.stopFilesLoop();
                    this.activeEvents.splice(index,1);
                    this.startFilesLoop(this.activeEvents[this.activeEvents.length-1]);
                }else{
                    this.activeEvents.splice(index,1);
                }
            }
        }
    }

    emitLoadFile(idFile, nextFileTimer) {
        this.currentFileId = idFile;
        this.currentTimer = nextFileTimer;
        this.broadcastLoadFileToAll(this.stream.Id, idFile, nextFileTimer);
    }
    emitStop(){
        this.broadcastLoadFileToAll(this.stream.Id, null, null);
    }

    broadcastLoadFileToAll(streamId, fileId, timer){
        let cpt =0;
        for (let group of this.stream.Groups) {
            let dashboard = group.Id === "dashboard";
            for (let display of group.Displays) {
                if(!dashboard){
                    cpt++;   
                }
                display.Socket.emit("load file", { stream_id: streamId, file_id: fileId, timer: timer, dashboard: dashboard});
            }
        }
        if(cpt === 0){
            if(this.stopStream)
                return;
            this.stopStream = true;
            this.streamSocketManager.deleteStreamSocket(this.Stream.Id);
        }
    }

    /**
     * Utilisateur rejoint le stream, chargement de l'image en cours
     * @param socket
     */
    emitCurrentFile(socket, groupId) {
        let dashboard = groupId === "dashboard";
        socket.emit("load file", { stream_id: this.stream.Id, file_id: this.currentFileId, timer: this.currentTimer, dashboard: dashboard });
    }
    closeStream() {
        this.stopFilesLoop();
        this.stopStream = true;
    }
    get Id() {
        return this.stream.Id;
    }
    get Stream() {
        return this.stream;
    }
}
