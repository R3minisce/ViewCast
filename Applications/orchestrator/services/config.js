export class Config {
    static HOSTNAME = "0.0.0.0";
    static SOCKETPORT = 3000;
    static HTTPPORT = 3001;
    static SERVERURL = "http://viewcast_api:8000";
    static DISPLAYURL = Config.SERVERURL + "/display/";
    static GROUPURL = Config.SERVERURL + "/group/";
    static STREAMURL = Config.SERVERURL + "/stream/";
    static TOPICURL = Config.SERVERURL + "/topic/";
    static EVENTURL = Config.SERVERURL + "/event/";
}
