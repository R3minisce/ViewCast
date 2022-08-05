import { APIController } from "./controllers/http/APIController.js";
import { ClientController } from "./controllers/http/clientController.js";
import { HttpServer } from "./controllers/http/httpServer.js";
import { Config } from "./services/config.js";
import { SocketServer } from "./controllers/socket/socketServer.js";
import { SocketProcessor } from "./controllers/socket/socketProcessor.js";

let socketProcessor = new SocketProcessor();
let clientCtrl = new ClientController();
let apiCtrl = new APIController(socketProcessor);

let socketServer = new SocketServer(socketProcessor);
let httpServer = new HttpServer(apiCtrl, clientCtrl);

httpServer.start(Config.HOSTNAME, Config.HTTPPORT);
socketServer.start();
