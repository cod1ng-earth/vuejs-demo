class EventBus {

    constructor(vue) {
        this.vue = vue;
    }

    $emit(event, data) {
        return this.vue.$emit(event, data);
    }

    $on(event, callback) {
        return this.vue.$on(event, callback);
    }
    
}

export default  EventBus;
