import Login from './components/Login.vue'
import Dashboard from './components/Dashboard.vue'
import Services from './components/Services.vue'
import AccountList from './components/AccountList.vue'
import Quotations from './components/Quotations.vue'
import Projects from './components/Projects.vue'
import Archive from './components/Archive.vue'


export default[
    {path: '/login', component: Login},
    {path: '/dashboard', component: Dashboard},
    {path: '/services', component: Services},
    {path: '/accountlist', component: AccountList},
    {path: '/quotations', component: Quotations},
    {path: '/projects', component: Projects},
    {path: '/archive', component: Archive},
]
