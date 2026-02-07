import { computed, Injectable, signal } from '@angular/core';
import { UserDto } from '../../core.index';

@Injectable({
  providedIn: 'root',
})
export class AuthService {
  
  public currentUser = signal<UserDto | null>(null);
  public isLoggedIn = computed(() => this.currentUser() !== null);

  constructor() {
    this.loadSession();
  }

  logout() {
    this.currentUser.set(null);
    localStorage.removeItem('explora_user');
  }

  setCurrentUser(user: UserDto) {
    this.currentUser.set(user); // Actualizamos la signal
    localStorage.setItem('explora_user', JSON.stringify(user)); // Guardamos en navegador
  }

  private loadSession() {
    const savedUser = localStorage.getItem('explora_user');
    if (!savedUser) {
      return;
    }

    try {
      this.currentUser.set(JSON.parse(savedUser));
    } catch {
      this.logout();
    }
  }

}
