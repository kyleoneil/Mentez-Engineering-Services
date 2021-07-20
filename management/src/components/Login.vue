<template>
  <div>
    <v-img
      src="https://wallpaperaccess.com/full/2581470.jpg"
      height="100vh"
    >
      <v-overlay
        light
      >
        <v-container
          class="grey lighten-5 mb-6"
          style="padding: 0px; border-radius:5px"
        >
          <v-row no-gutters>
            <v-col>
              <v-card
                elevation="2"
                width="230px"
                height="400px"
                style="border-radius: 5px 0px 0px 5px"
                light
              >
              <v-container
                style="padding-top: 50px"
              >
                <v-container style="padding-bottom: 0px">
                  <p class="font-weight-medium" style="margin:0%">Login</p>
                </v-container>
                <v-container>
                  <v-text-field
                    v-model="username"
                    label="Username"
                    :rules="rules"
                    hide-details="auto"
                  ></v-text-field>
                </v-container>
                <v-container>
                  <v-text-field
                    v-model="password"
                    type="password"
                    label="Password"
                    :rules="rules"
                    hide-details="auto"
                  ></v-text-field>
                </v-container>
                <v-container class="text-center">
                  <v-btn
                    class=".justify-center"
                    color="primary"
                    elevation="2"
                    small
                    v-on:click="submit()"
                  >
                  Sign In
                  </v-btn>
                </v-container>
              </v-container>
              </v-card>
            </v-col>
            <v-col>
              <v-card
                elevation="2"
                width="500px"
                height="400px"
                style="border-radius: 0px 5px 5px 0px"
              >
                <v-img
                  src="https://thumbs.dreamstime.com/b/d-printing-d-print-blue-background-as-illustration-parallel-lines-branching-out-tree-structure-90867937.jpg"
                  height="100%"
                >
                </v-img>
              </v-card>
            </v-col>
          </v-row>

        </v-container>
      </v-overlay>
    </v-img>
  </div>
</template>

<script>
import axios from 'axios';
export default {
  data(){
    return{
      username:"",
      password:"",

      alignments: [
      'start',
      'center',
      'end',
      ],
      rules: [
        value => !!value || 'Required.',
      ],
    }
  },
  created(){
    this.$store.state.count = 0;
  },
  methods:{
    submit: function(){
      axios({
        method: 'POST',
        url: 'http://localhost:3000/login',
        data: {
          username: this.username,
          password: this.password,
        },
      })
      .then((response) =>{
        if(response.status == 200 && response.data.status == 200){
          this.$store.state.count = 1;
          this.$router.push('/dashboard');
        }
        if(response.status == 200 && response.data.status == 400){
          this.$router.go();
        }
      })
    }
  },
}
</script>