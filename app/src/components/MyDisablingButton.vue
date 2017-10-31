<template>
  <button :disabled="disabled" @click="isClicked">{{ dynamicLabel }}</button>
</template>

<script>

  export default {

    props: {
      callback: {
        type: Function,
        default: function() {}
      },
      label: {
        type: String,
        default: 'click me'
      }
    },

    data () {
      return {
        disabled: false
      }
    },

    computed: {
      dynamicLabel () {
        return this.disabled ? 'clicked' : this.label;
      }
    },

    methods: {
      isClicked() {
        this.disabled = true;
        this.callback();
        this.$store.dispatch('flashMessages/addMessage',
          {content: 'click', type: 'error'}
        );
      },
    }
  }

</script>
