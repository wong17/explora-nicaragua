using NicaraguaTourism.Common.Runtime;
using System.Net;

namespace NicaraguaTourism.Bll.Implements.Base
{
    /// <summary>
    /// Clase base para la Lógica de Negocio. Provee métodos para simplificar la creación y mapeo de respuestas de la BLL.
    /// </summary>
    public abstract class BllBase
    {
        /// <summary>
        /// Traduce una respuesta del DAL (ApiResponse<TModel>) a una respuesta de BLL (ApiResponse<TDto>).
        /// Si el DAL falló, propaga el error. Si tuvo éxito, aplica la función de mapeo.
        /// </summary>
        /// <typeparam name="TModel"></typeparam>
        /// <typeparam name="TDto"></typeparam>
        /// <param name="dalResponse"></param>
        /// <param name="mapFunction"></param>
        /// <returns></returns>
        protected static ApiResponse<TDto> MapApiResponse<TModel, TDto>(ApiResponse<TModel> dalResponse, Func<TModel, TDto> mapFunction)
        {
            // 1. Si el DAL falló, propagamos el error
            if (dalResponse.IsSuccess != ApiResponseCode.Success)
            {
                return new ApiResponse<TDto>
                {
                    IsSuccess = dalResponse.IsSuccess,
                    Message = dalResponse.Message,
                    StatusCode = dalResponse.StatusCode,
                    Result = default
                };
            }

            // 2. Si el DAL tuvo éxito, mapeamos el resultado

            // Verificamos si el Result viene nulo, aunque el código sea Success.
            if (dalResponse.Result is null)
            {
                return new ApiResponse<TDto>
                {
                    IsSuccess = ApiResponseCode.Success,
                    StatusCode = dalResponse.StatusCode,
                    Message = dalResponse.Message,
                    Result = default
                };
            }

            var bllResult = mapFunction(dalResponse.Result!);

            // 3. Retornamos la respuesta BLL exitosa
            return new ApiResponse<TDto>
            {
                IsSuccess = ApiResponseCode.Success,
                StatusCode = dalResponse.StatusCode,
                Message = dalResponse.Message,
                Result = bllResult
            };
        }

        /// <summary>
        /// Crea un ApiResponse<T> exitoso.
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
        /// Crea un ApiResponse<T> para un error de validación de negocio (400 Bad Request).
        /// </summary>
        /// <typeparam name="T"></typeparam>
        /// <param name="message"></param>
        /// <param name="successCode"></param>
        /// <returns></returns>
        protected ApiResponse<T> CreateValidationApiResponse<T>(string message, HttpStatusCode successCode = HttpStatusCode.BadRequest)
        {
            return new ApiResponse<T>
            {
                IsSuccess = ApiResponseCode.ValidationError,
                StatusCode = successCode,
                Message = message
            };
        }

        /// <summary>
        /// Crea un ApiResponse<T> para un error interno o de base de datos (500 Internal Server Error).
        /// </summary>
        /// <typeparam name="T"></typeparam>
        /// <param name="message"></param>
        /// <returns></returns>
        protected ApiResponse<T> CreateDbErrorApiResponse<T>(string message)
        {
            return new ApiResponse<T>
            {
                IsSuccess = ApiResponseCode.DatabaseError,
                StatusCode = HttpStatusCode.InternalServerError,
                Message = message
            };
        }

        /// <summary>
        /// Crea un ApiResponse<T> para un error de "No Encontrado" (404 Not Found).
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
                Message = message
            };
        }
    }
}
