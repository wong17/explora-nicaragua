import { API_BASE_URL } from '../../config/api.config.js';
import { ApiResponse, ApiResponseCode } from '../../models/api-response.model.js';

export class HttpClient {
    /**
     * @param {string} endpoint - El prefijo del controlador
     */
    constructor(endpoint) {
        this.baseUrl = `${API_BASE_URL}/${endpoint}`;
    }

    async get(path = '') {
        return this._request(path, 'GET');
    }

    async post(path = '', body) {
        return this._request(path, 'POST', body);
    }

    async put(path = '', body) {
        return this._request(path, 'PUT', body);
    }

    async delete(path = '') {
        return this._request(path, 'DELETE');
    }

    /**
     * Método interno genérico para fetch.
     * @returns {Promise<ApiResponse>} Siempre devuelve un ApiResponse, incluso en error.
     */
    async _request(path, method, body = null) {
        const url = path ? `${this.baseUrl}/${path}` : this.baseUrl;

        const config = {
            method: method,
            headers: {
                'Content-Type': 'application/json'
            }
        };

        if (body) {
            config.body = JSON.stringify(body);
        }

        try {
            const response = await fetch(url, config);
            // Intentamos parsear el JSON que devuelve la API
            const data = await response.json();
            // Devolvemos la instancia de ApiResponse con los datos del backend
            return new ApiResponse(data);

        } catch (error) {
            console.error(`Error HTTP (${method} ${url}):`, error);
            // Si falla la red o el JSON está malformado, devolvemos un error genérico
            // manteniendo la estructura de ApiResponse para no romper el frontend.
            return new ApiResponse({
                isSuccess: ApiResponseCode.UnexpectedError,
                message: 'No se pudo conectar con el servidor. Verifique su conexión.',
                statusCode: 0,
                result: null
            });
        }
    }
}