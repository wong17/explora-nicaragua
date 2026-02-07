import { HttpClient } from '@angular/common/http';
import { inject, Injectable } from '@angular/core';
import { ApiResponse, UserDto, UserLoginDto, UserRegisterDto, UserUpdateDto } from '../core.index';
import { Observable } from 'rxjs';
import { environment } from '../../../environments/environment';

@Injectable({
  providedIn: 'root',
})
export class UserService {
  
  private http = inject(HttpClient);
  private apiUrl = environment.apiUrl;

  constructor() { }

  // POST: api/users/register
  register(registerDto: UserRegisterDto): Observable<ApiResponse<number>> {
    return this.http.post<ApiResponse<number>>(`${this.apiUrl}/register`, registerDto);
  }

  // POST: api/users/login
  login(loginDto: UserLoginDto): Observable<ApiResponse<number>> {
    return this.http.post<ApiResponse<number>>(`${this.apiUrl}/login`, loginDto);
  }

  // PUT: api/users/update
  update(updateDto: UserUpdateDto): Observable<ApiResponse<boolean>> {
    return this.http.put<ApiResponse<boolean>>(`${this.apiUrl}/update`, updateDto);
  }

  // DELETE: api/users/delete/{id}
  delete(id: number): Observable<ApiResponse<boolean>> {
    return this.http.delete<ApiResponse<boolean>>(`${this.apiUrl}/delete/${id}`);
  }

  // GET: api/users/get_by_id/{id}
  getById(id: number): Observable<ApiResponse<UserDto>> {
    return this.http.get<ApiResponse<UserDto>>(`${this.apiUrl}/get_by_id/${id}`);
  }

  // GET: api/users/get_all
  getAll(): Observable<ApiResponse<UserDto[]>> {
    return this.http.get<ApiResponse<UserDto[]>>(`${this.apiUrl}/get_all`);
  }
}
