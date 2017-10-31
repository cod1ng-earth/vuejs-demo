import Vue from 'vue'
import Vuex from 'vuex'
import flashMessages from './modules/flashMessages'

Vue.use(Vuex)

const debug = process.env.NODE_ENV !== 'production';

export default new Vuex.Store({
    modules: {
        flashMessages
    },
    strict: debug,
    //plugins: debug ? [createLogger()] : []
})
