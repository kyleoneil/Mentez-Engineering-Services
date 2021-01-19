<template>
  <div>
    <v-card
      min-height="100vh"
    >
      <v-toolbar
        color="#4DAAA7"
        dark
        flat
      >
        <!-- <v-app-bar-nav-icon style="color:cyan"></v-app-bar-nav-icon> -->
        <v-icon style="margin-right:30px">mdi-wrench</v-icon>

        <v-toolbar-title>Manage</v-toolbar-title>

        <v-spacer></v-spacer>

        <template v-slot:extension>
          <v-tabs
            v-model="tab"
            align-with-title
          >
            <v-tabs-slider color="yellow"></v-tabs-slider>

            <v-tab
              v-for="item in items"
              :key="item"
            >
              {{ item }}
            </v-tab>
          </v-tabs>
        </template>
      </v-toolbar>

      <v-tabs-items v-model="tab">
        <v-tab-item>
          <app-quotations></app-quotations>
        </v-tab-item>
        <v-tab-item>
          <app-materials></app-materials>
        </v-tab-item>
        <v-tab-item>
          <app-subcontractors></app-subcontractors>
        </v-tab-item>

      </v-tabs-items>
    </v-card>
  </div>  
</template>

<script>
import Quotations from './Quotations.vue'
import Materials from './Materials.vue'
// import Projects from './Projects.vue'
import SubContractors from './SubContractors.vue'

export default {
  components: {
    'app-quotations': Quotations,
    'app-materials': Materials,
    // 'app-projects': Projects,
    'app-subcontractors': SubContractors,
  },
  data: ()=>{
    return {
      tab: null,
      items: [
        'quotations', 'materials', 'subcontractors',
      ],
      text: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.',
    }
  },
}
</script>