import { Component, inject, signal } from '@angular/core';
import { fromEvent, Subscription } from 'rxjs';
import { RouterLink, RouterLinkActive } from '@angular/router';
import { UiService } from '../../core/core.index';

@Component({
  selector: 'app-navbar',
  imports: [RouterLink, RouterLinkActive],
  templateUrl: './navbar.component.html',
  styleUrl: './navbar.component.css',
})
export class Navbar {

  // Signals para el estado visual
  isScrolled = signal(false);
  isMenuOpen = signal(false);

  private uiService = inject(UiService);

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

  openLogin() {
    this.uiService.openLoginModal();
    this.closeMenu();
  }

}
