using Microsoft.AspNetCore.Mvc;
using NicaraguaTourism.Common.Runtime;
using System.Net;

namespace NicaraguaTourism.WebAPI.Controllers.Base
{
    /// <summary>
    /// Controlador base que proporciona un manejador estándar para las respuestas de la BLL (ApiResponse<T>).
    /// </summary>
    [ApiController]
    [Produces("application/json")]
    [ProducesResponseType(typeof(ApiResponse<object>), StatusCodes.Status400BadRequest)] // Validación
    [ProducesResponseType(typeof(ApiResponse<object>), StatusCodes.Status500InternalServerError)] // Crash
    public abstract class ApiControllerBase : ControllerBase
    {
        /// <summary>
        /// Procesa un ApiResponse<T> de la BLL y lo convierte
        /// en el IActionResult apropiado (Ok, NotFound, BadRequest, etc.)
        /// usando el StatusCode contenido en la respuesta.
        /// </summary>
        /// <typeparam name="T">El tipo del 'Result' en la respuesta.</typeparam>
        /// <param name="response">La respuesta de la capa BLL.</param>
        /// <returns>Un IActionResult (ej. OkObjectResult, NotFoundObjectResult, etc.)</returns>
        protected IActionResult HandleApiResponse<T>(ApiResponse<T> response)
        {
            // Simplemente usamos el StatusCode que la BLL ya determinó
            // y pasamos la respuesta completa como cuerpo.
            return StatusCode((int)response.StatusCode, response);
        }

        /// <summary>
        /// Maneja respuestas de creación (201) añadiendo el header Location.
        /// </summary>
        /// <typeparam name="T"></typeparam>
        /// <param name="response"></param>
        /// <param name="routeName"></param>
        /// <param name="routeValues"></param>
        /// <returns></returns>
        protected IActionResult HandleCreatedResponse<T>(ApiResponse<T> response, string routeName, object routeValues)
        {
            if (response.StatusCode == HttpStatusCode.Created && response.IsSuccess == ApiResponseCode.Success)
            {
                // Esto genera el header "Location: /api/products/get_by_id/5"
                return CreatedAtRoute(routeName, routeValues, response);
            }

            // Si la BLL falló (ej. validación), delegamos al handler normal
            return HandleApiResponse(response);
        }

        /// <summary>
        /// 
        /// </summary>
        /// <returns></returns>
        public static IActionResult ProcessValidationFailure(ActionContext context)
        {
            var errors = context.ModelState.Values
                .SelectMany(v => v.Errors)
                .Select(e => e.ErrorMessage)
                .ToList();

            var response = new ApiResponse<object>
            {
                IsSuccess = ApiResponseCode.ValidationError,
                StatusCode = HttpStatusCode.BadRequest,
                Message = "Errores de validación en la solicitud.",
                Result = errors
            };

            return new BadRequestObjectResult(response);
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
        /// Crea un ApiResponse<T> para un error de validación (400 Bad Request).
        /// </summary>
        /// <typeparam name="T"></typeparam>
        /// <param name="message"></param>
        /// <returns></returns>
        protected ApiResponse<T> CreateValidationApiResponse<T>(string message)
        {
            return new ApiResponse<T>
            {
                IsSuccess = ApiResponseCode.ValidationError,
                StatusCode = HttpStatusCode.BadRequest,
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

        /// <summary>
        /// Crea un ApiResponse<T> para un error de autenticación (401 Unauthorized).
        /// </summary>
        /// <typeparam name="T"></typeparam>
        /// <param name="message"></param>
        /// <returns></returns>
        protected ApiResponse<T> CreateUnauthorizedApiResponse<T>(string message = "Token de usuario no válido o expirado.")
        {
            return new ApiResponse<T>
            {
                IsSuccess = ApiResponseCode.ValidationError,
                StatusCode = HttpStatusCode.Unauthorized,
                Message = message
            };
        }

        /// <summary>
        /// Crea un ApiResponse<T> de error genérico.
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
                StatusCode = statusCode
            };
        }
    }
}
