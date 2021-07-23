<template>
    <div>
        <v-container style="text-align: left;">
        <h1 class="ml-3">Sub Contractor</h1>
        <v-form>
            <v-container>
                <v-row class="mt-1">
                    <v-col cols="12" sm="6" md="4">
                        <v-text-field placeholder="Search" solo v-model="search"></v-text-field>
                    </v-col>
                
                    <v-col>
                        <v-dialog v-model="dialog" width="500">
            <template v-slot:activator="{ on, attrs }">
                <v-btn style="display: inline; float: right;" color="#32CD32" class="mt-1 white--text" v-bind="attrs" v-on="on">
                    Add Sub Contractor
                </v-btn>
            </template>

            <v-card>
                <v-card-title class="headline grey lighten-2">
                    Sub Contractor
                </v-card-title>

                <v-card-text>
                     <validation-observer ref="observer" v-slot="{ invalid }">
                       <v-form @submit.prevent="submit">
                        <validation-provider v-slot="{ errors }" name="First Name" rules="required|max:10">
                        <v-text-field prepend-icon="mdi-pencil" v-model="people.firstname" :counter="15" :error-messages="errors" label="First Name" required clearable></v-text-field>
                        </validation-provider>

                        <validation-provider v-slot="{ errors }" name="Middle Name" rules="required|max:10">
                        <v-text-field prepend-icon="mdi-pencil" v-model="people.middlename" :counter="10" :error-messages="errors" label="Middle Name" required clearable></v-text-field>
                        </validation-provider>

                        <validation-provider v-slot="{ errors }" name=" Last Name" rules="required|max:10">
                        <v-text-field prepend-icon="mdi-pencil" v-model="people.lastname" :counter="10" :error-messages="errors" label="Last Name" required clearable></v-text-field>
                        </validation-provider>

                        <validation-provider v-slot="{ errors }" name="Category" rules="required">
                        <v-select :items="selected" label="Category" prepend-icon="mdi-menu" v-model="category" :error-messages="errors" data-vv-name="select" required clearable></v-select>
                        </validation-provider>
                        
                        <v-divider></v-divider>

                        <v-card-actions>
                            <v-spacer></v-spacer>
                            <v-btn color="primary" text @click="dialog = false">
                                Cancel
                            </v-btn>
                    
                            <v-btn color="primary" text @click="dialog = false" v-on:click="postData(service)" type="submit" :disabled="invalid">
                                Submit
                            </v-btn>
                        </v-card-actions>
                    </v-form>
                    </validation-observer>
                </v-card-text>
            </v-card>
        </v-dialog>
                    </v-col>
                </v-row>
            </v-container>
        </v-form>
       

        <v-divider class="mx-3"></v-divider>
        <v-card flat class="my-3 mx-12 pa-5" style="background-color: #F8F8F8" v-for="(subcon, x) in filtercon" :key="x">
            <v-layout row wrap >
            <v-flex xs12 md6>
                <div class="caption grey--text">Sub Contarctor</div>
                <div>
                    {{subcon.FirstName}}
                    {{subcon.MiddleName}}
                    {{subcon.LastName}}
                </div>
            </v-flex>
            <v-flex xs12 sm4 md5>
                <div class="caption grey--text">Service</div>
                <div>{{subcon.ServiceName}}</div>
            </v-flex>
           
           
            <v-flex xs6 sm4 md1>
                <v-btn text style="float: right;">
                    <v-icon v-bind:id="subcon.SubID" v-on:click="deleteSubCon($event)">mdi-delete</v-icon>
                </v-btn>
            </v-flex>
            </v-layout>
        </v-card>
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
        return {
            selected:['Roofing','Masonry','Electrical','Plumbing'],
            dialog: false,
            people: {firstname: '', middlename: '', lastname: '', serviceid: null},
            category:'',
            service:'',
            peps:[],
            sub:[],
            search:'',
            id:"",

            checkbox: null,
            inputRules: [
                v => v.length >= 3 || '3 Characters above'
            ]
        }
    },
    methods:{
        postData: function(hello){

            for (let index = 0; index < hello.length; index++) {
                if (this.category == hello[index].ServiceName) {
                    // console.log(hello[0].ServiceID)
                    // console.log("hello")
                    axios({
                        

                        method: 'POST',
                        url: 'http://localhost:3000/subcontractors/add',
                        data: {
                            
                                FirstName: this.people.firstname,
                                MiddleName: this.people.middlename,
                                LastName: this.people.lastname,
                                ServiceID: hello[index].ServiceID
                            
                        },
                    })
                    .then(()=>{
                        this.$router.go()
                    })

                    break;
                }
                
            }
            
        },

        deleteSubCon: function(event){
            this.id = event.currentTarget.id

            axios({
                method: 'POST',
                url: 'http://localhost:3000/subcontractors/delete?id=' + this.id,
            })
            .then(()=>{
                this.$router.go()
            })
        },

        submit: function() {
            this.$refs.observer.validate()
        },

        
    
    },

     computed:{
         filtercon: function(){

            var all = []

            all = this.peps.filter((subcon)=>{
                 return subcon.FirstName.concat(" " + subcon.MiddleName + " " + subcon.LastName).match(this.search);
             });

            if (all.length == 0) {
                all = this.peps.filter((subcon)=>{
                 return subcon.ServiceName.match(this.search);
             });
            }

            return all
         }
     },

    created(){
        this.$store.state.count = 1;
        axios({
                method: 'GET',
                url: 'http://localhost:3000/subcontractors',
                
            })
            .then((result)=>{
                const data = result.data;
                this.peps = data.data;
                console.log(this.peps)
                console.log(result);
                console.log("lalalalala")
            })

        axios({
                method: 'GET',
                url: 'http://localhost:3000/material/categories',
            })
            .then((result)=>{
                const data = result.data;
                this.service = data;
                console.log(result)
            });
    }
    
}
</script>