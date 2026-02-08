import { Component, inject, OnInit, OnDestroy } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';
import { ActivatedRoute, Router, RouterLink } from '@angular/router';

import * as L from 'leaflet';
import { ButtonModule } from 'primeng/button';
import { InputTextModule } from 'primeng/inputtext';
import { InputNumberModule } from 'primeng/inputnumber';
import { FileUploadModule } from 'primeng/fileupload';
import { TagModule } from 'primeng/tag';
import { TextareaModule } from 'primeng/textarea';
import { SelectModule } from 'primeng/select';
import { TooltipModule } from 'primeng/tooltip';

import {
  ActivityInsertDto,
  ApiResponse,
  ApiResponseCode,
  AuthService,
  DestinationRegisterDto,
  DestinationService,
  DestinationUpdateDto,
  ToasterService
} from '../../../core/core.index';
import { Observable } from 'rxjs';

// Interfaz para el estado del formulario
interface DestinationFormTemplate {
  destinationId?: number | null;
  name: string;
  shortDescription: string;
  longDescription: string;
  location: string;
  latitude: number | null;
  longitude: number | null;
  averageWeather: string;
  accessDifficulty: 'Fácil' | 'Moderado' | 'Difícil' | 'Extremo' | '';
  activities: ActivityInsertDto[];
}

// Evento de PrimeNG FileUpload
interface FileSelectEvent {
  originalEvent: Event;
  files: File[];
  currentFiles: File[];
}

@Component({
  selector: 'app-destination-form',
  imports: [
    CommonModule,
    FormsModule,
    RouterLink,
    ButtonModule,
    InputTextModule,
    InputNumberModule,
    FileUploadModule,
    TagModule,
    TextareaModule,
    SelectModule,
    TooltipModule
  ],
  templateUrl: './destination-form.component.html',
  styleUrl: './destination-form.component.css',
})
export class DestinationForm implements OnInit, OnDestroy {

  private destinationService = inject(DestinationService);
  private authService = inject(AuthService);
  private toasterService = inject(ToasterService);
  private router = inject(Router);
  private route = inject(ActivatedRoute);

  readonly DEFAULT_LAT = 12.865416;
  readonly DEFAULT_LNG = -85.207229;
  readonly DEFAULT_ZOOM = 7.5;
  readonly DEFAULT_MAX_ZOOM = 19;
  readonly DETAIL_ZOOM = 13;

  isEditMode = false;
  isLoading = false;
  submitted = false;

  currentDestination: DestinationFormTemplate = this.createEmptyDestination();
  selectedFiles: File[] = []; // Para almacenar las fotos nuevas
  tempActivity: string = ''; // Para el input de actividades

  // Opciones para el Select
  difficultyOptions = [
    { label: 'Fácil', value: 'Fácil' },
    { label: 'Moderado', value: 'Moderado' },
    { label: 'Difícil', value: 'Difícil' },
    { label: 'Extremo', value: 'Extremo' }
  ];

  // Variables del Mapa
  private map: L.Map | undefined;
  private marker: L.Marker | undefined;

  ngOnInit(): void {
    const id = this.route.snapshot.paramMap.get('id');

    if (id) {
      this.isEditMode = true;
      this.loadDestinationData(Number(id));
    } else {
      setTimeout(() => this.initMap(), 100);
    }
  }

  ngOnDestroy(): void {
    if (this.map) {
      this.map.remove();
    }
  }

  createEmptyDestination(): DestinationFormTemplate {
    return {
      destinationId: null,
      name: '',
      shortDescription: '',
      longDescription: '',
      location: '',
      latitude: null,
      longitude: null,
      averageWeather: '',
      accessDifficulty: '',
      activities: []
    };
  }

  loadDestinationData(id: number) {
    this.isLoading = true;
    this.destinationService.getById(id).subscribe({
      next: (resp) => {
        if (resp.isSuccess === ApiResponseCode.Success && resp.result) {
          const d = resp.result;

          // Mapeamos la respuesta al formulario
          this.currentDestination = {
            destinationId: d.destinationId,
            name: d.name,
            shortDescription: d.shortDescription,
            longDescription: d.longDescription || '',
            location: d.location || '',
            latitude: d.latitude || null,
            longitude: d.longitude || null,
            averageWeather: d.averageWeather || '',
            // Casteo seguro para el select
            accessDifficulty: (d.accessDifficulty as DestinationFormTemplate['accessDifficulty']) || '',
            activities: d.activities ? [...d.activities] : []
          };

          // Una vez cargados los datos, iniciamos el mapa en esa posición
          setTimeout(() => this.initMap(), 100);
        } else {
          this.toasterService.error('No se encontró el destino');
          this.router.navigate(['/admin/destinos']);
        }
        this.isLoading = false;
      },
      error: () => {
        this.toasterService.error('Error de conexión al cargar datos');
        this.router.navigate(['/admin/destinos']);
      }
    });
  }

  private initMap(): void {
    // Si ya existe instancia, la limpiamos
    if (this.map) {
      this.map.remove();
    }

    // Coordenadas por defecto
    const lat = this.currentDestination.latitude || this.DEFAULT_LAT;
    const lng = this.currentDestination.longitude || this.DEFAULT_LNG;
    const zoom = this.currentDestination.latitude ? this.DETAIL_ZOOM : this.DEFAULT_ZOOM;

    // 'map-full' será el ID del div en el HTML
    this.map = L.map('map-full', { center: [lat, lng], zoom: zoom });

    L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
      maxZoom: this.DEFAULT_MAX_ZOOM,
      attribution: '© OpenStreetMap'
    }).addTo(this.map);

    // Si ya tenemos coordenadas, ponemos el marcador
    if (this.currentDestination.latitude && this.currentDestination.longitude) {
      this.addMarker(this.currentDestination.latitude, this.currentDestination.longitude);
    }

    // Evento Click: Mover el marcador y actualizar inputs
    this.map.on('click', (e: L.LeafletMouseEvent) => {
      const { lat, lng } = e.latlng;
      // Actualizamos modelo
      this.currentDestination.latitude = parseFloat(lat.toFixed(6));
      this.currentDestination.longitude = parseFloat(lng.toFixed(6));
      // Actualizamos visual
      this.addMarker(lat, lng);
    });
  }

  private addMarker(lat: number, lng: number) {
    if (this.marker) {
      this.marker.setLatLng([lat, lng]);
    } else {
      this.marker = L.marker([lat, lng]).addTo(this.map!);
    }
  }

  addActivity() {
    if (this.tempActivity.trim()) {
      this.currentDestination.activities.push({
        activityName: this.tempActivity.trim(),
        iconName: 'fa-check'
      });
      this.tempActivity = '';
    }
  }

  removeActivity(index: number) {
    this.currentDestination.activities.splice(index, 1);
  }

  onFileSelect(event: FileSelectEvent) {
    if (event.files && event.files.length > 0) {
      this.selectedFiles = [...event.files];
    }
  }

  save() {
    this.submitted = true;

    // Validación Básica
    if (!this.currentDestination.name.trim() || !this.currentDestination.shortDescription.trim()) {
      this.toasterService.warning('Por favor completa los campos obligatorios (*)', 'Faltan datos');
      return;
    }

    const adminId = this.authService.currentUser()?.userId;
    if (!adminId) {
      this.toasterService.error('Sesión no válida. Recarga la página.');
      return;
    }

    // Preparamos el DTO
    const baseDto: DestinationRegisterDto = {
      name: this.currentDestination.name,
      shortDescription: this.currentDestination.shortDescription,
      longDescription: this.currentDestination.longDescription || null,
      location: this.currentDestination.location || null,
      latitude: this.currentDestination.latitude,
      longitude: this.currentDestination.longitude,
      averageWeather: this.currentDestination.averageWeather || null,
      accessDifficulty: this.currentDestination.accessDifficulty || null,
      activities: this.currentDestination.activities,
      images: [] // Las imágenes van por separado en el servicio
    };

    // Decidimos si es UPDATE o CREATE
    let requestObservable: Observable<ApiResponse<any>>;

    if (this.isEditMode && this.currentDestination.destinationId) {
      const updateDto: DestinationUpdateDto = {
        destinationId: this.currentDestination.destinationId,
        ...baseDto
      };
      requestObservable = this.destinationService.update(updateDto, this.selectedFiles, adminId);
    } else {
      requestObservable = this.destinationService.create(baseDto, this.selectedFiles, adminId);
    }

    // Ejecutamos la petición
    this.isLoading = true;
    requestObservable.subscribe({
      next: (resp) => {
        this.isLoading = false;
        if (resp.isSuccess === ApiResponseCode.Success) {
          this.toasterService.success(resp.message, 'Éxito');
          this.router.navigate(['/admin/destinos']);
        } else {
          this.toasterService.error(resp.message, 'Error en servidor');
        }
      },
      error: (err) => {
        this.isLoading = false;
        this.toasterService.error(err.error?.message || 'Error de conexión', 'Error');
      }
    });
  }
}
