/* eslint-disable */
<template>
  <div class="c-vue-input-quantity o-grid o-grid--center">

    <div class="o-grid__item c-vue-input-quantity__input-wrapper">
      <input type="number" name="input-qty" class="c-vue-input-quantity__input"
             v-model="value" @change="changeInputQtyEventHandler" :value="minValue" :min="minValue" :max="maxValue"/>
    </div>

    <span class="c-vue-input-quantity__controls o-grid__item">

            <button type="button" class="c-vue-input-quantity__btn qa-input-qty-decrement"
                    v-bind:class="{ disabled: isValueMin }"
                    @click.stop=" () => {}" @mousedown.stop="(isValueMin ? null : mouseDownEventHandler(false))"
                    @mouseup.stop="mouseUpEventHandler">
                <span class="u-icon u-icon--small">
                    <span>-</span>
                </span>
            </button>

            <button type="button" class="c-vue-input-quantity__btn qa-input-qty-increment"
                    v-bind:class="{ disabled: isValueMax }"
                    @click.stop=" () => {}" @mousedown.stop="(isValueMax ? null : mouseDownEventHandler(true))"
                    @mouseup.stop="mouseUpEventHandler">
                <span class="u-icon u-icon--small">
                  <span>+</span>
                </span>
            </button>

        </span>

  </div>
</template>

<script>
  /**
   * input quantity component, considering:
   *
   * - intervall (e.g. MPQ - minimum package qty)
   * - min (e.g. MOQ - minimum order qty)
   * - max <optional> (e.g. stock quantity - if not set, then there is no max - unlimited!)
   *
   * Usage:
   * <input-quantity :interval=5 :min=10 :max=100></input-quantity>
   */

  import TypeValidations from '@/helpers/type-validations'

  export default {

    props: {
      interval: {type: Number, required: true},   // e.g. Minimum Package Quantity
      min: {type: Number, required: true},        // e.g. Minimum Order Quantity
      max: {type: Number},                        // e.g. Stock Quantity
      default: {type: Number}
    },

    data () {
      return {
        value: this.default || this.getMinimumValue(this.min, this.interval), // initial value
        minValue: this.getMinimumValue(this.min, this.interval),
        maxValue: this.max,
        unlimited: !this.max,
        showError: false,
        mouseDown: false,
        errorMessage: 'Error: wrong quantity<br/>' +
        'The quantity was set to a reasonable value'
      }
    },

    watch: {
      computedValue () {
        this.$emit('valueChanged', this.computedValue);
      },
      min () {
        this.value = this.getMinimumValue(this.min, this.interval);
        this.minValue = this.getMinimumValue(this.min, this.interval);
        this.maxValue = this.max;
        this.unlimited = !this.max;
      },
      default () {
        this.value = this.default;
      }
    },

    mounted () {
      this.$emit('valueChanged', this.computedValue);
    },

    computed: {
      computedValue () {
        return parseInt(this.value);
      },

      isValueMax () {
        if (this.unlimited) {
          return false;
        }

        return this.computedValue === this.maxValue;
      },

      isValueMin () {
        return this.computedValue === this.minValue;
      }
    },

    methods: {
      incrementInputQtyEventHandler () {
        this.setInputQty(this.computedValue + this.interval);
      },

      decrementInputQtyEventHandler () {
        this.setInputQty(this.computedValue - this.interval);
      },

      changeInputQtyEventHandler () {
        if (!this.canUpdateInput(this.computedValue)) {
          this.setNextBestInputQty ();
        }
      },

      /**
       * flag = true to increment
       * flag = false to decrement
       * @param flag
       */
      mouseDownEventHandler(flag) {
        this.mouseDown = true;
        this.mousePressed(flag);
      },

      mouseUpEventHandler () {
        this.mouseDown = false;
      },

      mousePressed(flag) {
        if (this.mouseDown) {
          if (flag) {
            this.incrementInputQtyEventHandler ();
          } else {
            this.decrementInputQtyEventHandler ();
          }

          let self = this;
          setTimeout(function () {
            self.mousePressed(flag);
          }, 150);
        }
      },

      canUpdateInput(newValue) {
        return TypeValidations.isInt(newValue)
          && !this.isValueOutOfBounds(newValue)
          && this.isValueMultipleOfInterval(newValue);
      },

      getMinimumValue(min, interval) {
        if (min <= interval) {
          return interval;
        }

        if ((min % interval) === 0) {
          return min;
        }

        let value = interval * Math.ceil(min / interval);
        this.$emit('valueChanged', value);

        return value;
      },

      isValueOutOfBounds(value) {
        if (value < this.minValue) {
          return true;
        }

        if (!this.unlimited && value > this.maxValue) {
          return true;
        }

        return false;
      },

      isValueMultipleOfInterval(value) {
        return value % this.interval === 0
      },

      setInputQty(newValue) {
        if (this.canUpdateInput(newValue)) {
          this.value = newValue;
        } else {
          this.showErrorMessage ();
        }
        this.mouseDown = false;
      },

      setNextBestInputQty () {
        let wrongValue = this.computedValue;
        let nextBestValue = this.minValue;

        if (!this.unlimited && wrongValue > this.maxValue) {
          nextBestValue = this.maxValue;
        } else if (wrongValue > this.minValue) {
          nextBestValue = Math.round(wrongValue / this.interval) * this.interval;
        }

        this.setInputQty(nextBestValue);
        this.showErrorMessage ();
      },

      showErrorMessage () {
        this.$store.dispatch('flashMessages/addMessage',
          {content: this.errorMessage, type: 'error'},
          {root: true}
        );
      }
    }
  }
</script>

<style type="text/scss">
  /*------------------------------------*\
    #input quantity component
  \*------------------------------------*/

  *, *:before, *:after {
    -webkit-box-sizing: inherit;
    -moz-box-sizing: inherit;
    box-sizing: inherit;
  }

  .c-vue-input-quantity {
    font-family: 'Open Sans';
    min-width: 180px;
    max-width: 180px;
    position: relative;
    border-collapse: separate;
    border-radius: 6px;
    border: 1px solid #7ED321;
    box-shadow: inset 0 1px 1px rgba(0, 0, 0, 0.075);
    background-color: #7ED321;
  }

  .c-vue-input-quantity__input-wrapper {
    flex: none;
    width: 70%;
  }

  .c-vue-input-quantity .c-vue-input-quantity__input {
    margin-bottom: 0;
    border: none;
    background-color: #7ED321 !important;
    color: white;
    box-shadow: none;
    height: 38px;
    background-image: none;
    text-align: right;
    font-size: 18px;
  }

  .c-vue-input-quantity .c-vue-input-quantity__input::-webkit-inner-spin-button,
  .c-vue-input-quantity .c-vue-input-quantity__input::-webkit-outer-spin-button {
    -webkit-appearance: none;
    margin: 0;
  }

  .c-vue-input-quantity__controls{
    margin-top: 6px;
  }

  .c-vue-input-quantity__btn {
    cursor: pointer;
    background: transparent;
    padding: 0;
  }

  .o-grid__item {
    display: inline;
  }

  button, html [type="button"], [type="reset"], [type="submit"] {
    -webkit-appearance: button;
  }

  button {
    outline: none;
    border: 0;
  }

  button, select {
    text-transform: none;
  }

  .u-icon {
    display: flex;
    align-items: center;
  }

  .u-icon span {
    font-size: 36px;
    padding: 2px;
    display: inline-block;
    width: 1em;
    height: 1em;
    border: 1px #fff solid;
  }

  .u-icon--small span {
    font-size: 24px;
    margin-top: 5px;
  }

</style>
