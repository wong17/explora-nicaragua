/**
 * Son códigos de respuesta personalizados para la API, que permiten a los clientes entender mejor el resultado de sus solicitudes.
 */
export const ApiResponseCode = {
    Success: 0,
    ValidationError: 1,
    BusinessLogicError: 2,
    DatabaseError: 3,
    UnexpectedError: 4,
    ResourceNotFound: 5
};

/**
 * Es para representar la estructura de la respuesta que el backend envía al frontend.
 */
export class ApiResponse {
    constructor(data = {}) {
        this.isSuccess = data.isSuccess; // ApiResponseCode (int)
        this.message = data.message || '';
        this.statusCode = data.statusCode || 200; // HttpStatusCode (int)
        this.result = data.result || null; // T (puede ser objeto, array o null)
    }

    /**
     * Helper para verificar rápidamente si la operación fue exitosa.
     * @returns {boolean}
     */
    get ok() {
        return this.isSuccess === ApiResponseCode.Success;
    }
}