import { Routes } from '@angular/router';
import { DestinationManager } from './components/destination-manager/destination-manager.component';
import { DestinationForm } from './components/destination-manager/destination-form/destination-form.component';
import { Home } from './components/home/home.component';

export const routes: Routes = [
    {
        path: '',
        component: Home,
        title: 'Inicio | Explora Nicaragua'
    },
    {
        path: 'admin/destinos',
        component: DestinationManager,
        title: 'Gestión de Destinos | Explora Nicaragua'
    },
    {
        path: 'admin/destinos/nuevo',
        component: DestinationForm,
        title: 'Nuevo Destino'
    },
    {
        path: 'admin/destinos/editar/:id',
        component: DestinationForm,
        title: 'Editar Destino'
    },
    {
        path: '**',
        redirectTo: ''
    }
];
