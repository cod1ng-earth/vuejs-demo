<template>
  <div class="demo">
    <h1>Demos</h1>

    <flash-messages></flash-messages>

    <table>
      <tr>
        <th>Conditional</th>
        <td>
          <pre>
&lt;button v-if=&quot;isUserLoggedIn&quot;&gt;Logout&lt;/button&gt;
&lt;button v-else&gt;Login&lt;/button&gt;&lt;br/&gt;
          </pre>
        </td>
        <td>
          <button v-if="isUserLoggedIn">Logout</button>
          <button v-else>Login</button><br/>
          <button @click="isUserLoggedIn = !isUserLoggedIn">Toggle login status</button>
        </td>
      </tr>
      <tr>
        <th>List data</th>
        <td>
          Array: {{ names }}<br/>
        </td>
        <td>
          <ul>
            <li v-for="name in names">{{ name }}</li>
          </ul>
        </td>
      </tr>
      <tr>
        <th>Dynamic elements/event binding</th>
        <td>
          <label for="newName">New name: </label>
          <input id="newName" type="text" v-on:keypress.enter="addNameToList" v-model="newName"/>
          <button @click="addNameToList">add name</button>
        </td>
        <td>
          <ul :title="nrOfNames">
            <li v-for="(name,index) in names" key="index">{{ index }}: {{name}}
              <span @click="removeName(index)">x</span>
            </li>
          </ul>
        </td>
      </tr>
      <tr>
        <th>Components & dynamic attributes</th>
        <td>
          <pre>
&lt;vue-button&gt;&lt;/vue-button&gt;
&lt;vue-button :callback=&quot;showAlert&quot;&gt;&lt;/vue-button&gt;
&lt;vue-button :label=&quot;'another button'&quot;&gt;&lt;/vue-button&gt;
&lt;button @click.once='showAlert'&gt;click once&lt;/button&gt;
          </pre>
        </td>
        <td>
          <vue-button></vue-button><br/>
          <vue-button :callback="showAlert"></vue-button><br/>
          <vue-button :label="'another button'"></vue-button><br/>
          <button @click.once='showAlert'>click once</button>
        </td>
      </tr>
      <tr>
        <th>Input quantity</th>
        <td>
          <strong>Properties</strong><br/>
          interval: 50, min: 100, default: 250, max: 600
        </td>
        <td>
          <vue-input-quantity
            :interval="50"
            :min="100"
            :default="250"
            :max="600">
          </vue-input-quantity>
        </td>
      </tr>
      <tr>
        <th>Slots</th>
        <td colspan="2">
          <my-box></my-box>
          <my-box>
            <template slot="title">My Title</template>
            Lorem ipsum dolor sit amet
          </my-box>
          <my-box>
            <template slot="title">My other box</template>
            <em>Lorem <strong>ipsum</strong> dolor sit amet</em>
            <h2 slot="footer">Footer text</h2>
          </my-box>
        </td>
      </tr>
    </table>
  </div>
</template>

<script>
  import FlashMessages    from '@/components/layout/FlashMessages.vue';
  import VueButton        from '@/components/MyDisablingButton.vue'
  import VueInputQuantity from '@/components/VueInputQuantity.vue'
  import MyBox            from '@/components/MyBox.vue'

  export default {

    data () {
      return {
        newName: '',
        names: ['Bernd', 'Stefan', 'Roman', 'Boris'],
        buttonLabel: 'click me',
        buttonDisabled: false,
        isUserLoggedIn: false
      }
    },

    computed: {
      nrOfNames () {
        return 'The list has ' +  this.names.length + ' names';
      }
    },

    watch: {
      testWatch () {
      }
    },

    methods: {
      addNameToList () {
        this.names.push(this.newName);
        this.newName = ''
      },
      removeName (index) {
        this.names.splice(index,1);
      },
      showAlert () {
        alert('clicked');
      }
    },

    components: {
      VueInputQuantity,
      FlashMessages,
      VueButton,
      MyBox
    }
  }
</script>

<style lang="scss">
  table {
    width: 60%;
    margin: auto 20%;
  }

  th, td {
    text-align: left;
    border: 1px solid #ddd;
    padding: 10px;
  }

  td ul,
  td pre {
    margin: 0;
  }
</style>
