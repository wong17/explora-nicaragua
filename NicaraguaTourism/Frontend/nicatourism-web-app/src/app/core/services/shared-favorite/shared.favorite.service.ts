import { Injectable, signal } from '@angular/core';

@Injectable({
  providedIn: 'root',
})
export class SharedFavoriteService {
  public sharedFavoriteIds = signal<Set<number>>(new Set<number>());
}
