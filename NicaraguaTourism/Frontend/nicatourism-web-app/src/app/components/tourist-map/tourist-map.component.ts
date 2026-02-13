import { Component, OnInit, AfterViewInit, inject, OnDestroy } from '@angular/core';
import { CommonModule } from '@angular/common';
import * as L from 'leaflet';
import { DestinationService } from '../../core/services/destination.service';
import { ApiResponseCode, DestinationDto } from '../../core/core.index';

@Component({
  selector: 'app-tourist-map',
  imports: [CommonModule],
  templateUrl: './tourist-map.component.html',
  styleUrl: './tourist-map.component.css',
})
export class TouristMap implements OnInit, AfterViewInit, OnDestroy {

  private destinationService = inject(DestinationService);
  private map!: L.Map;

  destinations: DestinationDto[] = [];

  private readonly MAX_ZOOM: number = 18;
  private readonly TILE_LAYER_URL = 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png';

  ngOnInit(): void {
    this.loadDestinations();
  }

  ngAfterViewInit(): void {
    this.initMap();
  }

  ngOnDestroy(): void {
    if (this.map) {
      this.map.remove();
    }
  }

  private initMap(): void {
    this.map = L.map('touristMap', {
      zoomControl: false
    });

    L.control.zoom({ position: 'bottomright' }).addTo(this.map);

    L.tileLayer(this.TILE_LAYER_URL, {
      attribution: '&copy; OpenStreetMap contributors',
      maxZoom: this.MAX_ZOOM
    }).addTo(this.map);

    this.map.setView([12.6, -85.0], 7);
  }

  private loadDestinations() {
    this.destinationService.getAll().subscribe({
      next: (response) => {
        if (response.isSuccess === ApiResponseCode.Success) {
          this.destinations = response.result.data;
          this.addMarkersToMap();
        }
      }
    });
  }

  private addMarkersToMap() {
    const leafletMarkers: L.Marker[] = [];

    this.destinations.forEach(dest => {
      if (dest.latitude && dest.longitude) {

        const customIcon = L.divIcon({
          className: 'custom-div-icon',
          html: `<div class="pulse-marker"><i class="pi pi-map-marker"></i></div>`,
          iconSize: [30, 30],
          iconAnchor: [15, 15]
        });

        const coverImageUrl = this.getCoverImage(dest);
        const popupHtml = `
          <div class="map-popup-card">
            <div class="popup-img-container">
              <img src="${coverImageUrl}" alt="${dest.name}" />
              <div class="popup-badge">${dest.accessDifficulty || 'N/A'}</div>
            </div>
            <div class="popup-content">
              <h4>${dest.name}</h4>
              <p><i class="pi pi-sun"></i> ${dest.averageWeather || '--'}°C &nbsp;&nbsp; <i class="pi pi-map-marker"></i> ${dest.location || ''}</p>
              <a href="/destino/${dest.destinationId}" class="popup-btn">Explorar Destino</a>
            </div>
          </div>
        `;

        const marker = L.marker([dest.latitude, dest.longitude], { icon: customIcon })
          .bindPopup(popupHtml, {
            maxWidth: 250,
            minWidth: 260,
            className: 'popup'
          });

        marker.addTo(this.map);
        leafletMarkers.push(marker);
      }
    });

    if (leafletMarkers.length > 0) {
      const group = L.featureGroup(leafletMarkers);
      this.map.fitBounds(group.getBounds(), {
        padding: [50, 50]
      });
    }
  }

  private getCoverImage(dest: DestinationDto): string {
    if (dest.images && dest.images.length > 0) {
      const cover = dest.images.find(img => img.isCover);
      return cover ? cover.imageUrl : dest.images[0].imageUrl;
    }
    return '/assets/images/nicaragua-wallpaper.webp';
  }
}