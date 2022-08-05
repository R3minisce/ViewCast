import crypto from "crypto";

export class Utils {

    /**
     * @param time string hh:mm
     * @returns tableau [0]= heure , [1] = minute
     */
    static extractHourMinuteFromTime(time) {
        let data = time.split(':');
        for (let i = 0; i < data.length; i++) {
            data[i] = parseInt(data[i]);
        }
        return {
            hour: data[0],
            minute: data[1]
        };
    }

    /**
     *
     * @param datetime yyyy-mm-dd
     * @returns tableau [0]= year , [1] = month,  [2] = day
     */
    static convertStringDatetimeToDate(datetime) {
        let data = datetime.split("-");
        for (let i = 0; i < data.length; i++) {
            data[i] = parseInt(data[i]);
        }
        return {
            year: data[0],
            month: data[1],
            day: data[2]
        };
    }
    static getDateCurrentUTC() {
        let date = new Date(Date.now());
        const offset = date.getTimezoneOffset();
        return new Date(date.getTime() - offset * 60000)
    }
    static convertDateToCurrentUTC(date) {
        let now = new Date(Date.now());
        let offset = now.getTimezoneOffset();
        return new Date(date.getTime() - offset * 60000)
    }
    static getRandomUUID(){
        return  crypto.randomBytes(16).toString("hex");
    }
    static checkHasValue(val) {
        return val !== undefined && val !== null;
    }
}
