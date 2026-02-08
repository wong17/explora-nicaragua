export interface PaginatedResult<T> {
    totalRecords: number;
    data: T[];
}