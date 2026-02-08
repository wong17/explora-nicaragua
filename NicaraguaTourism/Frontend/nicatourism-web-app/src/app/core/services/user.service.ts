import { HttpClient, HttpParams } from '@angular/common/http';
import { inject, Injectable } from '@angular/core';
import { ApiResponse, UserDto, UserLoginDto, UserRegisterDto, UserUpdateDto } from '../core.index';
import { Observable } from 'rxjs';
import { environment } from '../../../environments/environment';
import { PaginatedResult } from '../models/paginated-result';

@Injectable({
  providedIn: 'root',
})
export class UserService {
  
  private http = inject(HttpClient);
  private apiUrl = environment.apiUrl;

  constructor() { }

  // POST: api/users/register
  register(registerDto: UserRegisterDto): Observable<ApiResponse<number>> {
    return this.http.post<ApiResponse<number>>(`${this.apiUrl}/users/register`, registerDto);
  }

  // POST: api/users/login
  login(loginDto: UserLoginDto): Observable<ApiResponse<number>> {
    return this.http.post<ApiResponse<number>>(`${this.apiUrl}/users/login`, loginDto);
  }

  // PUT: api/users/update
  update(updateDto: UserUpdateDto): Observable<ApiResponse<boolean>> {
    return this.http.put<ApiResponse<boolean>>(`${this.apiUrl}/users/update`, updateDto);
  }

  // DELETE: api/users/delete/{id}
  delete(id: number): Observable<ApiResponse<boolean>> {
    return this.http.delete<ApiResponse<boolean>>(`${this.apiUrl}/users/delete/${id}`);
  }

  // GET: api/users/get_by_id/{id}
  getById(id: number): Observable<ApiResponse<UserDto>> {
    return this.http.get<ApiResponse<UserDto>>(`${this.apiUrl}/users/get_by_id/${id}`);
  }

  // GET: api/users/get_paginated
  getAll(page?: number, rows?: number): Observable<ApiResponse<PaginatedResult<UserDto>>> {
    let params = new HttpParams()
      .set('page', page ? page.toString() : '1')
      .set('rows', rows ? rows.toString() : '50');
    return this.http.get<ApiResponse<PaginatedResult<UserDto>>>(`${this.apiUrl}/users/get_paginated`, { params });
  }
}
