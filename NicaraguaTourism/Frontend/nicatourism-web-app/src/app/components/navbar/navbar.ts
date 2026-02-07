import { Component, signal } from '@angular/core';
import { fromEvent, Subscription } from 'rxjs';
import { RouterLink, RouterLinkActive } from '@angular/router';

@Component({
  selector: 'app-navbar',
  imports: [RouterLink, RouterLinkActive],
  templateUrl: './navbar.html',
  styleUrl: './navbar.css',
})
export class Navbar {

  // Signals para el estado visual
  isScrolled = signal(false);
  isMenuOpen = signal(false);

  private scrollSub?: Subscription;

  ngOnInit() {
    this.scrollSub = fromEvent(window, 'scroll').subscribe(() => {
      this.isScrolled.set(window.scrollY > 20);
    });
  }

  ngOnDestroy() {
    this.scrollSub?.unsubscribe();
  }

  closeMenu() {
    this.isMenuOpen.set(false);
  }

  toggleMenu() {
    this.isMenuOpen.update(v => !v);
  }

}
