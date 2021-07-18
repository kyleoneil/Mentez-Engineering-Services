<template>
  <v-app>
    <v-main style="padding:46px 0px 0px 170px" v-if="this.$store.state.count==1">
      <app-header></app-header>
      <router-view></router-view>
    </v-main>
    <v-main style="padding:1px 1px 1px 1px" v-if="this.$store.state.count==0">
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
