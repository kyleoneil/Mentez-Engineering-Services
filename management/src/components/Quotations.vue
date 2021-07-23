<template>
  <div>
    <v-container style="text-align: left;">
      <h1 class="ml-3">Quotations</h1>
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
              <!------------------ CREATE MODAL ------------------>
              <v-dialog v-model="dialog" width="700">
                <template v-slot:activator="{ on, attrs }">
                  <v-btn style="display: inline; float: right;" color="#32CD32" class="mt-1 white--text" v-bind="attrs" v-on="on">
                    Add Quotation
                  </v-btn>
                </template>
                <v-card
                  class="mx-auto"
                  max-width="700"
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
                        <v-text-field
                          v-model="customer.customer_Fname"
                          label="First Name"
                        ></v-text-field>
                        <v-text-field
                          v-model="customer.customer_Mname"
                          label="Middle Name"
                        ></v-text-field>
                        <v-text-field
                          v-model="customer.customer_Lname"
                          label="Last Name"
                        ></v-text-field>
                      </v-card-text>
                    </v-window-item>

                    <v-window-item :value="2">
                      <v-card-text>
                        <v-row>
                          <v-col>
                            <v-text-field
                              v-model="project.project_description"
                              label="Project Name"
                            ></v-text-field>
                          </v-col>
                          <v-col>
                            <v-text-field
                              v-model="project.project_type"
                              label="Type of Project"
                            ></v-text-field>
                            
                          </v-col>
                        </v-row>
                        <div class=".text-md-body-1">
                          Schedule Date
                        </div>
                        <v-row>
                          <v-col>
                            <v-menu
                              ref="menu"
                              v-model="menu"
                              :close-on-content-click="false"
                              :return-value.sync="project.date_from"
                              transition="scale-transition"
                              offset-y
                              min-width="auto"
                            >
                              <template v-slot:activator="{ on, attrs }">
                                <v-text-field
                                  v-model="project.date_from"
                                  label="Date from"
                                  prepend-icon="mdi-calendar"
                                  readonly
                                  v-bind="attrs"
                                  v-on="on"
                                ></v-text-field>
                              </template>
                              <v-date-picker
                                v-model="project.date_from"
                                no-title
                                :min="mindate_from"
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
                                  v-on:click="changeDate()"
                                  @click="$refs.menu.save(project.date_from)"
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
                              :return-value.sync="project.date_until"
                              transition="scale-transition"
                              offset-y
                              min-width="auto"
                            >
                              <template v-slot:activator="{ on, attrs }">
                                <v-text-field
                                  v-model="project.date_until"
                                  label="Date until"
                                  prepend-icon="mdi-calendar"
                                  readonly
                                  v-bind="attrs"
                                  v-on="on"
                                ></v-text-field>
                              </template>
                              <v-date-picker
                                v-model="project.date_until"
                                no-title
                                :min="mindate_until"
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
                                  @click="$refs.menu2.save(project.date_until)"
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
                              v-model="project.project_street"
                              label="Street"
                            ></v-text-field>
                          </v-col>
                          <v-col>
                            <v-text-field
                              v-model="project.project_barangay"
                              label="Barangay"
                            ></v-text-field>
                          </v-col>
                        </v-row>
                        <v-row>
                          <v-col>
                            <v-text-field
                              v-model="project.project_city"
                              label="City"
                            ></v-text-field>
                          </v-col>
                          <v-col>
                            <v-text-field
                              v-model="project.project_postal_code"
                              type="number"
                              min="0"
                              label="Postal Code"
                            ></v-text-field>
                          </v-col>
                        </v-row>
                      </v-card-text>
                    </v-window-item>

                    <v-window-item :value="3">
                      <v-card-text>
                        <v-row>
                          <div class=".text-md-body-1" style="width:100px">
                            Service:
                          </div>
                          <v-col>
                            <v-select 
                              :items="services"
                              v-model="selectedService"
                              label="Service"
                              outlined
                              dense
                            ></v-select>
                          </v-col>
                        </v-row>
                        <v-row>
                          <div class=".text-md-body-1" style="width:100px">
                            SubContractor:
                          </div>
                          <v-col>
                            <v-select
                              :items="filteredsubcontractorsFname"
                              v-model="selectedSubcontractor"
                              label="Name"
                              dense
                            ></v-select>
                            
                          </v-col>
                        </v-row>
                      </v-card-text>
                    </v-window-item>

                    <v-window-item :value="4">
                      <div class="caption grey--text ml-12">Affix Material</div>
                      <v-card flat class=" mx-12 pa-7" style="background-color: #F8F8F8;">
                        <v-layout row wrap>
                          <v-flex xs12 md4 pr-1>
                            <v-select
                              v-model="affixMaterial.material_name"
                              :items="getListedMaterials"
                              color="pink"
                              label="Material"
                              required
                              dense
                            ></v-select>
                          </v-flex>
                          <v-flex xs12 md5 pr-1>
                            <v-select
                              v-model="affixMaterial.material_description"
                              :items="filteredMaterial"
                              color="pink"
                              label="Description"
                              required
                              dense
                            ></v-select>
                          </v-flex>
                          <v-flex xs12 md2 pr-1>
                            <v-text-field
                              label="Qty"
                              v-model="affixMaterial.material_quantity"
                              type="number"
                              min="0"
                              dense
                            ></v-text-field>
                          </v-flex>
                          <v-flex xs6 xs4 md1 style="margin: 4px 0px 0px 0px">
                            <v-btn 
                              text
                              v-on:click="addMaterial([affixMaterial.material_name,affixMaterial.material_description])"
                            >
                              <v-icon small color="black">mdi-plus</v-icon>
                            </v-btn>
                          </v-flex>
                        </v-layout>
                      </v-card>
                      <div class="caption grey--text mt-8 ml-12">Material List</div>
                      <v-card flat class="mb-4 mx-12 pa-7" style="background-color: #F8F8F8;">
                        <v-layout row wrap>
                          <v-flex xs12 md3>
                            <div class="caption grey--text">Material</div>
                          </v-flex>
                          <v-flex xs12 md5>
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

                        <v-layout row wrap
                          v-for="(material, index) in materials" :key="index"
                        >
                          <v-flex xs12 md3 pr-1 style="margin: 10px 0px;">
                            <div class="text-caption">{{material.material_name}}</div>
                          </v-flex>
                          <v-flex xs12 md5 pr-1 style="margin: 10px 0px">
                            <div class="text-caption">{{material.material_description}}</div>
                          </v-flex>
                          <v-flex xs12 md1 pr-1 style="margin: 10px 0px">
                            <div class="text-caption">{{material.material_quantity}}</div>
                          </v-flex>
                          <v-flex xs12 md2 pr-1 style="margin: 10px 0px">
                            <div class="text-caption">₱{{material.material_price}}</div>
                          </v-flex>
                          <v-flex xs6 xs4 md1 style="margin: 10px 0px">
                            <v-btn text height="20px">
                              <v-icon 
                                small color="black"
                                v-on:click="removeMaterial(index)"
                              >mdi-minus</v-icon>
                            </v-btn>
                          </v-flex>
                        </v-layout>
                        
                      </v-card>
                      
                    </v-window-item>

                    <v-window-item :value="5">
                      <v-card-text>
                        <v-row>
                          <v-col>
                            <v-text-field
                              v-model="quotation.quotation_delivery"
                              prefix="₱"
                              min="0"
                              label="Delivery"
                            ></v-text-field>
                          </v-col>
                          <v-col>
                            <v-text-field
                              v-model="quotation.quotation_labor"
                              prefix="₱"
                              min="0"
                              label="Labor"
                            ></v-text-field>
                          </v-col>
                          <v-col>
                            <v-text-field
                              v-model="quotation.quotation_bendingcharges"
                              prefix="₱"
                              min="0"
                              label="Bending Charges"
                            ></v-text-field>
                          </v-col>
                        </v-row>
                      </v-card-text>
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
                    <v-btn v-if="step !== 5"
                      :disabled="step === 5"
                      color="primary"
                      depressed
                      @click="step++"
                    >
                      Next
                    </v-btn>
                    <v-btn v-else
                      color="primary"
                      depressed
                      v-on:click="createQuotation()"
                    >
                      Create
                    </v-btn>
                  </v-card-actions>
                </v-card>
              </v-dialog>
              <!------------------ END CREATE MODAL ------------------>
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
            <div class="caption grey--text">SubContractor</div>
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
              <v-btn
                v-on:click="showdocument(index)"
                fab
                dark
                x-small
                color="indigo"
              >
                <v-icon>mdi-text-box-search-outline</v-icon>
              </v-btn>
              <v-btn
                v-on:click="editmodal(index)"
                fab
                dark
                x-small
                color="green"
              >
                <v-icon>mdi-pencil</v-icon>
              </v-btn>
              <v-btn
                v-on:click="remove(quotation.quotation_id)"
                fab
                dark
                x-small
                color="red"
              >
                <v-icon>mdi-delete</v-icon>
              </v-btn>
            </v-speed-dial>
          </v-flex>
        </v-layout>
      </v-card>

      <!-- ------------------------- Edit Modal -------------------------->
      <v-dialog v-model="dialog2" width="700">
        <v-card
          class="mx-auto"
          max-width="700"
        >
          <v-card-title class="title font-weight-regular justify-space-between">
            <span>{{ currentTitle2 }}</span>
            <v-icon
              @click="dialog2 = false"
            >
              mdi-close
            </v-icon>
          </v-card-title>

          <v-window v-model="step2">

            <v-window-item :value="1">
              <v-card-text>
                <v-text-field
                  v-model="current_quotation.customer.customer_Fname"
                  type="text"
                  label="First Name"
                ></v-text-field>
                <v-text-field
                  v-model="current_quotation.customer.customer_Mname"
                  type="text"
                  label="Middle Name"
                ></v-text-field>
                <v-text-field
                  v-model="current_quotation.customer.customer_Lname"
                  type="text"
                  label="Last Name"
                ></v-text-field>
              </v-card-text>
            </v-window-item>

            <v-window-item :value="2">
              <v-card-text>
                <v-row>
                  <v-col>
                    <v-text-field
                      v-model="current_quotation.project.project_description"
                      label="Project Name"
                    ></v-text-field>
                  </v-col>
                  <v-col>
                    <v-text-field
                      v-model="current_quotation.project.project_type"
                      label="Type of Project"
                    ></v-text-field>
                    
                  </v-col>
                </v-row>
                <div class=".text-md-body-1">
                  Schedule Date
                </div>
                <v-row>
                  <v-col>
                    <v-menu
                      ref="menu"
                      v-model="menu"
                      :close-on-content-click="false"
                      :return-value.sync="current_quotation.project.date_from"
                      transition="scale-transition"
                      offset-y
                      min-width="auto"
                    >
                      <template v-slot:activator="{ on, attrs }">
                        <v-text-field
                          v-model="current_quotation.project.date_from"
                          label="Date from"
                          prepend-icon="mdi-calendar"
                          readonly
                          v-bind="attrs"
                          v-on="on"
                        ></v-text-field>
                      </template>
                      <v-date-picker
                        v-model="current_quotation.project.date_from"
                        no-title
                        :min="mindate_from"
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
                          v-on:click="changeDate2()"
                          @click="$refs.menu.save(current_quotation.project.date_from)"
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
                      :return-value.sync="current_quotation.project.date_until"
                      transition="scale-transition"
                      offset-y
                      min-width="auto"
                    >
                      <template v-slot:activator="{ on, attrs }">
                        <v-text-field
                          v-model="current_quotation.project.date_until"
                          label="Date until"
                          prepend-icon="mdi-calendar"
                          readonly
                          v-bind="attrs"
                          v-on="on"
                        ></v-text-field>
                      </template>
                      <v-date-picker
                        v-model="current_quotation.project.date_until"
                        no-title
                        :min="mindate_from"
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
                          @click="$refs.menu2.save(current_quotation.project.date_until)"
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
                      v-model="current_quotation.project.project_street"
                      label="Street"
                    ></v-text-field>
                  </v-col>
                  <v-col>
                    <v-text-field
                      v-model="current_quotation.project.project_barangay"
                      label="Barangay"
                    ></v-text-field>
                  </v-col>
                </v-row>
                <v-row>
                  <v-col>
                    <v-text-field
                      v-model="current_quotation.project.project_city"
                      label="City"
                    ></v-text-field>
                  </v-col>
                  <v-col>
                    <v-text-field
                      v-model="current_quotation.project.project_postal_code"
                      type="number"
                      min="0"
                      label="Postal Code"
                    ></v-text-field>
                  </v-col>
                </v-row>
              </v-card-text>
            </v-window-item>

            <v-window-item :value="3">
              <v-card-text>
                <v-row>
                          <div class=".text-md-body-1" style="width:100px">
                            Service:
                          </div>
                          <v-col>
                            <v-select 
                              :items="services"
                              v-model="selectedService"
                              label="Service"
                              outlined
                              dense
                            ></v-select>
                          </v-col>
                        </v-row>
                        <v-row>
                          <div class=".text-md-body-1" style="width:100px">
                            SubContractor:
                          </div>
                          <v-col>
                            <v-select
                              :items="filteredsubcontractorsFname"
                              v-model="selectedSubcontractor"
                              label="Name"
                              dense
                            ></v-select>
                          </v-col>
                        </v-row>
              </v-card-text>
            </v-window-item>

            <v-window-item :value="4">
              <div class="caption grey--text ml-12">Affix Material</div>
              <v-card flat class=" mx-12 pa-7" style="background-color: #F8F8F8;">
                <v-layout row wrap>
                  <v-flex xs12 md4 pr-1>
                    <v-select
                      v-model="affixMaterial.material_name"
                      :items="getListedMaterials"
                      color="pink"
                      label="Material"
                      required
                      dense
                    ></v-select>
                  </v-flex>
                  <v-flex xs12 md5 pr-1>
                    <v-select
                      v-model="affixMaterial.material_description"
                      :items="filteredMaterial"
                      color="pink"
                      label="Description"
                      required
                      dense
                    ></v-select>
                  </v-flex>
                  <v-flex xs12 md2 pr-1>
                    <v-text-field
                      label="Qty"
                      v-model="affixMaterial.material_quantity"
                      type="number"
                      min="0"
                      dense
                    ></v-text-field>
                  </v-flex>
                  <v-flex xs6 xs4 md1 style="margin: 4px 0px 0px 0px">
                    <v-btn 
                      text
                      v-on:click="addMaterial2([affixMaterial.material_name,affixMaterial.material_description])"
                    >
                      <v-icon small color="black">mdi-plus</v-icon>
                    </v-btn>
                  </v-flex>
                </v-layout>
              </v-card>
              <div class="caption grey--text mt-8 ml-12">Material List</div>
              <v-card flat class="mb-4 mx-12 pa-7" style="background-color: #F8F8F8;">
                <v-layout row wrap>
                  <v-flex xs12 md3>
                    <div class="caption grey--text">Material</div>
                  </v-flex>
                  <v-flex xs12 md5>
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

                <v-layout row wrap
                  v-for="(material, index) in current_quotation.materials" :key="index"
                >
                  <v-flex xs12 md3 pr-1 style="margin: 10px 0px;">
                    <div class="text-caption">{{material.material_name}}</div>
                  </v-flex>
                  <v-flex xs12 md5 pr-1 style="margin: 10px 0px">
                    <div class="text-caption">{{material.material_description}}</div>
                  </v-flex>
                  <v-flex xs12 md1 pr-1 style="margin: 10px 0px">
                    <div class="text-caption">{{material.material_quantity}}</div>
                  </v-flex>
                  <v-flex xs12 md2 pr-1 style="margin: 10px 0px">
                    <div class="text-caption">₱{{material.material_price}}.00</div>
                  </v-flex>
                  <v-flex xs6 xs4 md1 style="margin: 10px 0px">
                    <v-btn text height="20px">
                      <v-icon 
                        small color="black"
                        v-on:click="removeMaterial2(index)"
                      >mdi-minus</v-icon>
                    </v-btn>
                  </v-flex>
                </v-layout>
              </v-card>
            </v-window-item>

            <v-window-item :value="5">
              <v-card-text>
                <v-row>
                  <v-col>
                    <v-text-field
                      v-model="current_quotation.quotation_delivery"
                      type="number"
                      prefix="₱"
                      label="Delivery"
                    ></v-text-field>
                  </v-col>
                  <v-col>
                    <v-text-field
                      v-model="current_quotation.quotation_labor"
                      type="number"
                      prefix="₱"
                      label="Labor"
                    ></v-text-field>
                  </v-col>
                  <v-col>
                    <v-text-field
                      v-model="current_quotation.quotation_bendingcharges"
                      type="number"
                      prefix="₱"
                      label="Bending Charges"
                    ></v-text-field>
                  </v-col>
                </v-row>
              </v-card-text>
            </v-window-item>
          </v-window>

          <v-divider></v-divider>

          <v-card-actions>
            <v-btn
              :disabled="step2 === 1"
              text
              @click="step2--"
            >
              Back
            </v-btn>
            <v-spacer></v-spacer>
            <v-btn v-if="step2 !== 5"
              :disabled="step2 === 5"
              color="primary"
              depressed
              @click="step2++"
            >
              Next
            </v-btn>
            <v-btn v-else
              color="primary"
              depressed
              v-on:click="edit(current_quotation.quotation_id)"
            >
              Submit
            </v-btn>
          </v-card-actions>

        </v-card>
      </v-dialog>
      <!-- END OF EDIT MODAL -------------------->
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
        date_from:"",
        date_until:"",

        project_street: "",
        project_barangay: "",
        project_city: "",
        project_postal_code: "",
      },

      customer: {
        customer_Fname: "",
        customer_Mname: "",
        customer_Lname: "",
      },

      materials: [],
      addMaterialTotalPrice: 0,
      addMaterialTotalPrice2: 0,

      subcontractors: [],

      affixMaterial: {
        material_name: "",
        material_description: "",
        material_quantity: "",
        material_price: "",
      },

      affixsubcontractors:[],

      subcontractorList:[],

      services: ["Roofing", "Masonry", "Electrical", "Plumbing"],
      
      selectedService: "",
      selectedSubcontractor: "",
      selectedSubcontractorFname: "",
      selectedSubcontractorMname: "",
      selectedSubcontractorLname: "",
      selectedSubID: "",
      selectedServiceID: "",
      sub:"",


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

      amount: 0,
      mindate_from: '2021-07-24',
      mindate_until: '2021-07-24',

      listed_materials:{},


      check9: false,
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
      step: 1,
      step2: 1,
      
      menu: false,
      modal: false,
      menu2: false,

      test: "TEST",
    }
  },
  computed: {
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
    currentTitle () {
      switch (this.step) {
        case 1: return 'Customer Profile'
        case 2: return 'Project Information'
        case 3: return 'SubContractors'
        case 4: return 'Materials'
        default: return 'Additional Charges'
      }
    },
    currentTitle2 () {
      switch (this.step2) {
        case 1: return 'Customer Profile'
        case 2: return 'Project Information'
        case 3: return 'SubContractors'
        case 4: return 'Materials'
        default: return 'Additional Charges'
      }
    },
    filteredsubcontractorsFname() {
      // DATA STATIC
      var test = [];
      // for(var ctr=0; ctr<this.subcontractors.length; ctr++){
      //   test.push(
      //     {
      //       subcontractor_Fname: this.subcontractors[ctr].FirstName,
      //       subcontractor_Mname: this.subcontractors[ctr].MiddleName,
      //       subcontractor_Lname: this.subcontractors[ctr].LastName,
      //       subcontractor_service: this.subcontractors[ctr].ServiceName,
      //       SubId: this.subcontractors[ctr].SubId,
      //       SublistID: this.subcontractors[ctr].SublistID,
      //       ServiceID: this.subcontractors[ctr].SerivceID
      //     }
      //   )
      // }

      for(var ctr=0; ctr<this.subcontractors.length; ctr++){
        test.push(
          {
            subcontractor_Fname: this.subcontractors[ctr].FirstName,
            subcontractor_Mname: this.subcontractors[ctr].MiddleName,
            subcontractor_Lname: this.subcontractors[ctr].LastName,
            subcontractor_service: this.subcontractors[ctr].ServiceName,
            subcontractor_FullName: this.subcontractors[ctr].FirstName + ' ' + this.subcontractors[ctr].MiddleName + ' ' + this.subcontractors[ctr].LastName,
            SubId: this.subcontractors[ctr].SubId,
            SublistID: this.subcontractors[ctr].SublistID,
            ServiceID: this.subcontractors[ctr].SerivceID
          }
        )
      }

      var subcontractors = [];
      var service = this.selectedService;
      var filtered =  test.filter(function(entry){
        return entry.subcontractor_service == service;
      });
      
      for( ctr=0; ctr<filtered.length; ctr++){
        subcontractors.push(filtered[ctr].subcontractor_FullName)
      }
      return subcontractors;
    },
    // filteredsubcontractorsLname() {
    //   // DATA STATIC
    //   var test = [];
    //   for(var ctr=0; ctr<this.subcontractors.length; ctr++){
    //     test.push(
    //       {
    //         subcontractor_Fname: this.subcontractors[ctr].FirstName,
    //         subcontractor_Mname: this.subcontractors[ctr].MiddleName,
    //         subcontractor_Lname: this.subcontractors[ctr].LastName,
    //         subcontractor_service: this.subcontractors[ctr].ServiceName,
    //         SubId: this.subcontractors[ctr].SubId,
    //         SublistID: this.subcontractors[ctr].SublistID,
    //         ServiceID: this.subcontractors[ctr].SerivceID
    //       }
    //     )
    //   }


    //   var subcontractors = [];
    //   var service = this.selectedService;
    //   var filtered =  test.filter(function(entry){
    //     return entry.subcontractor_service == service;
    //   });
      
    //   for( ctr=0; ctr<filtered.length; ctr++){
    //     subcontractors.push(filtered[ctr].subcontractor_Lname)
    //   }
    //   return subcontractors;
    // },
    getListedMaterials(){
      var mats = []
      for(var ctr=0; ctr<this.listed_materials.length; ctr++){
        mats.push(this.listed_materials[ctr].MatName)
      }
      return mats
    },
    filteredMaterial() {
      var revised = []
      for(var ctr=0; ctr<this.listed_materials.length; ctr++){
        revised.push(
          {
            MatDescription: this.listed_materials[ctr].MatDescription,
            MatName: this.listed_materials[ctr].MatName,
            MatPrice: this.listed_materials[ctr].MatPrice,
            MatQty: this.listed_materials[ctr].MatQty, 
            ProjectId: this.listed_materials[ctr].ProjectId
          }
        )
      }

      var descriptions = [];
      var MatName = this.affixMaterial.material_name;

      var filtered =  revised.filter(function(entry){
        return entry.MatName == MatName;
      });

      for(ctr=0; ctr<filtered.length; ctr++){
        descriptions.push(filtered[ctr].MatDescription)
      }

      return descriptions;
    },
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
        if(response.data.data[ctr].deleted == 0){
          var Quotation_Materials = []
          for(var ctr2=0; ctr2<response.data.materials.length; ctr2++){
            if(response.data.data[ctr].ProjectID == response.data.materials[ctr2].ProjectID){
              Quotation_Materials.push({
                material_name: response.data.materials[ctr2].MatName,
                material_description: response.data.materials[ctr2].MatDescription,
                material_quantity: response.data.materials[ctr2].MatQty,
                material_price: response.data.materials[ctr2].MatPrice * response.data.materials[ctr2].MatQty,
              })
            }
          }
          var date_from = new Date(response.data.data[ctr].ProjStart)
          var date_until = new Date(response.data.data[ctr].ProjEnd)
          date_from.setDate(date_from.getDate() + 1)
          date_until.setDate(date_until.getDate() + 1)
          var ndf = new Date(date_from).toISOString().substr(0, 10)
          var ndu = new Date(date_until).toISOString().substr(0, 10)

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
                date_from: ndf,
                date_until: ndu,

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
    })

    axios({
      method: 'GET',
      url: 'http://localhost:3000/materials',
    })
    .then((response) =>{
      this.listed_materials = response.data.data
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
    createQuotation: function(){
      this.summation()
      for(var ctr=0; ctr<this.subcontractors.length && ((this.subcontractors[ctr].FirstName + ' ' + this.subcontractors[ctr].MiddleName + ' ' + this.subcontractors[ctr].LastName) != this.selectedSubcontractor && this.subcontractors[ctr].ServiceName != this.selectedService); ctr++);

      axios({
        method: 'POST',
        url: 'http://localhost:3000/quotation/add',
        data: {
          quotation_summation: parseInt(this.quotation.quotation_summation),
          quotation_delivery: parseInt(this.quotation.quotation_delivery),
          quotation_labor: parseInt(this.quotation.quotation_labor),
          quotation_bendingcharges: parseInt(this.quotation.quotation_bendingcharges),
          
          ProjectID: this.quotation.ProjectID,
          proj_description: this.project.project_description,
          project_type: this.project.project_type,
          date_from: new Date(this.project.date_from).toISOString().substr(0, 10),
          date_until: new Date(this.project.date_until).toISOString().substr(0, 10),

          project_street: this.project.project_street,
          project_barangay: this.project.project_barangay,
          project_city: this.project.project_city,
          project_postal_code: this.project.project_postal_code,

          customer_firstname: this.customer.customer_Fname,
          customer_middlename: this.customer.customer_Mname,
          customer_lastname: this.customer.customer_Lname,

          materials: this.materials,
          totalListPrice: parseInt(this.addMaterialTotalPrice),

          amount: parseInt(this.amount),
          userid: 1,

          subcontractor_firstname: this.selectedSubcontractor.split(' ')[0],
          subcontractor_middlename: this.selectedSubcontractor.split(' ')[1],
          subcontractor_lastname: this.selectedSubcontractor.split(' ')[2],
          subcontractor_service: this.selectedService,

          ServiceID: parseInt(this.subcontractors[ctr].ServiceID),
          SublistID: parseInt(this.subcontractors[ctr].SublistID),
        }
      })
      .then(
        this.$router.go()
      )

    },
    editmodal: function(id) {
      this.dialog2 = true;
      this.step2 = 1;
      this.current_quotation = this.quotations[id];
      this.mindate_from = this.current_quotation.project.date_from
      this.mindate_until = this.mindate_from
      this.check9 = true
      this.selectedService = this.current_quotation.subcontractor.subcontractor_service
      this.selectedSubcontractor = this.current_quotation.subcontractor.subcontractor_firstname + ' ' + this.current_quotation.subcontractor.subcontractor_middlename + ' ' + this.current_quotation.subcontractor.subcontractor_lastname

      var totalPrice = 0;
      for(var ctr=0; ctr < this.current_quotation.materials.length; ctr++){
        totalPrice += parseInt(this.current_quotation.materials[ctr].material_price)
      }

      this.addMaterialTotalPrice2 = totalPrice
    },
    edit: function(id){
      this.summation2()
      for(var ctr=0; ctr<this.subcontractors.length && (this.subcontractors[ctr].subcontractor_name != this.selectedSubcontractor && this.subcontractors[ctr].ServiceName != this.selectedService); ctr++)
      this.selectedServiceID = this.subcontractors[ctr].ServiceID
      axios({
        method: 'PUT',
        url: 'http://localhost:3000/quotation/'+id+'/edit',
        data: {

          quotation_summation: this.current_quotation.quotation_summation,
          quotation_delivery: this.current_quotation.quotation_delivery,
          quotation_labor: this.current_quotation.quotation_labor,
          quotation_bendingcharges: this.current_quotation.quotation_bendingcharges,
          
          ProjectID: this.current_quotation.ProjectID,
          project_description: this.current_quotation.project.project_description,
          project_type: this.current_quotation.project.project_type,
          date_from: new Date(this.current_quotation.project.date_from).toISOString().substr(0, 10),
          date_until: new Date(this.current_quotation.project.date_until).toISOString().substr(0, 10),

          project_street: this.current_quotation.project.project_street,
          project_barangay: this.current_quotation.project.project_barangay,
          project_city: this.current_quotation.project.project_city,
          project_postal_code: this.current_quotation.project.project_postal_code,

          customer_firstname: this.current_quotation.customer.customer_Fname,
          customer_middlename: this.current_quotation.customer.customer_Mname,
          customer_lastname: this.current_quotation.customer.customer_Lname,

          materials: this.current_quotation.materials,
          totalListPrice: this.addMaterialTotalPrice2,

          amount: parseInt(this.amount),
          userid: 1,

          subcontractor_firstname: this.selectedSubcontractor.split(' ')[0],
          subcontractor_middlename: this.selectedSubcontractor.split(' ')[1],
          subcontractor_lastname: this.selectedSubcontractor.split(' ')[2],
          subcontractor_service: this.selectedService,

          ServiceID: parseInt(this.subcontractors[ctr].ServiceID),
          SublistID: parseInt(this.subcontractors[ctr].SublistID),
        }
      })
      .then(
        // this.$router.go()
      )
    },
    remove: function(id){
      axios({
        method: 'PUT',
        url: 'http://localhost:3000/quotation/' + id + '/delete',
      })
      .then(()=>{
        this.$router.go()
      })
    },
    showdocument: function(id){
      this.document = true;
      this.current_quotation = this.quotations[id];
      for(var ctr=0; ctr<this.current_quotation.materials.length; ctr++){
        this.current_quotation.materials[ctr].material_price /= this.current_quotation.materials[ctr].material_quantity
      }
    },
    addMaterial: function(data){
      var revised = []
      for(var ctr=0; ctr<this.listed_materials.length; ctr++){
        revised.push(
          {
            MatDescription: this.listed_materials[ctr].MatDescription,
            MatName: this.listed_materials[ctr].MatName,
            MatPrice: this.listed_materials[ctr].MatPrice,
            MatStatus: this.listed_materials[ctr].MatStatus,
            MatQty: this.listed_materials[ctr].MatQuantity, 
          }
        )
      }
      var material_status = ""
      var filtered =  revised.filter(function(entry){
        return entry.MatName == data[0] && entry.MatDescription == data[1];
      });


      for(ctr=0; ctr<this.materials.length; ctr++){
        if(this.affixMaterial.material_name == this.materials[ctr].material_name && this.affixMaterial.material_description == this.materials[ctr].material_description){
          break
        }
      }
    
      if(ctr < this.materials.length){
        this.materials[ctr].material_quantity = parseInt(this.materials[ctr].material_quantity) + parseInt(this.affixMaterial.material_quantity)

        this.materials[ctr].MatStatus = ((filtered[0].MatQty - parseInt(this.materials[ctr].material_quantity)) > 0)?"IN STOCK":"FOR ORDER"
        this.materials[ctr].material_price = filtered[0].MatPrice *  parseInt(this.materials[ctr].material_quantity)

      }else{
        material_status = ((filtered[0].MatQty - this.affixMaterial.material_quantity) > 0)?"IN STOCK":"FOR ORDER";

        var mat = {
          material_name: this.affixMaterial.material_name,
          material_description: this.affixMaterial.material_description,
          MatStatus: material_status,
          material_quantity: this.affixMaterial.material_quantity,
          material_price: parseInt(filtered[0].MatPrice *  this.affixMaterial.material_quantity)
        }

        this.addMaterialTotalPrice += mat.material_price
        this.materials.push(mat);
      }
      this.addMaterialTotalPrice = 0
      for(ctr=0; ctr<this.materials.length; ctr++){
        this.addMaterialTotalPrice += parseInt(this.materials[ctr].material_price)
      }
    },
    addMaterial2: function(data){
      var revised = []
      for(var ctr=0; ctr<this.listed_materials.length; ctr++){
        revised.push(
          {
            MatDescription: this.listed_materials[ctr].MatDescription,
            MatName: this.listed_materials[ctr].MatName,
            MatStatus: this.listed_materials[ctr].MatStatus,
            MatPrice: this.listed_materials[ctr].MatPrice,
            MatQty: this.listed_materials[ctr].MatQuantity, 
            
          }
        )
      }

      var material_status = ""
      var filtered =  revised.filter(function(entry){
        return entry.MatName == data[0] && entry.MatDescription == data[1];
      });

      material_status = ((filtered[0].MatQty - this.affixMaterial.material_quantity) > 0)?"IN STOCK":"FOR ORDER";
      if(this.check9 == true){
        for(ctr=0; ctr<this.current_quotation.materials.length; ctr++){
          for(var ctr3=0 ; ctr3<revised.length; ctr3++){
            if(this.current_quotation.materials[ctr].material_name == revised[ctr3].MatName && this.current_quotation.materials[ctr].MatDescription == revised[ctr3].material_description){
              this.current_quotation.materials[ctr].MatStatus = revised[ctr].MatStatus
            }

          }
        }
      }

      for(ctr=0; ctr<this.current_quotation.materials.length; ctr++){
        if(this.affixMaterial.material_name == this.current_quotation.materials[ctr].material_name && this.affixMaterial.material_description == this.current_quotation.materials[ctr].material_description){
          break
        }
      }

      
      if(ctr < this.current_quotation.materials.length){
        this.current_quotation.materials[ctr].material_quantity = parseInt(this.current_quotation.materials[ctr].material_quantity) + parseInt(this.affixMaterial.material_quantity)

        this.current_quotation.materials[ctr].MatStatus = ((filtered[0].MatQty - parseInt(this.current_quotation.materials[ctr].material_quantity)) > 0)?"IN STOCK":"FOR ORDER"
        this.current_quotation.materials[ctr].material_price = filtered[0].MatPrice *  parseInt(this.current_quotation.materials[ctr].material_quantity)
        
      }else{
        material_status = ((filtered[0].MatQty - this.affixMaterial.material_quantity) > 0)?"IN STOCK":"FOR ORDER";

        var mat = {
          material_name: this.affixMaterial.material_name,
          material_description: this.affixMaterial.material_description,
          MatStatus: material_status,
          material_quantity: this.affixMaterial.material_quantity,
          material_price: parseInt(filtered[0].MatPrice *  this.affixMaterial.material_quantity)
        }
        this.current_quotation.materials.push(mat);
      }
     this.addMaterialTotalPrice = 0
      for(var ctr2 = 0; ctr2<this.current_quotation.materials.length; ctr2++){
        this.addMaterialTotalPrice += parseInt(this.current_quotation.materials[ctr2].material_price)
      }
      
    },
    removeMaterial: function(index){
      this.materials.splice(index,1)
    },
    removeMaterial2: function(index){
      this.current_quotation.materials.splice(index,1)
    },
    computeAmount(index){
      return this.current_quotation.materials[index].material_quantity * this.current_quotation.materials[index].material_price
    },
    summation: function() {
      var total = 0;
      for(var ctr=0; ctr<this.materials.length; ctr++){
        total += parseInt(this.materials[ctr].material_price)
      }
      total += parseInt(this.quotation.quotation_delivery)
      total += parseInt(this.quotation.quotation_labor)
      total += parseInt(this.quotation.quotation_bendingcharges)
      this.quotation.quotation_summation = total;
      this.amount = total * 1.2
    },
    summation2: function() {
      var total = 0;
      for(var ctr=0; ctr<this.current_quotation.materials.length; ctr++){
        total += parseInt(this.current_quotation.materials[ctr].material_price)
      }
      total += parseInt(this.current_quotation.quotation_delivery)
      total += parseInt(this.current_quotation.quotation_labor)
      total += parseInt(this.current_quotation.quotation_bendingcharges)
      this.current_quotation.quotation_summation = total;
      this.amount = total * 1.2
    },
    changeDate: function() {
      this.mindate_until = this.project.date_from
    },
    changeDate2: function() {
      this.mindate_until = this.current_quotation.project.date_from
      console.log(this.mindate_until)
    },
  },
}
</script>