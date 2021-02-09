<template>
    <div>
        <v-container style="text-align: left;">
        <h1 class="ml-3">Materials</h1>
        <v-form>
            <v-container>
                <v-row class="mt-1">
                    <v-col cols="12" sm="6" md="4">
                        <v-text-field placeholder="Search" solo v-model="search"></v-text-field>
                    </v-col>
                    <v-col>
                        <v-btn color="grey--text" class="py-6">
                            <v-icon>fa-search</v-icon>
                        </v-btn>
                    </v-col>
                    <v-col>
                        <v-dialog v-model="dialog" width="500">
            <template v-slot:activator="{ on, attrs }">
                <v-btn style="display: inline; float: right;" color="#32CD32" class="mt-1 white--text" v-bind="attrs" v-on="on">
                    Add Material
                </v-btn>
            </template>

            <v-card>
                <v-card-title class="headline grey lighten-2">
                    Material
                </v-card-title>

                <v-card-text > 
                    <!-- <v-form class="px-3"> -->
                        <v-select :items="selected" label="Category" prepend-icon="mdi-menu" v-model="category" clearable></v-select>
                        <v-text-field :rules="inputRules" label="Name" prepend-icon="mdi-pencil" v-model="Mat.name" clearable></v-text-field>
                        <v-text-field :rules="inputRules" label="Decription"  prepend-icon="fa-edit" v-model="Mat.Description" clearable></v-text-field>
                        <v-text-field :rules="inputRules" label="Quantity"  prepend-icon="mdi-minus" v-model="Mat.quantity" clearable></v-text-field>
                        <v-text-field :rules="inputRules" label="Price"  prepend-icon="mdi-plus" v-model="Mat.prize" clearable></v-text-field>
                        <v-select :items="items" label="Status" prepend-icon="mdi-widgets" v-model="Mat.status" clearable></v-select>
                        
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
                    <!-- </v-form> -->
                </v-card-text>
            </v-card>
        </v-dialog>
                    </v-col>
                </v-row>
            </v-container>
        </v-form>
          <v-tabs color="grey">
            <v-tabs-slider color="grey"></v-tabs-slider>

            <v-tab class="mx-3" v-for="(ser, x) in service" :key="x" v-on:click="getServiceId(ser)">
              {{ser.ServiceName}}
            </v-tab>
            
          </v-tabs>
       
        <v-divider class="mx-3"></v-divider>
        <v-card v-model="tab" flat class="my-3 mx-12 pa-5" style="background-color: #F8F8F8" v-for="(materials, x) in materialzz" :key="x">
            <v-tabs-slider color="yellow"></v-tabs-slider>
            <v-layout row wrap>
            <v-flex xs12 md3>
                <div class="caption grey--text">Name</div>
                <div>{{materials.MatName}}</div>
                <!-- <input size="20" type="text"  v-show="!hide" v-model="nameMat" /> -->
            </v-flex>
            <v-flex xs12 sm4 md3>
                <div class="caption grey--text">Description</div>
                <div>{{materials.MatDescription}}</div>
                <!-- <input size="25" type="text"  v-show="!hide" v-model="DescriptionMat" /> -->
            </v-flex>
            <v-flex xs6 sm4 md2>
                <div class="caption grey--text">Status</div>
                <div>{{materials.MatStatus}}</div>
                <!-- <input size="12" type="text"  v-show="!hide" v-model="statusMat" /> -->
            </v-flex>
            <v-flex xs6 sm4 md2>
                <div class="caption grey--text">Quantity</div>
                <div>{{materials.MatQuantity}}</div>
                <!-- <input size="5" type="text"  v-show="!hide" v-model="quantityMat" /> -->
            </v-flex>
            <v-flex xs6 sm4 md1>
                <div class="caption grey--text">Prize</div>
                <div>{{materials.MatPrice}}</div>
                <!-- <input size="5" type="text"  v-show="!hide" v-model="prizeMat" /> -->
            </v-flex>
            <v-flex xs6 sm4 md1>
                <div style="float: right;">
                    <v-dialog v-model="hamburger" width="900">
                      <template v-slot:activator="{ on, attrs }">
                        <v-btn v-bind="attrs" v-on="on" text>
                         <v-icon v-bind:id="materials.MatDetailsID" v-on:click="Matupdate($event, materialzz)">mdi-pencil</v-icon>
                       </v-btn>
                      </template>

                      <v-card>
                       <v-card-title class="headline grey lighten-2">
                         EDIT
                        </v-card-title>

                       <v-card-text class="mt-5">
                           <v-layout row wrap class="ml-10">
                                <v-flex xs12 md3>
                                    <div class="caption grey--text">Name</div>
                                    <div><input size="20" type="text" v-model="nameMat" /></div>
                                </v-flex>
                             <v-flex xs12 sm4 md3>
                                    <div class="caption grey--text">Description</div>
                                    <div><input size="25" type="text" v-model="DescriptionMat" /></div>
                                </v-flex>
                                <v-flex xs6 sm4 md2>
                                    <div class="caption grey--text">Status</div>
                                    <div><input size="12" type="text" v-model="statusMat" /></div>
                                </v-flex>
                                <v-flex xs6 sm4 md2>
                                    <div class="caption grey--text">Quantity</div>
                                    <div><input size="9" type="text" v-model="quantityMat" /></div>
                             </v-flex>
                                <v-flex xs6 sm4 md2>
                                    <div class="caption grey--text">Prize</div>
                                    <div><input size="9" type="text" v-model="prizeMat" /></div>
                             </v-flex>
                           </v-layout>
                      </v-card-text>

                       <v-divider></v-divider>

                       <v-card-actions>
                         <v-btn color="primary" text @click="hamburger = false">
                           <v-icon v-on:click="deleteMat()">mdi-delete</v-icon>
                         </v-btn>
                         <v-spacer></v-spacer>
                         <v-btn color="primary" text @click="hamburger = false">
                           Cancel
                         </v-btn>
                         <v-btn color="primary" text @click="hamburger = false" v-on:click="updateMat()">
                           Submit
                         </v-btn>
                       </v-card-actions>
                     </v-card>
                   </v-dialog>
                 </div>
                <!-- <v-btn text>
                    <v-icon v-show="hide" v-bind:id="materials.MatDetailsID" v-on:click="Matupdate($event, materialzz)">mdi-pencil</v-icon>
                    <v-icon v-show="!hide" @click="hide = true">mdi-close</v-icon>
                </v-btn> -->
                
                <!-- <v-btn text>
                    <v-icon v-show="hide"  v-bind:id="materials.MatDetailsID" v-on:click="deleteMat($event)">mdi-delete</v-icon>
                    <v-icon v-show="!hide" v-bind:id="materials.MatDetailsID" v-on:click="updateMat($event)">mdi-upload</v-icon>
                </v-btn> -->
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
            // roofing:[
            //     {name:'Duratile', Description:'discription', status:'status', quantity:'10', prize:'234'},
            //     {name:'Durarib', Description:'discription', status:'status', quantity:'10', prize:'234'},
            //     {name:'Duratile', Description:'discription', status:'status', quantity:'10', prize:'234'},
            //     {name:'Durarib', Description:'discription', status:'status', quantity:'10', prize:'234'},
            // ],
            // masonry:[
            //     {name:'hmmm', Description:'discription', status:'status', quantity:'5', prize:'234'},
            //     {name:'hhahahaa', Description:'discription', status:'status', quantity:'6', prize:'234'},
            //     {name:'general bato', Description:'discription', status:'status', quantity:'7', prize:'234'},
            //     {name:'stone', Description:'discription', status:'status', quantity:'8', prize:'234'},
            // ],
            // electrical:[
            //     {name:'thor', Description:'discription', status:'status', quantity:'14', prize:'234'},
            //     {name:'hammer', Description:'discription', status:'status', quantity:'13', prize:'234'},
            //     {name:'thunder', Description:'discription', status:'status', quantity:'12', prize:'234'},
            //     {name:'god', Description:'discription', status:'status', quantity:'11', prize:'234'},
            // ],
            // plumbing:[
            //     {name:'Duratile', Description:'discription', status:'status', quantity:'10', prize:'234'},
            //     {name:'Durarib', Description:'discription', status:'status', quantity:'10', prize:'234'},
            //     {name:'Duratile', Description:'discription', status:'status', quantity:'10', prize:'234'},
            //     {name:'Durarib', Description:'discription', status:'status', quantity:'10', prize:'234'},
            // ],
            tab: null,
            items:['In Stock', 'For Order'],
            selected:['Roofing','Masonry','Electrical','Plumbing'],
            category:'',
            dialog: false,
            hide: true,
            hamburger: false,
            Mat: {name:'', Description:'', status:'', quantity:'', prize:'', serviceid: null},
            
            nameMat:"",
            DescriptionMat:"",
            statusMat:"",
            quantityMat:"",
            prizeMat:"",

            materialzz:"",
            maurice:[],
            service: "",
            search:'',
            id:"",
            inputRules:[
                v => v.length >= 1 || 'Required'
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
                        url: 'http://localhost:3000/materials/add',
                        data: {
                            
                                Matname: this.Mat.name,
                                MatDescription: this.Mat.Description,
                                MatQuantity: this.Mat.quantity,
                                MatPrice: this.Mat.prize,
                                MatStatus: this.Mat.status,
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

        getServiceId:function(hi){
            
            axios({
                method: 'GET',
                url: 'http://localhost:3000/material/categories/' + hi.ServiceID,
            })
            .then((response)=>{
                const data = response.data;
                this.materialzz = data;
                this.name = data.MatName;
                this.Description = data.MatDescription;
                this.status = data.MatStatus;
                this.quantity = data.MatQuantity;
                this.prize = data.MatPrice;
                this.id = data.MatDetailsID
                console.log(this.materialzz)
            });
        },
        
        Matupdate: function(event, terials){

            this.id = event.currentTarget.id


            for (let index = 0; index < terials.length; index++) {
                if (this.id == terials[index].MatDetailsID) {
                    this.nameMat = terials[index].MatName
                    this.DescriptionMat = terials[index].MatDescription
                    this.statusMat = terials[index].MatStatus
                    this.quantityMat = terials[index].MatQuantity
                    this.prizeMat = terials[index].MatPrice
                }
                
            }

            // if (this.id == terials.MatDetailsID) {
            //     this.name = terials.MatName
            //     this.Description = terials.MatDescription
            //     this.status = terials.MatStatus
            //     this.quantity = terials.MatQuantity
            //     this.prize = terials.MatPrice
            // }

            // axios({
            //     method: 'GET',
            //     url: 'http://localhost:3000/material/categories/' + hi.ServiceID,
            // })
            // .then((response)=>{
            //     const data = response.data;
            //     this.name = data.MatName;
            //     this.Description = data.MatDescription;
            //     this.status = data.MatStatus;
            //     this.quantity = data.MatQuantity;
            //     this.prize = data.MatPrice;
            //     this.id = data.MatDetailsID
            // });
        },

        updateMat: function(){

            console.log(this.id)

            axios({
                method: 'POST',
                url: 'http://localhost:3000/materials/update',
                data: {
                   
                        MatName: this.nameMat,
                        MatDescription: this.DescriptionMat,
                        MatQuantity: this.quantityMat,
                        MatPrice: this.prizeMat,
                        MatStatus: this.statusMat,
                        MatDetailsID: this.id
                }
            })
            .then((response)=>{
                console.log(response)
            })
        },

        deleteMat: function(){
            

            console.log(this.id)

            axios({
                method: 'POST',
                url: 'http://localhost:3000/materials/delete?id=' + this.id,
            })
            .then((response)=>{
                console.log(response)
            })

        }
       
    },


    beforeMount(){
        
        axios({
                method: 'GET',
                url: 'http://localhost:3000/material/categories/1',
            })
            .then((response)=>{
                const data = response.data;
                this.materialzz = data;
            });

    },
    

    computed:{
        filter(){
            return this.maurice.filter((materials)=>{
                return materials.name.match(this.search);
            })
        },

    },

    created(){
        axios({
                method: 'GET',
                url: 'http://localhost:3000/material/categories',
            })
            .then((result)=>{
                const data = result.data;
                this.service = data;
                // console.log(result)
            });

        // axios({
        //         method: 'GET',
        //         url: 'http://localhost:3000/material/categories/1',
        //     })
        //     .then((response)=>{
        //         const data = response.data;
        //         this.materialzz = data;
        //     });
    },

   
}
</script>