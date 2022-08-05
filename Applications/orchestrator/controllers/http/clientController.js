export class ClientController {
    constructor() {
    }

    /**
     * Define end points
     * @param server instance of server
     */
    defineEndPoints(server) {
        this.defineConnection(server);
    }
    defineConnection(server) {
        server.post('/login', (req, res) => {

        });
        server.post('/logout', (req, res) => {

        });
    }
}
