<template>
  <div>
    <v-container style="padding: 30px 0px 0px 30px">
      <v-row>
        <!-- First Column -->
        <v-col>
          <v-row>
            <v-card
              width="650px"
            >
              <v-subheader>Quotations</v-subheader>
              <v-list two-line>
                <template v-for="n in 6">
                  <v-list-item

                    :key="n"
                  >
                    <v-list-item-avatar color="grey darken-1">
                    </v-list-item-avatar>

                    <v-list-item-content>
                      <v-list-item-title>
                        ID: {{ n }}
                        <span class="float-right">
                          {{quotations[0].date}}
                        </span>
                      </v-list-item-title>

                      <v-list-item-subtitle>
                        {{quotations[0].description}}
                      </v-list-item-subtitle>
                      <v-list-item-subtitle>
                        {{quotations[0].summation}}
                      </v-list-item-subtitle>
                    </v-list-item-content>
                  </v-list-item>

                  <v-divider
                    v-if="n !== 6"
                    :key="`divider-${n}`"
                    inset
                  ></v-divider>
                </template>
              </v-list>
            </v-card>
          </v-row>
        </v-col>

        <!-- Second Column -->
        <v-col>
          <v-row style="margin-bottom:15px">
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
          </v-row>
          <v-row>
            <v-card style="margin-left:5px"
              width="470px"
              height="340px"
            >
              <v-subheader>Recent Updates</v-subheader>
                <v-card-text>
                  <v-timeline
                    align-top
                    dense
                  >
                    <v-timeline-item
                      v-for="message in messages"
                      :key="message.time"
                      :color="message.color"
                      small
                    >
                      <div>
                        <div class="font-weight-normal">
                          <strong>{{ message.from }}</strong> @{{ message.time }}
                        </div>
                        <div>{{ message.message }}</div>
                      </div>
                    </v-timeline-item>
                  </v-timeline>
                </v-card-text>
            </v-card>
          </v-row>
        </v-col>

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
      quotations: [
        {id:"1", description:"Howdy Howdy...", summation:"1902.60", date:"12/30/60"}
      ],
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

      messages: [
        {
          from: 'You',
          message: `Sure, I'll see you later.`,
          time: '10:42am',
          color: 'deep-purple lighten-1',
        },
        {
          from: 'John Doe',
          message: 'Yeah, sure. Does 1:00pm work?',
          time: '10:37am',
          color: 'deep-purple lighten-1',
        },
        {
          from: 'You',
          message: 'Did you still want to grab lunch today?',
          time: '9:47am',
          color: 'deep-purple lighten-1',
        },
      ],
    }
  },
}
</script>