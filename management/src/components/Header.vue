<template>
  <div>
    <v-app-bar
      dense
      fixed
      color="white"
      elevation=1
    >
      <v-list-item-avatar color="grey darken-3">
        <v-img
          class="elevation-6"
          alt=""
          src="https://avataaars.io/?avatarStyle=Transparent&topType=ShortHairShortCurly&accessoriesType=Prescription02&hairColor=Black&facialHairType=Blank&clotheType=Hoodie&clotheColor=White&eyeType=Default&eyebrowType=DefaultNatural&mouthType=Default&skinColor=Light"
        ></v-img>
      </v-list-item-avatar>
    </v-app-bar>
    
    <v-navigation-drawer
      style="margin-top:50px"
      fixed
      permanent
      width="170px"

    >

      <v-list dense>
        <v-list-item
          style="padding-left:21px"
          v-for="item in items"
          :key="item.title"
          link
        >
          <v-list-item-icon>
            <v-icon>{{ item.icon }}</v-icon>
          </v-list-item-icon>

          <v-list-item-content>
            <v-list-item-title>{{ item.title }}</v-list-item-title>
          </v-list-item-content>
        </v-list-item>
      </v-list>
    </v-navigation-drawer>
  </div>
</template>
<script>
export default {
  data () {
    return {
        items: [
          { title: 'Dashboard', icon: 'mdi-home-city' },
          { title: 'Services', icon: 'mdi-account' },
          { title: 'Accounts', icon: 'mdi-account-group-outline' },
        ],
    }
  },
}
</script>