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
                    
                        <v-text-field :rules="inputRules" label="Name" prepend-icon="mdi-pencil" v-model="people.name" clearable></v-text-field>
                        <v-select :items="selected" label="Category" prepend-icon="mdi-menu" v-model="category" clearable></v-select>
                        
                        
                        <v-divider></v-divider>

                        <v-card-actions>
                            <v-spacer></v-spacer>
                            <v-btn color="primary" text @click="dialog = false">
                                Cancel
                            </v-btn>
                    
                            <v-btn color="primary" text @click="dialog = false" v-on:click="postData(service)">
                                Submit
                            </v-btn>
                        </v-card-actions>
                    
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
                <div>{{subcon.SubName}}</div>
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
export default {
    data() {
        return {
            selected:['Roofing','Masonry','Electrical','Plumbing'],
            dialog: false,
            people: {name: '', serviceid: null},
            category:'',
            service:'',
            peps:[],
            sub:[],
            search:'',
            id:"",
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
                        url: 'http://localhost:3000/subcontractors/addsub',
                        data: {
                            
                                SubName: this.people.name,
                                ServiceID: hello[index].ServiceID
                            
                        },
                    })
                    .then((result)=>{
                        console.log(result)
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
            .then((response)=>{
                console.log(response)
            })
        }

        
    
    },

     computed:{
         filtercon: function(){
             return this.peps.filter((subcon)=>{
                 return subcon.SubName.match(this.search);
             });
         }
     },

    created(){
        axios({
                method: 'GET',
                url: 'http://localhost:3000/subcontractors',
                
            })
            .then((result)=>{
                const data = result.data;
                this.peps = data.data;
                console.log(this.peps)
            })

        axios({
                method: 'GET',
                url: 'http://localhost:3000/material/categories',
            })
            .then((result)=>{
                const data = result.data;
                this.service = data;
                // console.log(result)
            });
    }
    
}
</script>