import { Component, inject, OnInit } from '@angular/core';
import { CommonModule } from '@angular/common';
import { RouterModule } from '@angular/router';
import { 
  ApiResponseCode, 
  DestinationService, 
  DestinationSummaryDto, 
  ToasterService 
} from '../../core/core.index';
import { ConfirmationService } from 'primeng/api';
import { TableModule } from 'primeng/table';
import { ButtonModule } from 'primeng/button';
import { TagModule } from 'primeng/tag';
import { TooltipModule } from 'primeng/tooltip';
import { ConfirmDialogModule } from 'primeng/confirmdialog';
import { IconFieldModule } from 'primeng/iconfield';
import { InputIconModule } from 'primeng/inputicon';
import { InputTextModule } from 'primeng/inputtext';

@Component({
  selector: 'app-destination-manager',
  imports: [
    CommonModule,
    RouterModule,
    TableModule,
    ButtonModule,
    TagModule,
    TooltipModule,
    ConfirmDialogModule,
    IconFieldModule,
    InputIconModule,
    InputTextModule
  ],
  providers: [ConfirmationService],
  templateUrl: './destination-manager.component.html',
  styleUrl: './destination-manager.component.css',
})
export class DestinationManager implements OnInit {
  
  private destinationService = inject(DestinationService);
  private toasterService = inject(ToasterService);
  private confirmationService = inject(ConfirmationService);

  destinations: DestinationSummaryDto[] = [];
  loading: boolean = true;

  ngOnInit(): void {
    this.loadDestinations();
  }

  loadDestinations() {
    this.loading = true;
    this.destinationService.getAll().subscribe({
      next: (response) => {
        if (response.isSuccess === ApiResponseCode.Success && response.result) {
          this.destinations = response.result;
        }
        this.loading = false;
      },
      error: (err) => {
        this.toasterService.error(err.error?.message ?? 'Error al cargar destinos')
        this.loading = false;
      }
    });
  }

  deleteDestination(summary: DestinationSummaryDto) {
    this.confirmationService.confirm({
      message: `¿Estás seguro de eliminar ${summary.name}?`,
      header: 'Confirmar Eliminación',
      icon: 'pi pi-exclamation-triangle',
      acceptButtonStyleClass: 'p-button-danger',
      rejectButtonStyleClass: 'p-button-text',
      accept: () => {
        this.destinationService.delete(summary.destinationId).subscribe({
          next: (resp) => {
            if (resp.isSuccess === ApiResponseCode.Success) {
              this.toasterService.success('Destino eliminado', 'Eliminado');
              this.loadDestinations();
            } else {
              this.toasterService.error(resp.message, 'Error al eliminar');
            }
          },
          error: () => this.toasterService.error('No se pudo eliminar el destino', 'Error al eliminar')
        });
      }
    });
  }
}
