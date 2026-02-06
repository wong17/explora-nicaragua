using NicaraguaTourism.Common.Runtime;
using NicaraguaTourism.Dal.Core;
using System.Net;
using System.Text.Json;

namespace NicaraguaTourism.Dal.Repository.Implements.Base
{
    /// <summary>
    /// Clase base para todos los repositorios. Maneja la inyección del conector y la lógica común de serialización y mapeo de respuestas.
    /// </summary>
    public abstract class RepositoryBase
    {
        protected readonly ISqlConnector _connector;
        protected readonly JsonSerializerOptions _jsonOptions;

        protected RepositoryBase(ISqlConnector connector)
        {
            _connector = connector;
            _jsonOptions = new JsonSerializerOptions { PropertyNameCaseInsensitive = true };
        }

        /// <summary>
        /// Clase interna para deserializar la respuesta estándar de los SPs.
        /// </summary>
        protected class SpResponse
        {
            public int IsSuccess { get; set; }
            public string? Message { get; set; }
            public int Result { get; set; }
            public Guid SessionIdResult { get; set; } // Para validar token
        }

        /// <summary>
        /// 
        /// </summary>
        /// <typeparam name="T"></typeparam>
        /// <param name="spResponse"></param>
        /// <param name="successCode"></param>
        /// <returns></returns>
        protected static ApiResponse<T> MapToApiResponse<T>(SpResponse? spResponse, HttpStatusCode successCode = HttpStatusCode.OK)
        {
            // 1. Validar si Dapper devolvió algo
            if (spResponse is null)
            {
                return CreateDbErrorApiResponse<T>("El procedimiento almacenado no devolvió ninguna respuesta.");
            }

            // 2. Construir la respuesta base
            var apiResponse = new ApiResponse<T>
            {
                IsSuccess = (ApiResponseCode)spResponse.IsSuccess,
                Message = spResponse.Message,
                StatusCode = (ApiResponseCode)spResponse.IsSuccess switch
                {
                    ApiResponseCode.Success => successCode,
                    ApiResponseCode.ValidationError => HttpStatusCode.BadRequest,
                    ApiResponseCode.ResourceNotFound => HttpStatusCode.NotFound,
                    _ => HttpStatusCode.InternalServerError
                }
            };

            // 3. Si falló la lógica de negocio en BD, retornamos el error
            if (apiResponse.IsSuccess != ApiResponseCode.Success)
            {
                return apiResponse;
            }

            // 4. Mapeo del resultado (Result -> T)
            if (typeof(T) == typeof(bool))
            {
                apiResponse.Result = (T)(object)true;
            }
            else if (typeof(T) == typeof(int))
            {
                apiResponse.Result = (T)(object)spResponse.Result;
            }
            else if (typeof(T) == typeof(Guid))
            {
                apiResponse.Result = (T)(object)spResponse.SessionIdResult;
            }
            // Si T es el propio SpResponse (casos raros), lo devolvemos entero
            else if (typeof(T) == typeof(SpResponse))
            {
                apiResponse.Result = (T)(object)spResponse;
            }

            return apiResponse;
        }

        /// <summary>
        /// 
        /// </summary>
        /// <typeparam name="T"></typeparam>
        /// <param name="jsonResult"></param>
        /// <param name="successCode"></param>
        /// <returns></returns>
        protected ApiResponse<T> MapJsonToApiResponse<T>(string? jsonResult, string notFoundMessage = "Recurso no encontrado.", HttpStatusCode successCode = HttpStatusCode.OK)
        {
            if (string.IsNullOrWhiteSpace(jsonResult))
            {
                // Si tenia que devolver una colección paginada, devolvemos una vacía
                if (typeof(T).IsGenericType && typeof(T).GetGenericTypeDefinition().Name.StartsWith("PaginatedResult"))
                {
                    return CreateSuccessApiResponse(JsonSerializer.Deserialize<T>("{}", _jsonOptions), "Sin resultados", successCode);
                }

                // Si tenia que devolver un objeto simple, devolvemos NotFound
                return CreateNotFoundApiResponse<T>(notFoundMessage);
            }

            // Validar si la respuesta contiene un error de validación en caso de que el sp pueda devolver mensajes de error
            if (jsonResult.Contains("\"IsSuccess\":1") || jsonResult.Contains("\"IsSuccess\":2"))
            {
                var errorData = JsonSerializer.Deserialize<SpResponse>(jsonResult, _jsonOptions);
                if (errorData is not null && errorData.IsSuccess != 0)
                {
                    return CreateValidationApiResponse<T>(errorData.Message ?? "Error de validación.");
                }
            }

            // Mapear el JSON al tipo T
            var result = JsonSerializer.Deserialize<T>(jsonResult, _jsonOptions);
            if (result is null)
            {
                return CreateNotFoundApiResponse<T>(notFoundMessage);
            }

            return CreateSuccessApiResponse(result, "Respuesta exitosa", successCode);
        }

        /// <summary>
        /// 
        /// </summary>
        /// <typeparam name="T"></typeparam>
        /// <param name="result"></param>
        /// <param name="message"></param>
        /// <param name="successCode"></param>
        /// <returns></returns>
        protected static ApiResponse<T> CreateSuccessApiResponse<T>(T? result, string message = "Respuesta exitosa", HttpStatusCode successCode = HttpStatusCode.OK)
        {
            return new ApiResponse<T>
            {
                IsSuccess = ApiResponseCode.Success,
                StatusCode = successCode,
                Message = message,
                Result = result
            };
        }

        /// <summary>
        /// 
        /// </summary>
        /// <typeparam name="T"></typeparam>
        /// <param name="message"></param>
        /// <returns></returns>
        protected static ApiResponse<T> CreateNotFoundApiResponse<T>(string message = "Recurso no encontrado.")
        {
            return new ApiResponse<T>
            {
                IsSuccess = ApiResponseCode.ResourceNotFound,
                StatusCode = HttpStatusCode.NotFound,
                Message = message,
                Result = default
            };
        }

        /// <summary>
        /// 
        /// </summary>
        /// <typeparam name="T"></typeparam>
        /// <param name="message"></param>
        /// <returns></returns>
        protected static ApiResponse<T> CreateDbErrorApiResponse<T>(string message)
        {
            return new ApiResponse<T>
            {
                IsSuccess = ApiResponseCode.DatabaseError,
                StatusCode = HttpStatusCode.InternalServerError,
                Message = message,
                Result = default
            };
        }

        /// <summary>
        /// Crea un ApiResponse<T> de error genérico con código y estatus personalizados.
        /// </summary>
        /// <typeparam name="T"></typeparam>
        /// <param name="message"></param>
        /// <param name="code"></param>
        /// <param name="statusCode"></param>
        /// <returns></returns>
        protected static ApiResponse<T> CreateErrorApiResponse<T>(string? message, ApiResponseCode code, HttpStatusCode statusCode)
        {
            return new ApiResponse<T>
            {
                IsSuccess = code,
                Message = message,
                StatusCode = statusCode,
                Result = default
            };
        }

        /// <summary>
        /// 
        /// </summary>
        /// <typeparam name="T"></typeparam>
        /// <param name="message"></param>
        /// <returns></returns>
        protected static ApiResponse<T> CreateValidationApiResponse<T>(string message)
        {
            return new ApiResponse<T>
            {
                IsSuccess = ApiResponseCode.ValidationError,
                StatusCode = HttpStatusCode.BadRequest,
                Message = message,
                Result = default
            };
        }
    }
}
