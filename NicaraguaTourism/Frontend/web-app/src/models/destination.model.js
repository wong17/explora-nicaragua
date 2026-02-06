/**
 * DTO para representar una imagen asociada a un destino.
 */
export class DestinationImageDto {
    constructor(imageUrl = '', isCover = false, altText = null) {
        this.imageUrl = imageUrl;
        this.isCover = isCover;
        this.altText = altText;
    }
}

/**
 * DTO para representar una actividad asociada a un destino.
 */
export class ActivityDto {
    constructor(activityName = '', iconName = null) {
        this.activityName = activityName;
        this.iconName = iconName;
    }
}

/**
 * DTO para registrar un destino.
 */
export class DestinationRegisterDto {
    constructor() {
        this.name = '';
        this.shortDescription = '';
        this.longDescription = null;
        this.location = null;
        this.latitude = null; // number
        this.longitude = null; // number
        this.averageWeather = null;
        this.accessDifficulty = null;
        this.images = [];     // Array de DestinationImageDto
        this.activities = []; // Array de ActivityDto
    }
}

/**
 * DTO para editar un destino.
 */
export class DestinationUpdateDto {
    constructor() {
        this.destinationId = 0;
        this.name = '';
        this.shortDescription = '';
        this.longDescription = null;
        this.location = null;
        this.latitude = null;
        this.longitude = null;
        this.averageWeather = null;
        this.accessDifficulty = null;
        this.images = [];
        this.activities = [];
    }
}

/**
 * DTO para lectura completa de un destino.
 */
export class DestinationDto {
    constructor(data = {}) {
        this.destinationId = data.destinationId || 0;
        this.name = data.name || '';
        this.shortDescription = data.shortDescription || '';
        this.longDescription = data.longDescription || null;
        this.location = data.location || null;
        this.latitude = data.latitude || null;
        this.longitude = data.longitude || null;
        this.averageWeather = data.averageWeather || null;
        this.accessDifficulty = data.accessDifficulty || null;

        this.images = Array.isArray(data.images)
            ? data.images.map(img => new DestinationImageDto(img.imageUrl, img.isCover, img.altText))
            : [];

        this.activities = Array.isArray(data.activities)
            ? data.activities.map(act => new ActivityDto(act.activityName, act.iconName))
            : [];
    }
}

/**
 * DTO ligero para listas o tarjetas.
 */
export class DestinationSummaryDto {
    constructor(data = {}) {
        this.destinationId = data.destinationId || 0;
        this.name = data.name || '';
        this.shortDescription = data.shortDescription || '';
        this.location = data.location || null;
        this.averageWeather = data.averageWeather || null;
        this.accessDifficulty = data.accessDifficulty || null;
        this.coverImage = data.coverImage || null;
    }
}