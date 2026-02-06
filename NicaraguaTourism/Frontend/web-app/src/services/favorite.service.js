import { HttpClient } from './base/http-client.js';

class FavoriteService extends HttpClient {
    constructor() {
        super('favorites');
    }

    /**
     * Agrega a favoritos (POST api/favorites/add)
     * @param {object} interactionDto - { userId, destinationId }
     */
    async add(interactionDto) {
        return await this.post('add', interactionDto);
    }

    /**
     * Elimina de favoritos (POST api/favorites/remove)
     * @param {object} interactionDto - { userId, destinationId }
     */
    async remove(interactionDto) {
        return await this.post('remove', interactionDto);
    }

    /**
     * Verifica si ya es favorito (POST api/favorites/check_status)
     * @param {object} interactionDto - { userId, destinationId }
     */
    async checkIsFavorite(interactionDto) {
        return await this.post('check_status', interactionDto);
    }

    /**
     * Obtiene los favoritos de un usuario (GET api/favorites/get_by_user/{userId})
     * @param {number} userId 
     */
    async getByUser(userId) {
        return await this.get(`get_by_user/${userId}`);
    }
}

export const favoriteService = new FavoriteService();