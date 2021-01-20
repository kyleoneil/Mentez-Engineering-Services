<template>
  <div>
    <v-container style="text-align: left;">
      <h1 class="ml-3">Quotations</h1>
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
                    Add Quotation
                  </v-btn>
                </template>
                <v-card
                  class="mx-auto"
                  max-width="500"
                >
                  <v-card-title class="title font-weight-regular justify-space-between">
                    <span>{{ currentTitle }}</span>
                    <v-icon
                      @click="dialog = false"
                    >
                      mdi-close
                    </v-icon>
                  </v-card-title>

                  <v-window v-model="step">
                    <v-window-item :value="1">
                      <v-card-text>
                        <div class=".text-md-body-1">
                          Project
                        </div>
                        <v-text-field
                          label="Type of Project"
                        ></v-text-field>
                        <div class=".text-md-body-1">
                          Schedule Date
                        </div>
                        <v-row>
                          <v-col>
                            <v-menu
                              ref="menu"
                              v-model="menu"
                              :close-on-content-click="false"
                              :return-value.sync="date"
                              transition="scale-transition"
                              offset-y
                              min-width="auto"
                            >
                              <template v-slot:activator="{ on, attrs }">
                                <v-text-field
                                  v-model="date_from"
                                  label="Date from"
                                  prepend-icon="mdi-calendar"
                                  readonly
                                  v-bind="attrs"
                                  v-on="on"
                                ></v-text-field>
                              </template>
                              <v-date-picker
                                v-model="date_from"
                                no-title
                                scrollable
                              >
                                <v-spacer></v-spacer>
                                <v-btn
                                  text
                                  color="primary"
                                  @click="menu = false"
                                >
                                  Cancel
                                </v-btn>
                                <v-btn
                                  text
                                  color="primary"
                                  @click="$refs.menu.save(date)"
                                >
                                  OK
                                </v-btn>
                              </v-date-picker>
                            </v-menu>
                          </v-col>
                          <v-col>
                            <v-menu
                              ref="menu2"
                              v-model="menu2"
                              :close-on-content-click="false"
                              :return-value.sync="date"
                              transition="scale-transition"
                              offset-y
                              min-width="auto"
                            >
                              <template v-slot:activator="{ on, attrs }">
                                <v-text-field
                                  v-model="date_until"
                                  label="Date until"
                                  prepend-icon="mdi-calendar"
                                  readonly
                                  v-bind="attrs"
                                  v-on="on"
                                ></v-text-field>
                              </template>
                              <v-date-picker
                                v-model="date_until"
                                no-title
                                scrollable
                              >
                                <v-spacer></v-spacer>
                                <v-btn
                                  text
                                  color="primary"
                                  @click="menu2 = false"
                                >
                                  Cancel
                                </v-btn>
                                <v-btn
                                  text
                                  color="primary"
                                  @click="$refs.menu2.save(date)"
                                >
                                  OK
                                </v-btn>
                              </v-date-picker>
                            </v-menu>
                          </v-col>
                        </v-row>

                        <div class=".text-md-body-1">
                          Site Address
                        </div>
                        <v-row>
                          <v-col>
                            <v-text-field
                              label="Street"
                            ></v-text-field>
                          </v-col>
                          <v-col>
                            <v-text-field
                              label="Barangay"
                            ></v-text-field>
                          </v-col>
                        </v-row>
                        <v-row>
                          <v-col>
                            <v-text-field
                              label="City"
                            ></v-text-field>
                          </v-col>
                          <v-col>
                            <v-text-field
                              label="Postal Code"
                            ></v-text-field>
                          </v-col>
                        </v-row>
                      </v-card-text>
                    </v-window-item>

                    <v-window-item :value="2">
                      <v-card-text>
                        <div class=".text-md-body-1">
                          Identity
                        </div>
                        <v-text-field
                          label="Name"
                        ></v-text-field>

                        <div class=".text-md-body-1">
                          Customer Address
                        </div>
                        <v-row>
                          <v-col>
                            <v-text-field
                              label="Street"
                            ></v-text-field>
                          </v-col>
                          <v-col>
                            <v-text-field
                              label="Barangay"
                            ></v-text-field>
                          </v-col>
                        </v-row>
                        <v-row>
                          <v-col>
                            <v-text-field
                              label="City"
                            ></v-text-field>
                          </v-col>
                          <v-col>
                            <v-text-field
                              label="Postal Code"
                            ></v-text-field>
                          </v-col>
                        </v-row>
                      </v-card-text>
                    </v-window-item>

                    <v-window-item :value="3">
                      <v-card flat class="mt-8 mx-12 pa-7" style="background-color: #F8F8F8;">
                        <v-fab-transition>
                          <v-btn
                            color="#4DAAA7"
                            dark
                            absolute
                            top
                            right
                            fab
                            height="40px"
                            width="40px"
                          >
                            <v-icon size="25px">mdi-plus</v-icon>
                          </v-btn>
                        </v-fab-transition>
                        <v-layout row wrap>
                          <v-flex xs12 md4>
                            <div class="caption grey--text">Material</div>
                          </v-flex>
                          <v-flex xs12 md4>
                            <div class="caption grey--text">Description</div>
                          </v-flex>
                          <v-flex xs12 md1>
                            <div class="caption grey--text">Qty</div>
                          </v-flex>
                          <v-flex xs12 md2>
                            <div class="caption grey--text">Price</div>
                          </v-flex>
                          <v-flex xs6 xs4 md1></v-flex>
                        </v-layout>

                        <v-layout row wrap>
                          <v-flex xs12 md4 style="margin: 10px 0px">
                            <div class="text-caption">Plainsheet</div>
                          </v-flex>
                          <v-flex xs12 md4 style="margin: 10px 0px">
                            <div class="text-caption">0.40mm x 0.915m x 2.44 m</div>
                          </v-flex>
                          <v-flex xs12 md1 style="margin: 10px 0px">
                            <div class="text-caption">200</div>
                          </v-flex>
                          <v-flex xs12 md2 style="margin: 10px 0px">
                            <div class="text-caption">900.52</div>
                          </v-flex>
                          <v-flex xs6 xs4 md1 style="margin: 10px 0px">
                            <v-btn text>
                              <v-icon
                                size="20px"
                              >
                              mdi-pencil</v-icon>
                            </v-btn>
                        </v-flex>
                        </v-layout>
                      </v-card>
                      
                    </v-window-item>
                  </v-window>

                  <v-divider></v-divider>

                  <v-card-actions>
                    <v-btn
                      :disabled="step === 1"
                      text
                      @click="step--"
                    >
                      Back
                    </v-btn>
                    <v-spacer></v-spacer>
                    <v-btn
                      :disabled="step === 3"
                      color="primary"
                      depressed
                      @click="step++"
                    >
                      Next
                    </v-btn>
                  </v-card-actions>
                </v-card>
              </v-dialog>
            </v-col>
          </v-row>
        </v-container>
      </v-form>
      
      <v-divider class="mx-3"></v-divider>
      <v-card flat class="my-3 mx-12 pa-5" style="background-color: #F8F8F8">
        <v-layout>
          <v-flex xs12 md1>
            <div class="caption grey--text">ID:</div>
          </v-flex>
          <v-flex xs12 md3>
            <div class="caption grey--text">Project</div>
          </v-flex>
          <v-flex xs12 md3>
            <div class="caption grey--text">Type</div>
          </v-flex>
          <v-flex xs12 md2>
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
        </v-layout>

        <v-layout>
          <v-flex xs12 md1>
            <div class="subtitle-2">1</div>
          </v-flex>
          <v-flex xs12 md3>
            <div class="subtitle-2">Build a House</div>
          </v-flex>
          <v-flex xs12 md3>
            <div class="subtitle-2">Residence</div>
          </v-flex>
          <v-flex xs12 md2>
            <div class="subtitle-2">La onila</div>
          </v-flex>
          <v-flex xs12 md4>
            <div class="subtitle-2">2021-01-19 - 2021-01-30</div>
          </v-flex>
          <v-flex xs12 md3>
            <div class="subtitle-2">Dimsum Corp</div>
          </v-flex>
          <v-flex xs12 md3>
            <div class="subtitle-2">Plumbing</div>
          </v-flex>
        </v-layout>

      </v-card>
    </v-container>
  </div>  
</template>

<script>
export default {
  data: () => {
    return {
      dialog: false,
      step: 1,
      
      date_from: new Date().toISOString().substr(0, 10),
      date_until: new Date().toISOString().substr(0, 10),
      menu: false,
      modal: false,
      menu2: false,
    }
  },
  computed: {
    currentTitle () {
      switch (this.step) {
        case 1: return 'Project Information'
        case 2: return 'Customer Profile'
        default: return 'Materials'
      }
    },
  },
}
</script>