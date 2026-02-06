import { HttpClient } from './base/http-client.js';

class DestinationService extends HttpClient {
    constructor() {
        super('destinations');
    }

    /**
     * Crea un destino (POST api/destinations/register?adminId=X)
     * @param {object} createDto - DestinationRegisterDto
     * @param {number} adminId - ID del usuario que crea el registro
     */
    async create(createDto, adminId) {
        return await this.post(`register?adminId=${adminId}`, createDto);
    }

    /**
     * Actualiza un destino (PUT api/destinations/update?adminId=X)
     * @param {object} updateDto - DestinationUpdateDto
     * @param {number} adminId - ID del usuario que edita
     */
    async update(updateDto, adminId) {
        return await this.put(`update?adminId=${adminId}`, updateDto);
    }

    /**
     * Elimina un destino (DELETE api/destinations/delete/{id})
     * @param {number} id 
     */
    async delete(id) {
        return await this.delete(`delete/${id}`);
    }

    /**
     * Obtiene todos los destinos (GET api/destinations/get_all)
     */
    async getAll() {
        return await this.get('get_all');
    }

    /**
     * Obtiene un destino por ID (GET api/destinations/get_by_id/{id})
     * @param {number} id 
     */
    async getById(id) {
        return await this.get(`get_by_id/${id}`);
    }
}

export const destinationService = new DestinationService();