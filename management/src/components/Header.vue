<template>
  <div v-if="this.$store.state.count==1">
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
      <h3
        style="margin-right:0px; width:380px"
      >Mendez Engineering Services</h3>
      
        <v-list-item
          v-for="item in logout"
          :key="item.title"
          :to="item.url"
          link
        >
          <v-list-item-icon>
            <v-icon>{{ item.icon }}</v-icon>
          </v-list-item-icon>

          <v-list-item-content>
            <v-list-item-title>{{ item.title }}</v-list-item-title>
          </v-list-item-content>
        </v-list-item>
          
    </v-app-bar>
    
    <v-navigation-drawer
      style="margin-top:49px"
      fixed
      permanent
      width="170px"

    >

      <v-list dense>
        <v-list-item
          style="padding-left:21px"
          v-for="item in items"
          :key="item.title"
          :to="item.url"
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
          { title: 'Dashboard', icon: 'mdi-home-city', url: '/dashboard' },
          { title: 'Services', icon: 'mdi-account', url: '/services' },
          { title: 'Accounts', icon: 'mdi-account-group-outline', url: '/accountlist' },
          { title: 'Archive', icon: 'mdi-account-group-outline', url: '/archive' },
        ],
        logout:[
          { title: 'Logout', icon: 'mdi-logout', url: '/login' },
        ]
    }
  },
  methods:{
  },
}
</script>