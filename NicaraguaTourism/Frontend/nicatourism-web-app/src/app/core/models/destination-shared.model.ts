export interface ActivityInsertDto {
    activityName: string;
    iconName?: string | null;
}

export interface DestinationImageInsertDto {
    imageUrl: string;
    isCover?: boolean | null;
    altText?: string | null;
}