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
            <span style="color:#BDBDBD">May</span>
            <p class="font-weight-bold" style="margin-bottom:5px">Quotations</p>
            <b><p style="color: #1976D2;margin-bottom:5px">100,200</p></b>
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
            <span style="color:#BDBDBD">May</span>
            <p class="font-weight-bold" style="margin-bottom:5px">Revenue</p>
            <b><p style="color: #1976D2;margin-bottom:5px">100,200</p></b>
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
            <span style="color:#BDBDBD">May</span>
            <p class="font-weight-bold" style="margin-bottom:5px">Profit</p>
            <b><p style="color: #1976D2;margin-bottom:5px">100,200</p></b>
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
          <span style="color:#BDBDBD">May</span>
            <p class="font-weight-bold" style="margin-bottom:5px">Cost</p>
            <b><p style="color: #1976D2;margin-bottom:5px">100,200</p></b>
          </v-card>
        </v-col>
      </v-row>


      <v-row>
        <!-- <v-col> -->
          <v-row style="margin: 30px 0px 0px 7px">
            <v-col>
              <v-card style="margin-left:5px"
                width="470px"
                height="200px"
              >
                <v-subheader>Weekly Sales of January</v-subheader>

                <v-sparkline
                  :labels="labels"
                  :value="value"
                  :gradient="gradient"
                  :smooth="radius || false"
                  :padding="padding"
                  :line-width="width"
                  :stroke-linecap="lineCap"
                  :gradient-direction="gradientDirection"
                  :fill="fill"
                  :type="type"
                  :auto-line-width="autoLineWidth"
                  auto-draw
                ></v-sparkline>

              </v-card>
            </v-col>
            <v-col>
              <v-card style="margin-left:5px"
                width="470px"
                height="200px"
              >
                <v-subheader>Monthly Sales</v-subheader>

                <v-sparkline
                  :labels="labels"
                  :value="value"
                  :gradient="gradient"
                  :smooth="radius || false"
                  :padding="padding"
                  :line-width="width"
                  :stroke-linecap="lineCap"
                  :gradient-direction="gradientDirection"
                  :fill="fill"
                  :type="type"
                  :auto-line-width="autoLineWidth"
                  auto-draw
                ></v-sparkline>

              </v-card>
            </v-col>
          </v-row>
        <!-- </v-col> -->

      </v-row>
    </v-container>
  </div>
</template>
<script>

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
      value: [0, 2, 5, 9, 5, 10, 3, 7, 8, 9, 0, 2, 5,],
      gradientDirection: 'top',
      gradients,
      fill: false,
      type: 'trend',
      autoLineWidth: false,

      quotations:"",
      revenue:"",
      profit:"",
      cost:"",
    }
  },
}
</script>
