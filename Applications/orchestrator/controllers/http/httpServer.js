import express from "express";
import bodyParser from "body-parser";

export class HttpServer {
    constructor(...controllers) {
        this.controlers = controllers;
    }

    /**
     * Server initialization
     * @param hostname server hostname
     * @param port server port
     */
    start(hostname, port) {
        const server = express();
        server.use(bodyParser.json());
        this.defineCors(server);
        this.defineEndPoints(server);
        server.listen(port, hostname, () => {
            console.log(`Http server running at http://${hostname}:${port}/`);
        });
    }
    /**
     * Defines Cors
     * @param server instance of server
     */
    defineCors(server) {
        // https://stackoverflow.com/questions/10695629/what-is-the-parameter-next-used-for-in-express
        server.use((req, res, next) => {
            res.setHeader('Access-Control-Allow-Origin', '*');
            res.setHeader('Access-Control-Allow-Headers', 'Origin, X-Requested-With, Content, Accept, Content-Type, Authorization');
            res.setHeader('Access-Control-Allow-Methods', 'GET, POST, PUT, DELETE, PATCH, OPTIONS');
            next();
        });
    }
    defineEndPoints(server) {
        for (let ctrl of this.controlers) {
            ctrl.defineEndPoints(server);
        }
    }
}
