import Login from './components/Login.vue'
import Dashboard from './components/Dashboard.vue'
import Quotations from './components/Quotations.vue'
import Materials from './components/Materials.vue'
import AccountList from './components/AccountList.vue'


export default[
    {path: '/login', component: Login},
    {path: '/dashboard', component: Dashboard},
    {path: '/quotations', component: Quotations},
    {path: '/materials', component: Materials},
    {path: '/accountlist', component: AccountList},
]
