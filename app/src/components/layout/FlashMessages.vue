<template>
    <ul class="o-list-unstyled c-flash-message">
        <transition name="c-flash-message__item">
            <li v-for="item in messages" v-bind:class="getClass(item)">
                <div class="o-wrapper c-flash-message__content qa-flash-message" v-html="item.content"></div>
                <span class="u-icon u-icon--small u-icon--white u-pointer c-flash-message__close" @click="removeMessage(item)">
                        <svg>
                            <use xmlns:xlink="http://www.w3.org/1999/xlink" xlink:href="#icon-close"></use>
                        </svg>
                </span>
            </li>
        </transition>
    </ul>
</template>

<script>
    import { mapGetters } from 'vuex';

    export default {
        computed: mapGetters({
            messages: 'flashMessages/getMessages'
        }),

        methods: {

            removeMessage (item) {
                this.$store.dispatch('flashMessages/removeMessage', item);
            },

            getClass(item) {
                return "c-flash-message__item c-flash-message--" + (item.type || 'info');
            }

        }
    }

</script>

<style>
  .c-flash-message--error {
    background: #FF585B;
  }

  .c-flash-message {
    position: fixed;
    width: 98%;
    top: 0;
    transition: 0.3s;
    z-index: 10000;
    list-style-type: none;
    padding: 20px 5px;
    margin: 0;
  }

  .c-flash-message__item {
    opacity: 0.9;
    transition: 0.3s;
    list-style: none;
    height: 5em;
  }

  .c-flash-message a {
    color: #fff;
  }

  .c-flash-message__content {
    color: #fff;
    padding: 24px;
  }
</style>
