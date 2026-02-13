import { Routes } from '@angular/router';
import { DestinationManager } from './components/destination-manager/destination-manager.component';
import { DestinationForm } from './components/destination-manager/destination-form/destination-form.component';
import { Home } from './components/home/home.component';
import { TouristMap } from './components/tourist-map/tourist-map.component';
import { DestinationDetail } from './components/destination-detail/destination-detail.component';

export const routes: Routes = [
    {
        path: '',
        component: Home,
        title: 'Inicio | Explora Nicaragua'
    },
    {
        path: 'destinos',
        loadComponent: () => import('./components/destinations/destinations.component').then(m => m.Destinations),
        title: 'Destinos | Explora Nicaragua'
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
        path: 'mapa', 
        component: TouristMap, 
        title: 'Mapa Turístico | Explora Nicaragua' 
    },
    { 
        path: 'destino/:id', 
        component: DestinationDetail, 
        title: 'Detalle del Destino | Explora Nicaragua' 
    },
    {
        path: '**',
        redirectTo: ''
    }
];
