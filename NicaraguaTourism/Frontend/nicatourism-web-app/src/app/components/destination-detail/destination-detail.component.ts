import { Component, inject, OnInit, signal } from '@angular/core';
import { CommonModule } from '@angular/common';
import { ActivatedRoute, RouterLink } from '@angular/router';
import { DestinationService } from '../../core/services/destination.service';
import { DestinationDto, ApiResponseCode, ToasterService } from '../../core/core.index';
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
  private toasterService = inject(ToasterService);

  destination = signal<DestinationDto | null>(null);
  loading = signal<boolean>(true);

  ngOnInit(): void {
    const idParam = this.route.snapshot.paramMap.get('id');
    if (idParam) {
      this.loadDestination(Number(idParam));
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

  getCoverImage(): string {
    const dest = this.destination();
    if (!dest || !dest.images || dest.images.length === 0) return '/assets/images/nicaragua-wallpaper.webp';

    const cover = dest.images.find(img => img.isCover);
    return cover ? cover.imageUrl : dest.images[0].imageUrl;
  }

}
