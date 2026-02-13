import { Component, inject, signal } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';
import { Router, RouterLink } from '@angular/router';
import { InputTextModule } from 'primeng/inputtext';
import { ButtonModule } from 'primeng/button';

@Component({
  selector: 'app-hero',
  imports: [CommonModule, FormsModule, InputTextModule, ButtonModule, RouterLink],
  templateUrl: './hero.component.html',
  styleUrl: './hero.component.css',
})
export class Hero {

  private router = inject(Router);
  searchQuery = signal('');

  onSearch() {
    const query = this.searchQuery().trim();
    if (query) {
      // Si el usuario escribió algo, lo enviamos con el parámetro de búsqueda
      this.router.navigate(['/destinos'], { queryParams: { search: query } });
    } else {
      // Si está vacío, simplemente lo mandamos a ver todos los destinos
      this.router.navigate(['/destinos']);
    }
  }

}
