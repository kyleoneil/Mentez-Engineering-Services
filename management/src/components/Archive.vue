<template>
  <div>
    <v-container style="text-align: left;">
      <h1 class="ml-3">Archive</h1>
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
          </v-row>
        </v-container>
      </v-form>
      
      <v-divider class="mx-3"></v-divider>

      <v-card flat class="my-3 mx-12 pa-5" style="background-color: #F8F8F8"
        v-for="(quotation, index) in filtermat" :key="index"
      >
        <v-layout>
          <v-flex xs12 md1>
            <div class="caption grey--text">No:</div>
          </v-flex>
          <v-flex xs12 md3>
            <div class="caption grey--text">Project</div>
          </v-flex>
          <v-flex xs12 md3>
            <div class="caption grey--text">Type</div>
          </v-flex>
          <v-flex xs12 md3>
            <div class="caption grey--text">Customer</div>
          </v-flex>
          <v-flex xs12 md4>
            <div class="caption grey--text">Schedule</div>
          </v-flex>
          <v-flex xs12 md3>
            <div class="caption grey--text">SubContractor(s)</div>
          </v-flex>
          <v-flex xs12 md3>
            <div class="caption grey--text">Service</div>
          </v-flex>
          <v-flex xs12 md1>
            <div class="subtitle-2"></div>
          </v-flex>
        </v-layout>

        <v-layout>
          <v-flex xs12 md1>
            <div class="subtitle-2">{{index}}</div>
          </v-flex>
          <v-flex xs12 md3 pr-1>
            <div class="subtitle-2">{{quotation.project.project_description}}</div>
          </v-flex>
          <v-flex xs12 md3 pr-1>
            <div class="subtitle-2">{{quotation.project.project_type}}</div>
          </v-flex>
          <v-flex xs12 md3 pr-1>
            <div class="subtitle-2">{{quotation.customer.customer_Fname}} {{quotation.customer.customer_Lname}}</div>
          </v-flex>
          <v-flex xs12 md4 pr-1>
            <div class="subtitle-2">{{quotation.project.date_from}} -> {{quotation.project.date_until}}</div>
          </v-flex>
          <v-flex xs12 md3 pr-1>
            <div class="subtitle-2">{{quotation.subcontractor.subcontractor_firstname}} {{quotation.subcontractor.subcontractor_middlename}} {{quotation.subcontractor.subcontractor_lastname}}</div>
          </v-flex>
          <v-flex xs12 md3 pr-1>
            <div class="subtitle-2">{{quotation.subcontractor.subcontractor_service}}</div>
          </v-flex>
          <v-flex xs12 md1>
            <v-speed-dial
              :top="top"
              :bottom="bottom"
              :right="right"
              :left="left"
              :direction="direction"
              :open-on-hover="hover"
              :transition="transition"
            >
              <template v-slot:activator>
                <v-btn
                  text
                  x-small
                >
                  <v-icon>
                    mdi-dots-horizontal
                  </v-icon>
                </v-btn>
              </template>
              <v-tooltip right>
                <template v-slot:activator="{ on, attrs }">
                  <v-btn
                    v-on:click="showdocument(index)"
                    fab
                    dark
                    x-small
                    color="indigo"
                    v-bind="attrs"
                    v-on="on"
                  >
                  <v-icon>mdi-text-box-search-outline</v-icon>
                  </v-btn>
                </template>
                <span>Show Document</span>
              </v-tooltip>
            </v-speed-dial>
          </v-flex>
        </v-layout>
      </v-card>

      <template>
        <v-row justify="center">
          <v-dialog
            v-model="document"
            width="800px"
          >
            <v-card>
              <div class="text-h6 text-center pt-4" pt-1>MENTEZ ENGINEERING SERVICES</div>
              <div class="text-overline text-center" >Poblacion, LILOAN, CEBU</div>
              <div class="pl-8 pt-6 pr-8">
                <v-row>
                  <v-col><div class="text-overline"><b>{{current_quotation.customer.customer_Fname}} {{current_quotation.customer.customer_Mname}} {{current_quotation.customer.customer_Lname}}</b></div></v-col>
                  <v-col><div class="text-overline text-right"><b>July 24, 2020</b></div></v-col>
                </v-row>

                <div class="pt-6">
                  <div class="text-caption">Project:</div>
                  <div class="text-overline"><b>{{current_quotation.project.project_type}} - {{current_quotation.project.project_description}}</b></div>
                  <div class="text-caption">{{current_quotation.project.project_street}}, {{current_quotation.project.project_barangay}} </div>
                  <div class="text-caption">{{current_quotation.project.project_city}}, {{current_quotation.project.project_postal_code}} </div>
                </div>
                
                <div class="pt-10">
                  <v-row>
                    <v-flex sm-12 md2 class="pl-3">
                      <div class="text-overline pb-2">Materials:</div>
                    </v-flex>
                    <v-flex sm-12 md6>
                    </v-flex>
                    <v-flex sm-12 md2>
                      <div class="text-caption pt-0 pb-4"><b>Unit Price net</b></div>
                    </v-flex>
                    <v-flex sm-12 md2>
                      <div class="text-caption pt-0 pb-4" ><b>Amount</b></div>
                    </v-flex>
                  </v-row>
                  <v-row
                    v-for="(material, index) in current_quotation.materials" :key="index"
                  >
                    <v-flex sm-12 md2 class="pl-5">
                      <div class="text-caption pt-2 pb-4" ><b>{{material.material_quantity }} pcs.</b></div>
                    </v-flex>
                    <v-flex sm-12 md3>
                      <div class="text-caption pt-2 pb-4" ><b>{{material.material_description}}</b></div>
                    </v-flex>
                    <v-flex sm-12 md3>
                      <div class="text-caption pt-2 pb-4" ><b>{{material.material_name}}</b></div>
                    </v-flex>
                    <v-flex sm-12 md2>
                      <div class="text-overline pr-4" >₱ {{material.material_price}}</div>
                    </v-flex>
                    <v-flex sm-12 md2>
                      <div class="text-overline pr-4" >₱ {{computeAmount(index)}}</div>
                    </v-flex>
                  </v-row>
                  <v-row class="mt-10">
                    <v-flex sm-12 md8>
                    </v-flex>
                    <v-flex sm-12 md2>
                      <div class="text-caption pt-2 pb-2">Delivery</div>
                    </v-flex>
                    <v-flex sm-12 md2>
                      <div class="text-overline pr-4" >₱ {{current_quotation.quotation_delivery}}</div>
                    </v-flex>
                  </v-row>
                  <v-row>
                    <v-flex sm-12 md8>
                    </v-flex>
                    <v-flex sm-12 md2>
                      <div class="text-caption pt-2 pb-2">Labor</div>
                    </v-flex>
                    <v-flex sm-12 md2>
                      <div class="text-overline pr-4">₱ {{current_quotation.quotation_labor}}</div>
                    </v-flex>
                  </v-row>
                  <v-row>
                    <v-flex sm-12 md8>
                    </v-flex>
                    <v-flex sm-12 md2>
                      <div class="text-caption pt-2 pb-2">Bending charges</div>
                    </v-flex>
                    <v-flex sm-12 md2>
                      <div class="text-overline pr-4">₱ {{current_quotation.quotation_bendingcharges}} </div>
                    </v-flex>
                  </v-row>
                  <v-row>
                    <v-flex sm-12 md10></v-flex>
                    <v-flex sm-12 md2><v-divider class="mt-2 mb-4 mr-4"></v-divider></v-flex>
                  </v-row>
                  
                  <v-row>
                    <v-flex sm-12 md8>
                    </v-flex>
                    <v-flex sm-12 md2>
                      <div class="text-overline">TOTAL</div>
                    </v-flex>
                    <v-flex sm-12 md2>
                      <div class="text-overline pr-4">₱ {{current_quotation.quotation_summation}}</div>
                    </v-flex>
                  </v-row>
                </div>
              </div>
              <v-card-actions>
                <v-spacer></v-spacer>
                <v-btn
                  color="green darken-1"
                  text
                  @click="document = false"
                >
                  Close
                </v-btn>
              </v-card-actions>
            </v-card>
          </v-dialog>
        </v-row>
      </template>
    </v-container>
  </div>  
</template>

<script>
import axios from 'axios';
export default {
  data(){
    return {
      quotation: {
        quotation_summation: "",
        quotation_delivery: "",
        quotation_labor: "",
        quotation_bendingcharges: "",
      },

      project: {
        project_description: "",
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

      materials: [],

      subcontractors: [],

      subcontractorList:[],

      services: ["Roofing", "Mansory", "Electrical", "Plumbing"],


      quotations:[
        {
          quotation_id:"100",
          quotation_summation:"999",
          quotation_delivery:"999",
          quotation_labor:"999",
          quotation_bendingcharges:"999",

          project: {
            project_description: "a",
            project_type: "a",
            date_from: new Date().toISOString().substr(0, 10),
            date_until: new Date().toISOString().substr(0, 10),

            project_street: "a",
            project_barangay: "a",
            project_city: "a",
            project_postal_code: "a",
          },
          customer: {
            customer_name: "a",
            customer_street: "a",
            customer_barangay: "a",
            customer_city: "a",
            customer_postal_code: "a",
          },
          materials: [
            {
              material_name: "a",
              material_description: "a",
              material_quantity: "1",
              material_price: "1000",
            },
          ],
          subcontractor: {
            subcontractor_name: "Mon",
            subcontractor_service: "Plumbing",
          },
          charges: {
            delivery:"1",
            labor:"1",
            bending_charges:"1",
          },
        },

        {
          quotation_id:"200",
          quotation_summation:"999",
          quotation_delivery:"999",
          quotation_labor:"999",
          quotation_bendingcharges:"999",

          project: {
            project_description: "b",
            project_type: "b",
            date_from: new Date().toISOString().substr(0, 10),
            date_until: new Date().toISOString().substr(0, 10),

            project_street: "b",
            project_barangay: "b",
            project_city: "b",
            project_postal_code: "b",
          },
          customer: {
            customer_name: "b",

            customer_street: "b",
            customer_barangay: "b",
            customer_city: "b",
            customer_postal_code: "b",
          },
          materials: [
            {
              material_name: "b",
              material_description: "b",
              material_quantity: "10",
              material_price: "100",
            },
            {
              material_name: "b",
              material_description: "b",
              material_quantity: "5",
              material_price: "11",
            },
          ],
          subcontractor: {
            subcontractor_name: "San",
            subcontractor_service: "Mansory",
          },
          charges: {
            delivery:"2",
            labor:"2",
            bending_charges:"2",
          },
        },
      ],
      
      current_quotation_id:"",
      current_quotation: {
        quotation_id:"",
        quotation_summation:"",
        quotation_delivery:"",
        quotation_labor:"",
        quotation_bendingcharges:"",

        project: {
          project_description: "",
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
        materials: [
          {
            material_name: "",
            material_description: "",
            material_quantity: "",
            material_price: "",
          },
        ],
        subcontractor: {
          subcontractor_name: "",
          subcontractor_service: "",
        },
        charges: {
          delivery:"",
          labor:"",
          bending_charges:"",
        },
      },

      listed_materials:{},

      search: "",

      direction: 'top',
      fab: false,
      hover: false,
      top: false,
      right: false,
      bottom: false,
      left: false,
      transition: 'slide-y-reverse-transition',

      dialog: false,
      dialog2: false,
      document: false,
    }
  },
  created(){
    this.$store.state.count = 1;
    axios({
      method: 'GET',
      url: 'http://localhost:3000/quotation',
    })
    .then((response) =>{
      var revised = []
      for(var ctr=0; ctr<response.data.data.length; ctr++){
        if(response.data.data[ctr].deleted == 1){
          var Quotation_Materials = []
          for(var ctr2=0; ctr2<response.data.materials.length; ctr2++){
            if(response.data.data[ctr].ProjectID == response.data.materials[ctr2].ProjectID){
              Quotation_Materials.push({
                material_name: response.data.materials[ctr2].MatName,
                material_description: response.data.materials[ctr2].MatDescription,
                material_quantity: response.data.materials[ctr2].MatQty,
                material_price: response.data.materials[ctr2].MatPrice,
              })
            }
          }

          revised.push(
            {
              custID: response.data.data[ctr].CustID,
              ProjectID: response.data.data[ctr].ProjectID,
              BillID: response.data.data[ctr].BillID,
              UserID: response.data.data[ctr].UserID,

              quotation_id: response.data.data[ctr].QuoID,
              quotation_summation: response.data.data[ctr].summation,
              quotation_delivery: response.data.data[ctr].DeliveryCharges,
              quotation_labor: response.data.data[ctr].LaborCharges,
              quotation_bendingcharges: response.data.data[ctr].BendingCharges,

              project: {
                project_description: response.data.data[ctr].ProjDesc,
                project_type: response.data.data[ctr].ProjType,
                date_from: new Date().toISOString().substr(0, 10),
                date_until: new Date().toISOString().substr(0, 10),

                project_street: response.data.data[ctr].StreetNumber,
                project_barangay: response.data.data[ctr].Barangay,
                project_city: response.data.data[ctr].City,
                project_postal_code: response.data.data[ctr].PostalCode,
              },
              customer: {
                customer_Fname: response.data.data[ctr].FirstName,
                customer_Mname: response.data.data[ctr].MiddleName,
                customer_Lname: response.data.data[ctr].LastName,
              },
              
              materials: Quotation_Materials,
        
              subcontractor: {
                subcontractor_firstname: response.data.data[ctr].subcontractors.split(' ')[0],
                subcontractor_middlename: response.data.data[ctr].subcontractors.split(' ')[1],
                subcontractor_lastname: response.data.data[ctr].subcontractors.split(' ')[2],
                SublistID: response.data.data[ctr].SublistID,
                subcontractor_service: response.data.data[ctr].ServiceName,
              },
            },
          )
        }
        this.quotations = revised
      }
      console.log()
    })

    axios({
      method: 'GET',
      url: 'http://localhost:3000/subcontractors',
    })
    .then((response) =>{
      this.subcontractors = response.data.data
    })
  },
  methods:{
    showdocument: function(id){
      this.document = true;
      this.current_quotation = this.quotations[id];
    },
    computeAmount(index){
      return this.current_quotation.materials[index].material_quantity * this.current_quotation.materials[index].material_price
    },
    
  },
  computed:{
    filtermat: function(){
      var all = []
      all = this.quotations.filter((quotation)=>{
        return quotation.project.project_description.match(this.search);
      })

      if(all.length == 0){
        all = this.quotations.filter((quotation)=>{
        return quotation.project.project_type.match(this.search)
      })
      }

      if(all.length == 0){
        all = this.quotations.filter((quotation)=>{
          return quotation.customer.customer_Fname.concat(' ' + quotation.customer.customer_Lname).match(this.search)
        })
      }
      
      return all
      
    },
  }
}
</script>