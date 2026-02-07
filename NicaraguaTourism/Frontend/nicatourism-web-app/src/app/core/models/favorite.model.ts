import { DestinationSummaryDto } from "../core.index";

// Para listar favoritos
export interface FavoriteDto {
    favoriteId: number;
    addedAt: string; // string ISO
    destination?: DestinationSummaryDto | null;
}

// Para agregar o quitar favoritos
export interface FavoriteInteractionDto {
    userId: number;
    destinationId: number;
}