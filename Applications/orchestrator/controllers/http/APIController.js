export class APIController {
    constructor(socketProcessor) {
        this.socketProcessor = socketProcessor;
    }

    /**
     * Define end points
     * @param server instance of server
     */
    defineEndPoints(server) {
        this.updateData(server);
        this.deleteData(server);
    }

    updateData(server) {
        server.get('/update/display/:id', async (req, res) => {
            let displayId =  parseInt(req.params.id);
            if(!isNaN(displayId)){
                await this.socketProcessor.updateDisplay(displayId);
            }
            res.sendStatus(200);
        });

        server.get('/update/topic/:id', async (req, res) => {
            let topicId =  parseInt(req.params.id);
            if(!isNaN(topicId)){
                await this.socketProcessor.updateTopic(topicId);
            }
            res.sendStatus(200);
        });
        server.get('/update/event/:id', async (req, res) => {
            let eventId =  parseInt(req.params.id);
            if(!isNaN(eventId)){
                await this.socketProcessor.updateEvent(eventId);
            }
            res.sendStatus(200);
        });
        
        server.get('/update/stream/:id', async (req, res) => {
            let streamId = parseInt(req.params.id);
            if(!isNaN(streamId)){
                await this.socketProcessor.updateStream(streamId);
            }
            res.sendStatus(200);
        });
    }
    deleteData(server){
        server.delete('/display/:id', async (req, res) => {
            let displayId =  parseInt(req.params.id);
            if(!isNaN(displayId)){
                this.socketProcessor.deleteDisplay(displayId);
            }
            res.sendStatus(200);
        });
        server.delete('/topic/:id', async (req, res) => {
            let topicId =  parseInt(req.params.id);
            if(!isNaN(topicId)){
                await this.socketProcessor.deleteTopic(topicId);
            }
            res.sendStatus(200);
        });
        server.delete('/event/:id', async (req, res) => {
            let eventId =  parseInt(req.params.id);
            if(!isNaN(eventId)){
                await this.socketProcessor.deleteEvent(eventId);
            }
            res.sendStatus(200);
        });
        server.delete('/stream/:id', async (req, res) => {
            let streamId =  parseInt(req.params.id);
            if(!isNaN(streamId)){
                await this.socketProcessor.deleteStream(streamId);
            }
            res.sendStatus(200);
        });
        server.delete('/group/:id', async (req, res) => {
            let groupId =  parseInt(req.params.id);
            if(!isNaN(groupId)){
                await this.socketProcessor.deleteGroup(groupId);
            }
            res.sendStatus(200);
        });
    }
}
