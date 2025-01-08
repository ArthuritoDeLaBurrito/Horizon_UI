import Home    from '../views/Home.vue';
import Example from '../views/Example.vue';

export const routes = [
    {
        path: '/',
        name: 'Home',
        component: Home,
    },
    {
        path: '/Example', 
        name: 'Example',
        component: Example, 
    },
];
