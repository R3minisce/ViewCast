import { createServer } from "http";
import { Server } from "socket.io";
import { Config } from "../../services/config.js";
export class SocketServer {

    constructor(socketProcessor) {
        this.socketProcessor = socketProcessor;
        //this.checkingConnection = new Map();
    }
    start() {
        const socketServer = createServer();
        const io = new Server(socketServer);
        this.defineSocket(io);
        this.startListening(socketServer);
    }
    /**
     * Define event listeners for the socket
     * @param io the server that has been created
     */
    defineSocket(io) {
        let self = this;
        io.on('connection', function (client) {
            self.defineClientListeners(client);
        });
    }
    defineClientListeners(client) {
        let self = this;
        client.on('register', async function (message) {
            await self.socketProcessor.connectClient(message.display_id, client);
        });
        client.on('register dashboard', function (message) {
            self.socketProcessor.addClientToDashboardGroup(client);
        });
        client.on('logout', function (message) {
            self.socketProcessor.disconnectClient(client);
        });
        client.once('disconnect', () => {
            this.socketProcessor.disconnectClient(client);
        });
    }

    /**
     * Start the server
     * @param socketServer
     */
    startListening(socketServer) {
        socketServer.listen(Config.SOCKETPORT);
        console.log(`Socket server listening on port: ` + Config.SOCKETPORT);
    }
}
