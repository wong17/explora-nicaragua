import { Component, signal } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';
import { RouterLink } from '@angular/router';
import { InputTextModule } from 'primeng/inputtext';
import { ButtonModule } from 'primeng/button';

@Component({
  selector: 'app-hero',
  imports: [CommonModule, FormsModule, RouterLink, InputTextModule, ButtonModule],
  templateUrl: './hero.component.html',
  styleUrl: './hero.component.css',
})
export class Hero {

  searchQuery = signal('');

  onSearch() {
    console.log('Buscando:', this.searchQuery());
  }

}
