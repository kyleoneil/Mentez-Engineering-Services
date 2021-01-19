<template>
  <v-app>
    <v-main style="padding:46px 0px 0px 170px">
      <app-header></app-header>
      <router-view></router-view>
    </v-main>
  </v-app>
</template>

<script>
import Header from './components/Header.vue'
export default {
  components: {
    'app-header': Header,
  },

  data: () => ({
  }),
};
</script>
