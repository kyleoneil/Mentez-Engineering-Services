<template>
  <div>
    <v-container style="padding: 30px 0px 0px 30px">
      <v-row>
        <v-col>
          <v-card
            elevation="2"
            outlined
            shaped
            tile
            style="padding: 7px 0px 0px 10px"
          >
            <span style="color:#BDBDBD">{{getMonth}}</span>
            <p class="font-weight-bold" style="margin-bottom:5px">Quotations</p>
            <b><p style="color: #1976D2;margin-bottom:5px">{{noQuotaions}}</p></b>
          </v-card>
        </v-col>
        <v-col>
          <v-card
            elevation="2"
            outlined
            shaped
            tile
            style="padding: 7px 0px 0px 10px"
          >
            <span style="color:#BDBDBD">{{getMonth}}</span>
            <p class="font-weight-bold" style="margin-bottom:5px">Revenue</p>
            <b><p style="color: #1976D2;margin-bottom:5px">{{getRevenue}}</p></b>
          </v-card>
        </v-col>
        <v-col>
          <v-card
            elevation="2"
            outlined
            shaped
            tile
            style="padding: 7px 0px 0px 10px"
          >
            <span style="color:#BDBDBD">{{getMonth}}</span>
            <p class="font-weight-bold" style="margin-bottom:5px">Profit</p>
            <b><p style="color: #1976D2;margin-bottom:5px">{{getProfit}}</p></b>
          </v-card>
        </v-col>
        <v-col>
          <v-card
            elevation="2"
            outlined
            shaped
            tile
            style="padding: 7px 0px 0px 10px"
          >
          <span style="color:#BDBDBD">{{getMonth}}</span>
            <p class="font-weight-bold" style="margin-bottom:5px">Cost</p>
            <b><p style="color: #1976D2;margin-bottom:5px">{{getCost}}</p></b>
          </v-card>
        </v-col>
      </v-row>


      <v-row>
        <!-- <v-col> -->
          <v-row style="margin: 30px 0px 0px 7px">
            <v-col>
              <template>
                <v-card
                  class="mx-auto text-center"
                  color="green"
                  dark
                  max-width="600"
                >
                  <v-card-text>
                    <v-sheet color="rgba(0, 0, 0, .12)">
                      <v-sparkline
                        :value="value2"
                        color="rgba(255, 255, 255, .7)"
                        height="100"
                        padding="24"
                        stroke-linecap="round"
                        smooth
                      >
                        <template v-slot:label="item">
                          ${{ item.value }}
                        </template>
                      </v-sparkline>
                    </v-sheet>
                  </v-card-text>

                  <v-card-text>
                    <div class="text-h4 font-weight-thin">
                      Sales Last 24h
                    </div>
                  </v-card-text>

                  <v-divider></v-divider>
                </v-card>
              </template>
            </v-col>
            <v-col>
              <template>
                <v-card
                  class="mx-auto text-center"
                  color="green"
                  dark
                  max-width="600"
                >
                  <v-card-text>
                    <v-sheet color="rgba(0, 0, 0, .12)">
                      <v-sparkline
                        :value="value"
                        color="rgba(255, 255, 255, .7)"
                        height="100"
                        padding="24"
                        stroke-linecap="round"
                        smooth
                      >
                        <template v-slot:label="item">
                          ${{ item.value }}
                        </template>
                      </v-sparkline>
                    </v-sheet>
                  </v-card-text>

                  <v-card-text>
                    <div class="text-h4 font-weight-thin">
                      Sales This Month
                    </div>
                  </v-card-text>

                  <v-divider></v-divider>
                </v-card>
              </template>
            </v-col>
          </v-row>
        <!-- </v-col> -->

      </v-row>
    </v-container>
  </div>
</template>
<script>
import axios from 'axios';

const gradients = [
  ['#222'],
  ['#42b3f4'],
  ['red', 'orange', 'yellow'],
  ['purple', 'violet'],
  ['#00c6ff', '#F0F', '#FF0'],
  ['#f72047', '#ffd200', '#1feaea'],
]

export default {
  data () { 
    return {
      width: 2,
      radius: 5,
      padding: 20,
      lineCap: 'round',
      gradient: gradients[5],
      labels: ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9', '10', '11', '12', '13', '14', '15', '16', '17', '18', '19', '20', '21', '22', '23', '24', '25', '26', '27', '28', '29', '30'],
      value: [0,0],
      value2: [0,0],
      gradientDirection: 'top',
      gradients,
      fill: false,
      type: 'trend',
      autoLineWidth: false,

      quotations:[],
      revenue:"",
      profit:"",
      cost:"",
      monthName: ["January", "February", "March", "April", "May", "June","July", "August", "September", "October", "November", "December"],
      month: new Date().getMonth(),
      day: new Date().getDate(),
    }
  },
  created(){
    axios({
      method: 'GET',
      url: 'http://localhost:3000/quotation',
    })
    .then((response) =>{
      var revised = []
      for(var ctr=0; ctr<response.data.data.length; ctr++){
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

            month: new Date(response.data.data[ctr].created).getMonth(),
            day: new Date(response.data.data[ctr].created).getDate(),
          },
        )
      }
      this.quotations = revised

      // SALES THIS MONTH
      var data0 = []
      var check = false
      for(ctr=0; ctr<this.quotations.length && this.quotations[ctr].month == this.month; ctr++){
        data0.push(parseInt(this.quotations[ctr].quotation_summation))
        check = true
      }
      if(check == true){
        this.value = data0
      }
      // --

      // SALES THIS DAY
      var data1 = []
      var check2 = false
      for(ctr=0; ctr<this.quotations.length && this.quotations[ctr].day == this.day; ctr++){
        data1.push(parseInt(this.quotations[ctr].quotation_summation))
        check2 = true
      }
      if(check2 == true){
        this.value2 = data1
      }
      // --

      console.log(this.quotations)
      console.log(response)
    })
  },
  computed: {
    noQuotaions(){
      return this.quotations.length
    },
    getRevenue(){
      var data = 0
      for(var ctr=0; ctr<this.quotations.length; ctr++){
        data += parseInt(this.quotations[ctr].quotation_summation)
      }
      return data *1.2
    },
    getProfit(){
      var data = 0
      for(var ctr=0; ctr<this.quotations.length; ctr++){
        data += parseInt(this.quotations[ctr].quotation_summation)
      }
      return data * 0.2
    },
    getCost(){
      var data = 0
      for(var ctr=0; ctr<this.quotations.length; ctr++){
        data += parseInt(this.quotations[ctr].quotation_summation)
      }
      return data
    },
    getMonth(){
      return this.monthName[this.month]
    },
  },
}
</script>
