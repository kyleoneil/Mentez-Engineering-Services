import Login from './components/Login.vue'
import Dashboard from './components/Dashboard.vue'
import Quotations from './components/Quotations.vue'
import Materials from './components/Materials.vue'


export default[
    {path: '/login', component: Login},
    {path: '/dashboard', component: Dashboard},
    {path: '/quotations', component: Quotations},
    {path: '/materials', component: Materials},
]