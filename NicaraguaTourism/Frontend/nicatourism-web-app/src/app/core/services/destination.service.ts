import { HttpClient } from '@angular/common/http';
import { inject, Injectable } from '@angular/core';
import { Observable } from 'rxjs';
import { ApiResponse, DestinationDto, DestinationRegisterDto, DestinationSummaryDto, DestinationUpdateDto } from '../core.index';
import { environment } from '../../../environments/environment';

@Injectable({
  providedIn: 'root',
})
export class DestinationService {
  
  private http = inject(HttpClient);
  private apiUrl = environment.apiUrl;

  constructor() { }

  // POST: api/destinations/register?adminId=X
  create(destinationData: DestinationRegisterDto, imageFiles: File[], adminId: number): Observable<ApiResponse<number>> {
    const formData = this.createFormData(destinationData, imageFiles);
    return this.http.post<ApiResponse<number>>(`${this.apiUrl}/register?adminId=${adminId}`, formData);
  }

  // PUT: api/destinations/update?adminId=X
  update(destinationData: DestinationUpdateDto, imageFiles: File[], adminId: number): Observable<ApiResponse<boolean>> {
    const formData = this.createFormData(destinationData, imageFiles);
    return this.http.put<ApiResponse<boolean>>(`${this.apiUrl}/update?adminId=${adminId}`, formData);
  }

  // DELETE: api/destinations/delete/{id}
  delete(id: number): Observable<ApiResponse<boolean>> {
    return this.http.delete<ApiResponse<boolean>>(`${this.apiUrl}/delete/${id}`);
  }

  // GET: api/destinations/get_all
  getAll(): Observable<ApiResponse<DestinationSummaryDto[]>> {
    return this.http.get<ApiResponse<DestinationSummaryDto[]>>(`${this.apiUrl}/get_all`);
  }

  // GET: api/destinations/get_by_id/{id}
  getById(id: number): Observable<ApiResponse<DestinationDto>> {
    return this.http.get<ApiResponse<DestinationDto>>(`${this.apiUrl}/get_by_id/${id}`);
  }

  // Para construir el FormData
  private createFormData(data: any, files: File[]): FormData {
    const formData = new FormData();

    // Las imageness van como binarios aparte
    const cleanData = { ...data, images: [] };
    formData.append('destinationJson', JSON.stringify(cleanData));

    if (files && files.length > 0) {
      files.forEach(file => {
        formData.append('images', file);
      });
    }

    return formData;
  }
}
