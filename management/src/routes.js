import Login from './components/Login.vue'
import Dashboard from './components/Dashboard.vue'
import Services from './components/Services.vue'
import AccountList from './components/AccountList.vue'


export default[
    {path: '/login', component: Login},
    {path: '/dashboard', component: Dashboard},
    {path: '/services', component: Services},
    {path: '/accountlist', component: AccountList},
]
