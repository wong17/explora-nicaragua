import { DestinationSummaryDto } from './destination.model.js';

/**
 * DTO para agregar/eliminar favoritos.
 */
export class FavoriteInteractionDto {
    constructor(userId = 0, destinationId = 0) {
        this.userId = userId;
        this.destinationId = destinationId;
    }
}

/**
 * DTO de lectura de favoritos.
 */
export class FavoriteDto {
    constructor(data = {}) {
        this.favoriteId = data.favoriteId || 0;
        this.addedAt = data.addedAt ? new Date(data.addedAt) : null;

        // Mapeamos el objeto anidado si existe
        this.destination = data.destination
            ? new DestinationSummaryDto(data.destination)
            : null;
    }
}