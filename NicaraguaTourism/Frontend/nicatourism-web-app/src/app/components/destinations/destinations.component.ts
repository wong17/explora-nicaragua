import { Component, computed, inject, OnInit, signal } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';
import { RouterLink } from '@angular/router';
import { InputTextModule } from 'primeng/inputtext';
import { ButtonModule } from 'primeng/button';
import { ToastModule } from 'primeng/toast';
import { DestinationService } from '../../core/services/destination.service';
import { 
  ApiResponseCode, 
  AuthService, 
  DestinationDto, 
  DestinationImageInsertDto, 
  FavoriteInteractionDto, 
  FavoriteService, 
  ToasterService 
} from '../../core/core.index';
import { HttpErrorResponse } from '@angular/common/http';

@Component({
  selector: 'app-destinations',
  imports: [CommonModule, FormsModule, RouterLink, InputTextModule, ButtonModule, ToastModule],
  templateUrl: './destinations.component.html',
  styleUrl: './destinations.component.css',
})
export class Destinations implements OnInit {

  private destinationService = inject(DestinationService);
  private favoriteService = inject(FavoriteService);
  private toaster = inject(ToasterService); 
  private authService = inject(AuthService);

  destinations = signal<DestinationDto[]>([]);
  searchQuery = signal('');
  loading = signal(true);

  favoritesSet = signal<Set<number>>(new Set<number>());

  ngOnInit() {
    this.loadDestinations();
    this.loadUserFavorites();
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

  loadUserFavorites() {
    const user = this.authService.currentUser();

    if (!user) return;

    this.favoriteService.getByUser(user.userId).subscribe({
      next: (response) => {
        if (response.isSuccess === ApiResponseCode.Success) {
          const favoriteIds = response.result.data
            .map(fav => fav.destination?.destinationId)
            .filter(id => id != null) as number[];

          this.favoritesSet.set(new Set<number>(favoriteIds));
        }
      },
      error: (err: HttpErrorResponse) => console.error(err.error.message || 'No se pudieron cargar los favoritos', err)
    });
  }

  private normalizeText(text: string | null | undefined): string {
    if (!text) return '';
    return text
      .normalize('NFD') // Separa la letra del acento (ej: 'á' -> 'a' + '´')
      .replace(/[\u0300-\u036f]/g, '')
      .toLowerCase()
      .trim();
  }

  filteredDestinations = computed(() => {
    const query = this.normalizeText(this.searchQuery());
    const list = this.destinations();

    if (!query) return list;

    return list.filter(dest => {
      const normalizedName = this.normalizeText(dest.name);
      const normalizedLocation = this.normalizeText(dest.location);

      return normalizedName.includes(query) || normalizedLocation.includes(query);
    });
  });

  toggleFavorite(event: Event, destId: number) {
    event.stopPropagation();
    event.preventDefault();

    const user = this.authService.currentUser();
    if (!user) {
      this.toaster.warning('Por favor, inicia sesión para guardar favoritos', 'Atención');
      return;
    }

    // 
    const interaction: FavoriteInteractionDto = {
      userId: user.userId,
      destinationId: destId
    };

    const isFav = this.favoritesSet().has(destId);

    if (isFav) {
      this.favoritesSet.update(set => {
        const newSet = new Set(set);
        newSet.delete(destId);
        return newSet;
      });

      this.favoriteService.remove(interaction).subscribe({
        next: (response) => {
          if (response.isSuccess === ApiResponseCode.Success) {
            this.toaster.info('Destino quitado de tu lista', 'Removido');
          } else {
            this.favoritesSet.update(set => new Set(set).add(destId)); // Revertir si falla
            this.toaster.error('No se pudo quitar de favoritos', 'Error');
          }
        },
        error: (err: HttpErrorResponse) => {
          this.favoritesSet.update(set => new Set(set).add(destId)); // Revertir si hay error de red
          this.toaster.error(err.error.message || 'Error de conexión', 'Error');
        }
      });

    } else {
      // Actualización optimista: agregar
      this.favoritesSet.update(set => new Set(set).add(destId));

      this.favoriteService.add(interaction).subscribe({
        next: (response) => {
          if (response.isSuccess === ApiResponseCode.Success) {
            this.toaster.success('Destino agregado a favoritos', '¡Guardado!');
          } else {
            this.favoritesSet.update(set => {
              const newSet = new Set(set);
              newSet.delete(destId);
              return newSet;
            }); // Revertir si falla
            this.toaster.error('No se pudo agregar a favoritos', 'Error');
          }
        },
        error: (err: HttpErrorResponse) => {
          this.favoritesSet.update(set => {
            const newSet = new Set(set);
            newSet.delete(destId);
            return newSet;
          }); // Revertir si hay error de red
          this.toaster.error(err.error.message || 'Error de conexión', 'Error');
        }
      });
    }
  }

  isFavorite(id: number): boolean {
    return this.favoritesSet().has(id);
  }

  getCoverImage(dest: DestinationDto): string {
    if (dest.images && dest.images.length > 0) {
      const cover = dest.images.find((img: DestinationImageInsertDto) => img.isCover);
      return cover ? cover.imageUrl : dest.images[0].imageUrl;
    }

    return '/assets/images/nicaragua-wallpaper.webp';
  }
}