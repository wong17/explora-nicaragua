import { ActivityInsertDto, DestinationImageInsertDto } from "../core.index";

// Para listar (GET /get_all) - Versión resumida
export interface DestinationSummaryDto {
    destinationId: number;
    name: string;
    shortDescription: string;
    location?: string | null;
    averageWeather?: string | null;
    accessDifficulty?: string | null;
    coverImage?: string | null;
}

// Para detalles completos (GET /get_by_id/{id})
export interface DestinationDto {
    destinationId: number;
    name: string;
    shortDescription: string;
    longDescription?: string | null;
    location?: string | null;
    latitude?: number | null;
    longitude?: number | null;
    averageWeather?: string | null;
    accessDifficulty?: string | null;
    images: DestinationImageInsertDto[];
    activities: ActivityInsertDto[];
}

// Para registrar (POST) - Images va vacío al enviarse porque se usa FormData
export interface DestinationRegisterDto {
    name: string;
    shortDescription: string;
    longDescription?: string | null;
    location?: string | null;
    latitude?: number | null;
    longitude?: number | null;
    averageWeather?: string | null;
    accessDifficulty?: string | null;
    images: DestinationImageInsertDto[];
    activities: ActivityInsertDto[];
}

// Para actualizar (PUT)
export interface DestinationUpdateDto {
    destinationId: number;
    name: string;
    shortDescription: string;
    longDescription?: string | null;
    location?: string | null;
    latitude?: number | null;
    longitude?: number | null;
    averageWeather?: string | null;
    accessDifficulty?: string | null;
    images: DestinationImageInsertDto[];
    activities: ActivityInsertDto[];
}