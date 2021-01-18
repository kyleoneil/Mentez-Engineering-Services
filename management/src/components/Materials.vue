<template>
    <div>
        <v-container style="text-align: left;">
        <h1 class="ml-3">Materials</h1>
        <v-form>
            <v-container>
                <v-row class="mt-1">
                    <v-col cols="12" sm="6" md="4">
                        <v-text-field placeholder="Search" solo ></v-text-field>
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

                <v-card-text>
                    <v-form class="px-3">
                        <v-text-field label="Name" prepend-icon="mdi-pencil" class="mx-16"></v-text-field>
                        <v-text-field label="Status" prepend-icon="mdi-widgets" class="mx-16"></v-text-field>
                        <v-text-field label="Quantity"  prepend-icon="mdi-plus" class="mx-16 px-16"></v-text-field>
                        <v-textarea label="Decription"  prepend-icon="fa-edit"></v-textarea>
                        
                        <v-divider></v-divider>

                        <v-card-actions>
                            <v-spacer></v-spacer>
                            <v-btn color="primary" text>
                                Cancel
                            </v-btn>
                    
                            <v-btn color="primary" text>
                                Submit
                            </v-btn>
                        </v-card-actions>
                    </v-form>
                </v-card-text>
            </v-card>
        </v-dialog>
                    </v-col>
                </v-row>
            </v-container>
        </v-form>
        <v-btn text class="mx-3" @click="material(roofing)">
            Roofing
        </v-btn>
        <v-btn text class="mx-3" @click="material(masonry)">
            Masonry
        </v-btn>
        <v-btn text class="mx-3" @click="material(electrical)">
            Electrical
        </v-btn>
        <v-btn text class="mx-3" @click="material(plumbing)">
            Plumbing
        </v-btn>
        <v-divider class="mx-3"></v-divider>
        <v-card flat class="my-3 mx-12 pa-5" style="background-color: #F8F8F8" v-for="(materials, x) in maurice" :key="x">
            <v-layout row wrap>
            <v-flex xs12 md3>
                <div class="caption grey--text">Name</div>
                <div>{{materials.name}}</div>
            </v-flex>
            <v-flex xs12 sm4 md4>
                <div class="caption grey--text">Description</div>
                <div>{{materials.Description}}</div>
            </v-flex>
            <v-flex xs6 sm4 md2>
                <div class="caption grey--text">Status</div>
                <div>{{materials.status}}</div>
            </v-flex>
            <v-flex xs6 sm4 md2>
                <div class="caption grey--text">Quantity</div>
                <div>{{materials.quantity}}</div>
            </v-flex>
            <v-flex xs6 sm4 md1>
                <v-btn text>
                    <v-icon>mdi-pencil</v-icon>
                </v-btn>
                <v-btn text>
                    <v-icon>mdi-delete</v-icon>
                </v-btn>
            </v-flex>
            </v-layout>
        </v-card>
        </v-container>
    </div>  
</template>

<script>
export default {
    data() {
        return {
            roofing:[
                {name:'Duratile', Description:'discription', status:'status', quantity:'10'},
                {name:'Durarib', Description:'discription', status:'status', quantity:'10'},
                {name:'Duratile', Description:'discription', status:'status', quantity:'10'},
                {name:'Durarib', Description:'discription', status:'status', quantity:'10'},
            ],
            masonry:[
                {name:'hmmm', Description:'discription', status:'status', quantity:'5'},
                {name:'hhahahaa', Description:'discription', status:'status', quantity:'6'},
                {name:'general bato', Description:'discription', status:'status', quantity:'7'},
                {name:'stone', Description:'discription', status:'status', quantity:'8'},
            ],
            electrical:[
                {name:'thor', Description:'discription', status:'status', quantity:'14'},
                {name:'hammer', Description:'discription', status:'status', quantity:'13'},
                {name:'thunder', Description:'discription', status:'status', quantity:'12'},
                {name:'god', Description:'discription', status:'status', quantity:'11'},
            ],
            plumbing:[
                {name:'Duratile', Description:'discription', status:'status', quantity:'10'},
                {name:'Durarib', Description:'discription', status:'status', quantity:'10'},
                {name:'Duratile', Description:'discription', status:'status', quantity:'10'},
                {name:'Durarib', Description:'discription', status:'status', quantity:'10'},
            ],
            maurice:[]
        }
    },
    methods:{
        material(mat){

            var mater = [];
               
            

            mat.forEach(function (lance) {
               mater.push(lance)
            });

            this.maurice = mater

        }
    },
    beforeMount(){
        var mater = [];
               
            

            this.roofing.forEach(function (lance) {
               mater.push(lance)
            });

            this.maurice = mater

    }
    
}
</script>