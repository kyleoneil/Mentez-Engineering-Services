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
                    <v-form class="px-3">
                        <v-text-field label="FullName" prepend-icon="mdi-pencil"></v-text-field>
                        <v-text-field label="ContactNumber" prepend-icon="mdi-dialpad"></v-text-field>
                        <v-text-field label="UserName"  prepend-icon="mdi-account"></v-text-field>
                        <v-text-field label="Password"  prepend-icon="mdi-lock"></v-text-field>
                        
                        <v-divider></v-divider>

                        <v-card-actions>
                            <v-spacer></v-spacer>
                            <v-btn color="primary" text @click="dialog = false">
                                Cancel
                            </v-btn>
                    
                            <v-btn color="primary" text @click="dialog = false">
                                Submit
                            </v-btn>
                        </v-card-actions>
                    </v-form>
                </v-card-text>
            </v-card>
        </v-dialog>
        <v-divider></v-divider>
        <v-container class="mx-2">
            <v-layout row wrap >
                <v-flex xs12 sm6 md4 lg3 v-for="person in people" :key="person.name">
                    <v-card class="text-center ma-3" style="background-color: #E5E5E5;">
                        <v-responsive class="pt-4">
                            <v-avatar size="100" >
                                <img :src="person.avatar">
                            </v-avatar>
                        </v-responsive>
                        <v-card-text>
                            <div class="font-weight-bold">{{person.name}}</div>
                            <div class="grey--text">{{person.contact}}</div>
                        </v-card-text>
                       
                        <v-dialog max-width="500px">
                            <template v-slot:activator="{ on, attrs }">
                            <v-btn color="#F05898"  class="mb-3" v-bind="attrs" v-on="on">
                                <v-icon small left>mdi-wrench</v-icon>
                                <span>Manage</span>
                            </v-btn>
                            </template>
                            <v-card>
                                <v-card-title class="headline grey lighten-2">
                                    Manage
                                </v-card-title>
                                <v-card-text>
                                    <v-form class="px-3">
                                        <v-card-text>
                                            <div class="font-weight-bold">
                                                <v-icon small left>mdi-pencil</v-icon>
                                                <span>{{person.name}}</span>
                                            </div>
                                            <div class="font-weight-bold">
                                                <v-icon small left>mdi-dialpad</v-icon>
                                                <span>{{person.contact}}</span>
                                            </div>
                                            <div class="font-weight-bold">
                                                <v-icon small left>mdi-account</v-icon>
                                                <span>{{person.username}}</span>
                                            </div>
                                            <div class="font-weight-bold">
                                                <v-icon small left>mdi-lock</v-icon>
                                                <span>{{person.password}}</span>
                                            </div>
                                        </v-card-text>
                                        <v-divider></v-divider>

                        <v-card-actions>
                             <v-btn color="primary" text @click="dialog = false">
                                Edit
                            </v-btn>
                            <v-spacer></v-spacer>
                            <v-btn color="primary" text @click="dialog = false">
                                Cancel
                            </v-btn>
                    
                            <v-btn color="primary" text @click="dialog = false">
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
export default {
    data() {
        return{
            people: [
                {name: 'Euniel Van Jamero', contact: '09876567654', avatar:'/qiqi.jpg', username:'Username', password:'Password'},
                {name: 'kyle Onil Albarando', contact: '09876545654', avatar:'/paimon.jpeg', username:'Username', password:'Password'},
                {name: 'Carl James Balingit', contact: '09872347654', avatar:'/yaoya.png', username:'Username', password:'Password'},
                {name: 'Maurice Lance Tezon', contact: '09876347654', avatar:'/diona.jpg', username:'Username', password:'Password'},
                {name: 'Van Jamero Euniel', contact: '09876347654', avatar:'/qiqi.jpg', username:'Username', password:'Password'},
                {name: 'Onil Albarando Kyle', contact: '09876347654', avatar:'/paimon.jpeg', username:'Username', password:'Password'},
                {name: 'James Balingit Carl', contact: '09876347654', avatar:'/yaoya.png', username:'Username', password:'Password'},
                {name: 'Lance Tezon Maurice', contact: '09876347654', avatar:'/diona.jpg', username:'Username', password:'Password'},
            ],
            gwapo: false,
            dialog: false,
        }
    },
    methods:{
        
    }
   
}
</script>
  
<style>
</style>