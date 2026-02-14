import { Component, inject, OnInit, signal } from '@angular/core';
import { CommonModule } from '@angular/common';
import { ActivatedRoute, RouterLink } from '@angular/router';
import { DestinationService } from '../../core/services/destination.service';
import { DestinationDto, ApiResponseCode, ToasterService, AuthService, FavoriteService, SharedFavoriteService, FavoriteInteractionDto } from '../../core/core.index';
import { HttpErrorResponse } from '@angular/common/http';

@Component({
  selector: 'app-destination-detail',
  imports: [CommonModule, RouterLink],
  templateUrl: './destination-detail.component.html',
  styleUrl: './destination-detail.component.css',
})
export class DestinationDetail implements OnInit {

  private route = inject(ActivatedRoute);
  private destinationService = inject(DestinationService);
  private favoriteService = inject(FavoriteService);
  private authService = inject(AuthService);
  private toasterService = inject(ToasterService);
  private sharedFavoriteService = inject(SharedFavoriteService);

  destination = signal<DestinationDto | null>(null);
  loading = signal<boolean>(true);

  ngOnInit(): void {
    const idParam = this.route.snapshot.paramMap.get('id');
    if (idParam) {
      this.loadDestination(Number(idParam));
      this.loadUserFavorites();
    } else {
      this.loading.set(false);
    }
  }

  private loadDestination(id: number) {
    this.destinationService.getById(id).subscribe({
      next: (response) => {
        if (response.isSuccess === ApiResponseCode.Success) {
          this.destination.set(response.result);
        }
        this.loading.set(false);
      },
      error: (err: HttpErrorResponse) => {
        this.toasterService.error(err.error.message || 'Error al cargar el destino');
        this.loading.set(false);
      }
    });
  }

  loadUserFavorites() {
    const user = this.authService.currentUser();
    if (!user) return;

    this.favoriteService.getByUser(user.userId).subscribe({
      next: (response: any) => {
        if (response.isSuccess === ApiResponseCode.Success) {
          const favoriteIds = response.result.data
            .map((fav: any) => fav.destination?.destinationId)
            .filter((id: any) => id != null) as number[];

          this.sharedFavoriteService.sharedFavoriteIds.set(new Set<number>(favoriteIds));
        }
      },
      error: (err: HttpErrorResponse) => console.error(err.error.message || 'No se pudieron cargar los favoritos', err)
    });
  }

  toggleFavorite(): void {
    const user = this.authService.currentUser();
    const destId = this.destination()?.destinationId;

    if (!user) {
      this.toasterService.warning('Por favor, inicia sesión para guardar favoritos', 'Atención');
      return;
    }
    if (!destId) return;

    const interaction: FavoriteInteractionDto = {
      userId: user.userId,
      destinationId: destId
    };

    const isFav = this.sharedFavoriteService.sharedFavoriteIds().has(destId);

    if (isFav) {
      this.sharedFavoriteService.sharedFavoriteIds.update(set => {
        const newSet = new Set(set);
        newSet.delete(destId);
        return newSet;
      });

      this.favoriteService.remove(interaction).subscribe({
        next: (response) => {
          if (response.isSuccess === ApiResponseCode.Success) {
            this.toasterService.info('Destino quitado de tu lista', 'Removido');
          } else {
            this.sharedFavoriteService.sharedFavoriteIds.update(set => new Set(set).add(destId)); // Revertir
            this.toasterService.error('No se pudo quitar de favoritos', 'Error');
          }
        },
        error: (err: HttpErrorResponse) => {
          this.sharedFavoriteService.sharedFavoriteIds.update(set => new Set(set).add(destId)); // Revertir
          this.toasterService.error(err.error.message || 'Error de conexión', 'Error');
        }
      });

    } else {
      this.sharedFavoriteService.sharedFavoriteIds.update(set => new Set(set).add(destId));

      this.favoriteService.add(interaction).subscribe({
        next: (response) => {
          if (response.isSuccess === ApiResponseCode.Success) {
            this.toasterService.success('Destino agregado a favoritos', '¡Guardado!');
          } else {
            this.sharedFavoriteService.sharedFavoriteIds.update(set => {
              const newSet = new Set(set);
              newSet.delete(destId);
              return newSet;
            }); // Revertir
            this.toasterService.error('No se pudo agregar a favoritos', 'Error');
          }
        },
        error: (err: HttpErrorResponse) => {
          this.sharedFavoriteService.sharedFavoriteIds.update(set => {
            const newSet = new Set(set);
            newSet.delete(destId);
            return newSet;
          }); // Revertir
          this.toasterService.error(err.error.message || 'Error de conexión', 'Error');
        }
      });
    }
  }

  isFavorite(id: number | undefined): boolean {
    if (!id) return false;
    return this.sharedFavoriteService.sharedFavoriteIds().has(id);
  }

  getCoverImage(): string {
    const dest = this.destination();
    if (!dest || !dest.images || dest.images.length === 0) return '/assets/images/nicaragua-wallpaper.webp';

    const cover = dest.images.find(img => img.isCover);
    return cover ? cover.imageUrl : dest.images[0].imageUrl;
  }

}
