import { HttpClient } from '@angular/common/http';
import { inject, Injectable } from '@angular/core';
import { environment } from '../../../environments/environment';
import { ApiResponse, FavoriteDto, FavoriteInteractionDto } from '../core.index';
import { Observable } from 'rxjs';

@Injectable({
  providedIn: 'root',
})
export class FavoriteService {
  
  private http = inject(HttpClient);
  private apiUrl = environment.apiUrl;

  constructor() { }

  // POST: api/favorites/add
  add(interactionDto: FavoriteInteractionDto): Observable<ApiResponse<boolean>> {
    return this.http.post<ApiResponse<boolean>>(`${this.apiUrl}/favorites/add`, interactionDto);
  }

  // POST: api/favorites/remove
  remove(interactionDto: FavoriteInteractionDto): Observable<ApiResponse<boolean>> {
    return this.http.post<ApiResponse<boolean>>(`${this.apiUrl}/favorites/remove`, interactionDto);
  }

  // GET: api/favorites/get_by_user/{userId}
  getByUser(userId: number): Observable<ApiResponse<FavoriteDto[]>> {
    return this.http.get<ApiResponse<FavoriteDto[]>>(`${this.apiUrl}/favorites/get_by_user/${userId}`);
  }

  // POST: api/favorites/check_status
  checkIsFavorite(interactionDto: FavoriteInteractionDto): Observable<ApiResponse<boolean>> {
    return this.http.post<ApiResponse<boolean>>(`${this.apiUrl}/favorites/check_status`, interactionDto);
  }
}
