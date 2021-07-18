<template>
  <div>
    <v-container style="text-align: left;">
        <h1 style="display:inline;">Account List</h1>
        <v-dialog v-model="dialog" width="500">
            <template v-slot:activator="{ on, attrs }">
                <v-btn style="display: inline; float: right;" color="#CB2F4B" class="white--text" v-bind="attrs" v-on="on">
                    Create Account
                </v-btn>
            </template>

            <v-card>
                <v-card-title class="headline grey lighten-2">
                    Create
                </v-card-title>

                <v-card-text>
                    <!-- <v-form class="px-3" @submit="postData" method="post" href="http://localhost:3000/register"> -->
                        <v-text-field :rules="inputRules" label="FullName" prepend-icon="mdi-pencil" v-model="people.name" clearable></v-text-field>
                        <v-text-field :rules="emailRules" label="Email Address" prepend-icon="mdi-email" v-model="people.email" clearable></v-text-field>
                        <v-text-field :rules="inputRules" label="UserName"  prepend-icon="mdi-account" v-model="people.username" clearable></v-text-field>
                        <v-text-field :rules="inputRules" label="Password"  prepend-icon="mdi-lock" v-model="people.password" clearable></v-text-field>
                        
                        <v-divider></v-divider>

                        <v-card-actions>
                            <v-spacer></v-spacer>
                            <v-btn color="primary" text @click="dialog = false">
                                Cancel
                            </v-btn>
                    
                            <v-btn color="primary" text @click="dialog = false" v-on:click="postData()">
                                Submit
                            </v-btn>
                        </v-card-actions>
                    <!-- </v-form> -->
                </v-card-text>
            </v-card>
        </v-dialog>
        <v-divider></v-divider>
        <v-container class="mx-2">
            <v-layout row wrap>
                <v-flex xs12 sm6 md4 lg3 v-for="(person, x) in use" :key="x"  >
                    <v-card class="text-center ma-3" style="background-color: #E5E5E5;">
                        <v-responsive class="pt-4">
                            <v-avatar size="100" >
                                <img :src="picture">
                            </v-avatar>
                        </v-responsive>
                        <v-card-text>
                            <div class="font-weight-bold">{{person.Name}}</div>
                            <div class="grey--text">{{person.Email}}</div>
                        </v-card-text>
                       
                        <v-dialog v-model="gwapo" max-width="500px" :retain-focus="false">
                            <template v-slot:activator="{ on }">
                            <v-btn color="#F05898"  class="mb-3" v-bind:id="person.UserID" v-on="on" v-on:click="manageData($event)">
                                <v-icon small left>mdi-wrench</v-icon>
                                <span>Manage</span>
                            </v-btn>
                            </template>
                            <v-card>
                                <v-card-title class="headline grey lighten-2">
                                    <span>Manage</span>
                                    <v-spacer></v-spacer>
                                    <v-btn icon @click="gwapo = false, hide = true">
                                        <v-icon>mdi-close</v-icon>
                                    </v-btn>
                                </v-card-title>
                                <v-card-text>
                                    <v-form class="px-3">
                                        <v-card-text>
                                            <div class="font-weight-bold ma-2">
                                                <v-icon small left>mdi-pencil</v-icon>
                                                <span v-show="hide">{{Fullname}}</span>
                                                <span class="ml-3"><input type="text"  v-show="!hide" v-model="Fullname" /></span>
                                            </div>
                                            <div class="font-weight-bold ma-2">
                                                <v-icon small left>mdi-email</v-icon>
                                                <span v-show="hide">{{EmailAddress}}</span>
                                                <span class="ml-3"><input type="text" v-show="!hide" v-model="EmailAddress" /></span>
                                            </div>
                                            <div class="font-weight-bold ma-2">
                                                <v-icon small left>mdi-account</v-icon>
                                                <span v-show="hide">{{Username}}</span>
                                                <span class="ml-3"><input type="text" v-show="!hide" v-model="Username"/></span>
                                            </div>
                                        </v-card-text>
                                        <v-divider></v-divider>

                        <v-card-actions>
                            <v-btn color="primary" v-show="hide" text @click="updateBtn()">
                                <v-icon left>mdi-delete</v-icon>
                            </v-btn>
                            <v-spacer></v-spacer>
                             <v-btn color="primary" v-show="hide" text @click="hide = false">
                                Edit
                            </v-btn>
                            <v-btn color="primary" v-show="!hide" text @click="hide = true">
                                Cancel
                            </v-btn>
                            <v-btn color="primary" v-show="!hide" text @click="downdateBtn()">
                                Submit
                            </v-btn>
                        </v-card-actions>
                                    </v-form>
                                </v-card-text>
                            </v-card>
                        </v-dialog>
                    
                    </v-card>
                </v-flex>
            </v-layout>
        </v-container>                  
    </v-container>
  </div>  
</template>
<script>
import axios from 'axios';
export default {
    data() {
        return{
            // people: [
            //     {name: 'Euniel Van Jamero', contact: '09876567654', avatar:'/qiqi.jpg', username:'Username', password:'Password'},
            //     {name: 'kyle Onil Albarando', contact: '09876545654', avatar:'/paimon.jpeg', username:'Username', password:'Password'},
            //     {name: 'Carl James Balingit', contact: '09872347654', avatar:'/yaoya.png', username:'Username', password:'Password'},
            //     {name: 'Maurice Lance Tezon', contact: '09876347654', avatar:'/diona.jpg', username:'Username', password:'Password'},
            //     {name: 'Van Jamero Euniel', contact: '09876347654', avatar:'/qiqi.jpg', username:'Username', password:'Password'},
            //     {name: 'Onil Albarando Kyle', contact: '09876347654', avatar:'/paimon.jpeg', username:'Username', password:'Password'},
            //     {name: 'James Balingit Carl', contact: '09876347654', avatar:'/yaoya.png', username:'Username', password:'Password'},
            //     {name: 'Lance Tezon Maurice', contact: '09876347654', avatar:'/diona.jpg', username:'Username', password:'Password'},
            // ],
            picture: '/qiqi.jpg',
            people:{name:'', email:'', username: '', password: ''},
            use:"",
            gwapo: false,
            dialog: false,
            hide: true,
            Fullname:"",
            EmailAddress:"",
            Username:"",
            id:"",
            inputRules:[
                v => v.length >= 3 || '3 Characters above'
            ],
            emailRules: [
        v => !!v || 'E-mail is required',
        v => /.+@.+/.test(v) || 'E-mail must be valid',
      ],
        }
    },
    methods:{
        postData: function(){
            
            axios({
                method: 'POST',
                url: 'http://localhost:3000/register',
                data: {
                    data:{
                    name: this.people.name,
                    email: this.people.email,
                    username: this.people.username,
                    password: this.people.password
                    }
                },
            })
            .then((result)=>{
                console.log(result)
            })
        },

        manageData:function(event){
            this.id = event.currentTarget.id

            
            axios({
                method: 'GET',
                url: 'http://localhost:3000/users/get?id=' + this.id,
            })
            .then((result)=>{
                const data = result.data;
                this.Fullname = data[0].Name;
                this.EmailAddress = data[0].Email;
                this.Username = data[0].Username
                console.log(data[0].Username)
            })
        },

        
        downdateBtn: function(){
            this.hide = true

            console.log(this.Fullname)
            console.log(this.EmailAddress)
            axios({
                method: 'POST',
                url: 'http://localhost:3000/users/update?id=' + this.id,
                data: {
                    data:{
                        Name: this.Fullname,
                        Email: this.EmailAddress,
                        Username: this.Username
                    }
                }
            })
            .then((response)=>{
                console.log(response)
            })
        },

        updateBtn: function(){
            this.gwapo = false

            console.log(this.id)

            axios({
                method: 'POST',
                url: 'http://localhost:3000/users/delete?id=' + this.id,
                
            })
            .then((response)=> {
                console.log(response)
            })

        }

    },
    created(){
        axios({
                method: 'GET',
                url: 'http://localhost:3000/users',
                
            })
            .then((result)=>{
                const data = result.data;
                this.use = data;
                console.log(this.use)
                this.$store.state.count = 1;
            })
    }
   
}
</script>
  
<style>
</style>