import { Component, computed, effect, inject, model, signal } from '@angular/core';
import { RouterLink } from '@angular/router';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';
import { 
  ApiResponseCode, 
  AuthService, 
  FavoriteDto, 
  FavoriteInteractionDto, 
  FavoriteService, 
  ToasterService 
} from '../../core/core.index';
import { DialogModule } from "primeng/dialog";
import { ButtonModule } from 'primeng/button';
import { HttpErrorResponse } from '@angular/common/http';

@Component({
  selector: 'app-favorites-dialog',
  imports: [DialogModule, RouterLink, CommonModule, FormsModule, ButtonModule],
  templateUrl: './favorites-dialog.component.html',
  styleUrl: './favorites-dialog.component.css',
})
export class FavoritesDialog {

  private favoriteService = inject(FavoriteService);
  private toasterService = inject(ToasterService);
  private authService = inject(AuthService);

  visible = model<boolean>(false);

  isLoading = signal<boolean>(false);
  favorites = signal<FavoriteDto[]>([]);
  searchQuery = signal<string>('');

  constructor() {
    // Este efecto se ejecuta cada vez que 'visible' cambia
    effect(() => {
      if (this.visible() && this.authService.isLoggedIn()) {
        this.loadFavorites();
      }
    });
  }

  filteredFavorites = computed(() => {
    const query = this.searchQuery().toLowerCase().trim();
    const list = this.favorites();

    if (!query) return list;

    return list.filter(fav => {
      const dest = fav.destination;
      if (!dest) return false;

      // Buscamos por nombre o ubicación dentro del objeto anidado
      return (
        dest.name.toLowerCase().includes(query) || (dest.location && dest.location.toLowerCase().includes(query))
      );
    });
  });

  loadFavorites() {
    this.isLoading.set(true);
    var userId = this.authService.currentUser()?.userId;
    
    if (!userId) {
      this.isLoading.set(false);
      return;
    }

    this.favoriteService.getByUser(userId).subscribe({
      next: (response) => {
        if (response.isSuccess === ApiResponseCode.Success && response.result) {
          this.favorites.set(response.result.data);
        }
        this.isLoading.set(false);
      },
      error: (err: HttpErrorResponse) => {
        this.isLoading.set(false);
        this.favorites.set([]);
        this.toasterService.error(err.error?.message ?? 'Error cargando favoritos')
      }
    });
  }

  removeFavorite(id: number) {
    const userId = this.authService.currentUser()?.userId;
    if (!userId) return;

    const dto: FavoriteInteractionDto = {
      userId: userId,
      destinationId: id
    };

    this.favoriteService.remove(dto).subscribe({
      next: (response) => {
        if (response.isSuccess === ApiResponseCode.Success) {
          // Eliminamos de la lista local buscando dentro del objeto destination anidado
          this.favorites.update(currentList =>
            currentList.filter(f => f.destination?.destinationId !== id)
          );
          this.toasterService.success('Eliminado de favoritos');
          return;
        }

        this.toasterService.error(response.message || 'No se pudo eliminar');
      },
      error: (err) => {
        this.toasterService.error(err.error?.message || 'Error de conexión al eliminar favorito', 'Error al eliminar');
      }
    });
  }

  closeDialog() {
    this.visible.set(false);
  }

}
