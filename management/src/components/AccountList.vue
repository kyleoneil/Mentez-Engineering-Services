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
                    <validation-observer ref="observer" v-slot="{ invalid }">
                    <v-form @submit.prevent="submit">
                        <validation-provider v-slot="{ errors }" name="First Name" rules="required|max:10">
                        <v-text-field v-show="ambot" prepend-icon="mdi-pencil" v-model="people.firstname" :counter="15" :error-messages="errors" label="First Name" required clearable></v-text-field>
                        </validation-provider>

                        <validation-provider v-slot="{ errors }" name="Middle Name" rules="required|max:10">
                        <v-text-field v-show="ambot" prepend-icon="mdi-pencil" v-model="people.middlename" :counter="10" :error-messages="errors" label="Middle Name" required clearable></v-text-field>
                        </validation-provider>

                        <validation-provider v-slot="{ errors }" name="Last Name" rules="required|max:10">
                        <v-text-field v-show="ambot" prepend-icon="mdi-pencil" v-model="people.lastname" :counter="10" :error-messages="errors" label="Last Name" required clearable></v-text-field>
                        </validation-provider>

                        <!-- <v-btn style="margin-left: 65px; font-size: 12px" color="primary" v-show="ambot" v-bind="people" text @click="checking(use)">
                           Click to check if User already exists.
                         </v-btn> -->
                         <validation-provider v-slot="{ errors }" rules="required" name="checkbox">
                         <v-checkbox style="margin-left: 160px;" v-show="ambot" v-bind="people" v-model="checkbox" :error-messages="errors" value="1" label="Verify User" type="checkbox" @click="checking(use)" required></v-checkbox>
                         </validation-provider>
                         <div style="margin-left: 145px; font-size: 18px" v-show="!ambot">User Already Exists!!!</div>
                         <v-btn style="margin-left: 190px" color="primary" v-show="!ambot" text @click="ambot = true" v-on:click="clear()">
                           Back
                         </v-btn>

                        <!-- <validation-provider v-slot="{ errors }" name="Email" rules="required|email">
                        <v-text-field v-show="ambot" prepend-icon="mdi-email" v-model="people.email" :error-messages="errors" label="E-mail" required clearable></v-text-field>
                        </validation-provider> -->
                        
                        <div v-show="ambot" v-bind="EmailCombine(people.firstname, people.lastname)">
                            <v-icon> mdi-email</v-icon>
                            {{people.firstname}}.{{people.lastname}}@MentezEngineering.com
                        </div>
                        <div style="margin: 25px"></div>
                        <div v-show="ambot" v-bind="UserCombine(people.firstname, people.lastname)">
                            <v-icon>mdi-account</v-icon>
                            {{people.firstname}}_{{people.lastname}}
                        </div>
                        <div style="margin: 25px"></div>
                        <div v-show="ambot" v-bind="PasswordCombine(people.firstname, people.lastname)">
                            <v-icon>mdi-lock</v-icon>
                            {{people.firstname}}{{people.lastname}}
                        </div>
                        <div style="margin: 25px"></div>

                        <!-- <v-text-field v-show="ambot" prepend-icon="mdi-account" v-model="people.username" clearable></v-text-field> -->

                        <!-- <validation-provider v-slot="{ errors }" name="Password" rules="required|max:10">
                        <v-text-field v-show="ambot" prepend-icon="mdi-lock" v-model="people.password" :counter="10" :error-messages="errors" label="Password" required clearable></v-text-field>
                        </validation-provider> -->
                        
                        <v-divider></v-divider>

                        <v-card-actions>
                            <v-spacer></v-spacer>
                            <v-btn color="primary" text @click="dialog = false">
                                Cancel
                            </v-btn>
                    
                            <v-btn color="primary" text @click="dialog = false" v-on:click="postData()" type="submit" :disabled="invalid">
                                Submit
                            </v-btn>
                        </v-card-actions>
                    </v-form>
                    </validation-observer>
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
                            <div class="font-weight-bold">
                                {{person.FirstName}}
                                {{person.MiddleName}}
                                {{person.LastName}}
                            </div>
                            <div class="grey--text">{{person.Username}}</div>
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
                                                <span v-show="hide">{{Firstname}}</span>
                                                <span class="ml-3"><input type="text"  v-show="!hide" v-model="Firstname" /></span>
                                            </div>
                                            <div class="font-weight-bold ma-2">
                                                <v-icon small left>mdi-pencil</v-icon>
                                                <span v-show="hide">{{Middlename}}</span>
                                                <span class="ml-3"><input type="text"  v-show="!hide" v-model="Middlename" /></span>
                                            </div>
                                            <div class="font-weight-bold ma-2">
                                                <v-icon small left>mdi-pencil</v-icon>
                                                <span v-show="hide">{{Lastname}}</span>
                                                <span class="ml-3"><input type="text"  v-show="!hide" v-model="Lastname" /></span>
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
import { required, digits, email, max, regex } from 'vee-validate/dist/rules'
import {extend, ValidationObserver, ValidationProvider, setInteractionMode} from 'vee-validate'

setInteractionMode('eager')

extend('digits', {
    ...digits,
    message: '{_field_} needs to be {length} digits. ({_value_})',
  })

  extend('required', {
    ...required,
    message: '{_field_} can not be empty',
  })

  extend('max', {
    ...max,
    message: '{_field_} may not be greater than {length} characters',
  })

  extend('regex', {
    ...regex,
    message: '{_field_} {_value_} does not match {regex}',
  })

  extend('email', {
    ...email,
    message: 'Email must be valid',
  })


export default {
    components: {
      ValidationProvider,
      ValidationObserver,
    },
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
            people:{firstname:'', middlename:'', lastname:'', email:'', username: '', password: ''},
            use:"",
            gwapo: false,
            dialog: false,
            hide: true,
            ambot: true,
            Firstname:"",
            Middlename:"",
            Lastname:"",
            EmailAddress:"",
            Username:"",
            id:"",

            checkbox:null,

            number:[191817,234563,123558,243698,189543,345267,198264,192560],

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
                    FirstName: this.people.firstname,
                    MiddleName: this.people.middlename,
                    LastName: this.people.lastname,
                    email: this.people.email,
                    username: this.people.username,
                    password: this.people.password
                    }
                },
            })
            .then((result)=>{
                console.log(result)
                this.$router.go()
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
                this.Firstname = data[0].FirstName;
                this.Middlename = data[0].MiddleName;
                this.Lastname = data[0].LastName;
                this.EmailAddress = data[0].Email;
                this.Username = data[0].Username
                console.log(data[0].Username)
            })
        },

        
        downdateBtn: function(){
            this.hide = true

            axios({
                method: 'POST',
                url: 'http://localhost:3000/users/update?id=' + this.id,
                data: {
                    data:{
                        FirstName: this.Firstname,
                        MiddleName: this.Middlename,
                        LastName: this.Lastname,
                        Email: this.EmailAddress,
                        Username: this.Username
                    }
                }
            })
            .then((response)=>{
                console.log(response)
                this.$router.go()
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
                this.$router.go()
            })

        },

        submit: function() {
            this.$refs.observer.validate()
        },

        checking: function (kaja){
            
            for (let index = 0; index < kaja.length; index++) {
                if (this.people.firstname == kaja[index].FirstName) {
                    this.ambot = false
                    break
                }
            }
        },

        clear () {
            this.people.firstname = ''
            this.people.middlename = ''
            this.people.lastname = ''
            this.people.email = ''
            this.people.username = ''
            this.people.password = ''
            this.checkbox = null
            this.$refs.observer.reset()
      },

      EmailCombine: function (first, last){
          this.people.email = first + '.' + last + '@MentezEngineering.com'
      },

      UserCombine: function (first, last){
          this.people.username = first + '_' + last
      },

      PasswordCombine: function (first, last){
          var ya = first.charCodeAt(0);
          var yo = last.charCodeAt(0);
          this.people.password = first + last + ya + yo
      },

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