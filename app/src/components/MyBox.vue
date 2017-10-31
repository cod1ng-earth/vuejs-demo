<template>
  <div class="box" v-show="isVisible">
    <h1>
      <slot name="title">Default title</slot>
      <div>
        <span @click="toggleContent" v-text="toggleLabel"></span>
        <span @click="isVisible = false">x</span>
      </div>
    </h1>
    <div v-show="showContent">
      <p>
        <slot>
          Default content
        </slot>
      </p>
      <p v-show="showContent">
        <slot name="footer"></slot>
      </p>
    </div>
  </div>
</template>

<script>
  export default {
    data () {
      return {
        isVisible: true,
        showContent: false,
        toggleLabel: '+'
      }
    },

    methods: {
      toggleContent () {
        this.toggleLabel = this.toggleLabel == '+' ? '-': '+';
        this.showContent = !this.showContent;
      }
    }

  }

</script>

<style>
  .box {
    border: 2px solid #333;
    margin: 5px;
  }

  .box h1, .box p {
    margin: 0;
    padding: 3px;
  }

  .box h1 {
    position: relative;
    font-size: 1.2em;
    background-color: #ddd;
  }

  .box h1 div {
    font-weight: normal;
    position: absolute;
    right: 1%;
    top: 1%;
  }
</style>
