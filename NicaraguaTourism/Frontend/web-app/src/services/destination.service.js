import { HttpClient } from './base/http-client.js';

class DestinationService extends HttpClient {
    constructor() {
        super('destinations');
    }

    /**
     * Crea un destino con imágenes (POST api/destinations/register)
     * @param {object} destinationData - Objeto con los datos (name, description, etc.)
     * @param {FileList|Array} imageFiles - Lista de archivos seleccionados por el usuario
     * @param {number} adminId - ID del usuario
     */
    async create(destinationData, imageFiles, adminId) {
        const formData = this._createFormData(destinationData, imageFiles);
        return await this.post(`register?adminId=${adminId}`, formData);
    }

    /**
     * Actualiza un destino con imágenes (PUT api/destinations/update)
     * @param {object} destinationData - Debe incluir 'destinationId'
     * @param {FileList|Array} imageFiles - Nuevos archivos (si hay)
     * @param {number} adminId - ID del usuario
     */
    async update(destinationData, imageFiles, adminId) {
        const formData = this._createFormData(destinationData, imageFiles);
        return await this.put(`update?adminId=${adminId}`, formData);
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

    /**
     * Convierte el objeto y los archivos a FormData
     * para enviarlos al Backend que espera 'multipart/form-data'.
     */
    _createFormData(dataObj, files) {
        const formData = new FormData();

        // Agrega el JSON como string
        const cleanData = { ...dataObj, images: [] };
        formData.append('destinationJson', JSON.stringify(cleanData));

        // Agrega los archivos
        if (files && files.length > 0) {
            for (let i = 0; i < files.length; i++) {
                formData.append('images', files[i]);
            }
        }

        return formData;
    }
}

export const destinationService = new DestinationService();