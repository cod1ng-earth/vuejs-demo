export default {
    namespaced: true,
    state: {
        messages: [],
    },
    mutations: {

        addMessage(state, newMessage) {
            state.messages.push(newMessage);
        },

        removeMessage(state, messageToRemove) {
            let index = state.messages.indexOf(messageToRemove);
            state.messages.splice(index, 1);
        }

    },
    actions: {

        addMessage({commit}, newMessage) {
            commit('addMessage', newMessage);
            setTimeout(() => commit('removeMessage', newMessage), newMessage.timeout || 4000);
        },

        removeMessage({commit}, messageToRemove) {
            commit('removeMessage', messageToRemove);
        }

    },
    getters: {
        getMessages(state) {
            return state.messages;
        }
    }
}
