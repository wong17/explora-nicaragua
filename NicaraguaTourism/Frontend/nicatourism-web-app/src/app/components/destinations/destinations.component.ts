import { Component, computed, inject, OnInit, signal } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';
import { RouterLink } from '@angular/router';
import { InputTextModule } from 'primeng/inputtext';
import { ButtonModule } from 'primeng/button';
import { ToastModule } from 'primeng/toast';
import { DestinationService } from '../../core/services/destination.service';
import { ApiResponseCode, DestinationSummaryDto, ToasterService } from '../../core/core.index';
import { HttpErrorResponse } from '@angular/common/http';

@Component({
  selector: 'app-destinations',
  imports: [CommonModule, FormsModule, RouterLink, InputTextModule, ButtonModule, ToastModule],
  templateUrl: './destinations.component.html',
  styleUrl: './destinations.component.css',
})
export class Destinations implements OnInit {

  private destinationService = inject(DestinationService);
  private toaster = inject(ToasterService); 

  destinations = signal<DestinationSummaryDto[]>([]);
  searchQuery = signal('');
  loading = signal(true);

  favoritesSet = new Set<number>();

  ngOnInit() {
    this.loadDestinations();
  }

  loadDestinations() {
    this.loading.set(true);

    this.destinationService.getAll().subscribe({
      next: (response) => {
        if (response.isSuccess == ApiResponseCode.Success) {
          this.destinations.set(response.result.data);
        } else {
          this.toaster.error(response.message, 'Error al cargar');
        }
        this.loading.set(false);
      },
      error: (err: HttpErrorResponse) => {
        this.toaster.error(err.error.message, 'Error de Conexión');
        this.loading.set(false);
      }
    });
  }

  filteredDestinations = computed(() => {
    const query = this.searchQuery().toLowerCase().trim();
    const list = this.destinations();

    if (!query) return list;

    return list.filter(dest => {
      const nameMatch = dest.name.toLowerCase().includes(query);
      const locationMatch = dest.location ? dest.location.toLowerCase().includes(query) : false;

      return nameMatch || locationMatch;
    });
  });

  toggleFavorite(event: Event, id: number) {
    event.stopPropagation();
    event.preventDefault();

    if (this.favoritesSet.has(id)) {
      this.favoritesSet.delete(id);
      this.toaster.info('Destino quitado de tu lista temporal', 'Removido');
    } else {
      this.favoritesSet.add(id);
      this.toaster.success('Destino agregado a tu lista temporal', '¡Guardado!');
    }
  }

  isFavorite(id: number): boolean {
    return this.favoritesSet.has(id);
  }
}