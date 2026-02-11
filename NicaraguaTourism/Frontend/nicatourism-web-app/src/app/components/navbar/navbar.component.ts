import { Component, inject, signal } from '@angular/core';
import { fromEvent, Subscription } from 'rxjs';
import { RouterLink, RouterLinkActive } from '@angular/router';
import { AuthService, ToasterService, UiService } from '../../core/core.index';
import { FavoritesDialog } from "../favorites-dialog/favorites-dialog.component";

@Component({
  selector: 'app-navbar',
  imports: [RouterLink, RouterLinkActive, FavoritesDialog],
  templateUrl: './navbar.component.html',
  styleUrl: './navbar.component.css',
})
export class Navbar {

  // Signals para el estado visual
  isScrolled = signal(false);
  isMenuOpen = signal(false);

  showFavorites = signal(false);

  private uiService = inject(UiService);
  public authService = inject(AuthService);
  private toaster = inject(ToasterService);

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

  openFavorites() {
    this.showFavorites.set(true);
    this.closeMenu();
  }

  handleLogout() {
    this.authService.logout();
    this.toaster.success('Sesión cerrada exitosamente', 'Hasta pronto');
    this.isMenuOpen.set(false);
  }
}
