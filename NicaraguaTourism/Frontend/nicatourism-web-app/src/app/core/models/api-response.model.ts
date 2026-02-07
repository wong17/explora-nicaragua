export enum ApiResponseCode {
    Success = 0,
    ValidationError = 1,
    ResourceNotFound = 2,
    DatabaseError = 3,
    TooManyRequests = 4,
    UnexpectedError = 5
}

export interface ApiResponse<T> {
    isSuccess: ApiResponseCode;
    statusCode: number;
    message: string;
    result: T;
}