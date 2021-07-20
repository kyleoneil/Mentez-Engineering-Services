import Vue from 'vue'
import App from './App.vue'
import VueRouter from 'vue-router'
import Routes from './routes'
import vuetify from './plugins/vuetify';
import Vuex from 'vuex'
import createPersistedState from 'vuex-persistedstate'


Vue.use(Vuex)

const store = new Vuex.Store({
  plugins: [createPersistedState({
    storage: window.sessionStorage,
  })],
  state:{
    count:0,
    logged:0,
  },
  mutations: {
    increment (state){
      state.count++
    }
  }
})

Vue.config.productionTip = false;
Vue.use(VueRouter);

const router = new VueRouter({
  routes: Routes
})

new Vue({
  el: '#app',
  render: h => h(App),
  vuetify,
  router: router,
  store: store
})
