export class Topic {
    initFromObj(o) {
        this.id = o.id;
        this.files_ids = o.files_ids;

    }
    updateFromTopic(topic){
        this.files_ids = topic.files_ids;
    }
    get Id() {
        return this.id;
    }
    get FilesIds() {
        return this.files_ids;
    }
}
