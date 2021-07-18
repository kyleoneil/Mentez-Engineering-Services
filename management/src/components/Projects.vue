<template>
  <div>
    <v-text-field
      v-model="project.project_description"
      label="UWAW"
    ></v-text-field>
    <v-btn
      v-on:click="submit()"
    >
      WUW
    </v-btn>
  </div>  
</template>

<script>
import axios from 'axios';
export default {
  data: () => {
    return {
      project: {
        project_description: "WW",
        project_type: "",
        date_from: new Date().toISOString().substr(0, 10),
        date_until: new Date().toISOString().substr(0, 10),

        project_street: "",
        project_barangay: "",
        project_city: "",
        project_postal_code: "",
      },
      customer: {
        customer_name: "",

        customer_street: "",
        customer_barangay: "",
        customer_city: "",
        customer_postal_code: "",
      },
      material: {
        material_name: "",
        material_description: "",
        material_quantity: "",
        material_price: "",
      },
      subcontractor: {
        subcontractor_name: "",
        subcontractor_service: "",
      },

      quoatations:{},

      direction: 'top',
      fab: false,
      hover: false,
      top: false,
      right: false,
      bottom: false,
      left: false,
      transition: 'slide-y-reverse-transition',

      dialog: false,
      step: 1,
      
      menu: false,
      modal: false,
      menu2: false,
    }
  },
  computed: {
    currentTitle () {
      switch (this.step) {
        case 1: return 'Project Information'
        case 2: return 'Customer Profile'
        case 3: return 'Materials'
        default: return 'Charges'
      }
    },
  },
  created(){
    axios({
      method: 'GET',
      url: 'http://localhost:3000/quoatation',
    })
    .then((response) =>{
      if(response.status == 200 && response.data.status == 200){
        this.quoatations = response.data.quoatations;
      }
      if(response.status == 200 && response.data.status == 400){
        this.$router.go('/dashboard');
      }
    })
  },
  methods:{
    submit: function(){
      console.log(this)
    }
  }
}
</script>