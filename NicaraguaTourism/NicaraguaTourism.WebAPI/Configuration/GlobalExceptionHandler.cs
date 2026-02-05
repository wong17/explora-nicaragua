using Microsoft.AspNetCore.Diagnostics;
using Microsoft.Data.SqlClient;
using NicaraguaTourism.Common.Runtime;
using System.Net;

namespace NicaraguaTourism.WebAPI.Configuration
{
    public sealed class GlobalExceptionHandler(ILogger<GlobalExceptionHandler> logger, IWebHostEnvironment env) : IExceptionHandler
    {
        public async ValueTask<bool> TryHandleAsync(HttpContext httpContext, Exception exception, CancellationToken cancellationToken)
        {
            // 1. Contexto para el Log
            var errorContext = new
            {
                Path = httpContext.Request.Path.ToString(),
                Method = httpContext.Request.Method,
                User = httpContext.User.Identity?.Name ?? "Anonymous",
                TraceId = httpContext.TraceIdentifier
            };

            // 2. Determinar tipo de error y logearlo
            var responseCode = GetErrorCode(exception);
            var baseMessage = "Ha ocurrido un error interno en el servidor.";

            if (responseCode == ApiResponseCode.DatabaseError)
            {
                logger.LogCritical(exception, "Error de base de datos detectado. Contexto: {ErrorContext}", errorContext);
                baseMessage = "Error de conexión o ejecución en la base de datos.";
            }
            else
            {
                logger.LogCritical(exception, "Excepción no controlada en el servidor. Contexto: {ErrorContext}", errorContext);
            }

            // 3. Construir la respuesta
            string responseMessage = baseMessage;
            object? errorDetails = null;

            // Si estamos en DESARROLLO, mostramos el error
            if (env.IsDevelopment())
            {
                responseMessage = exception.Message;
                errorDetails = new
                {
                    ExceptionType = exception.GetType().Name,
                    exception.StackTrace,
                    InnerException = exception.InnerException?.Message
                };
            }

            var response = new ApiResponse<object>
            {
                IsSuccess = responseCode,
                StatusCode = HttpStatusCode.InternalServerError,
                Message = responseMessage,
                Result = errorDetails
            };

            // 4. Enviar respuesta
            httpContext.Response.StatusCode = (int)HttpStatusCode.InternalServerError;
            httpContext.Response.ContentType = "application/json";

            await httpContext.Response.WriteAsJsonAsync(response, cancellationToken);

            return true;
        }

        /// <summary>
        /// Determina el código de error de la API según el tipo de excepción.
        /// </summary>
        /// <param name="ex"></param>
        /// <returns></returns>
        private static ApiResponseCode GetErrorCode(Exception ex)
        {
            // Si la excepción es de SQL Server (conexión, timeout, query mal formado)
            if (ex is SqlException)
            {
                return ApiResponseCode.DatabaseError;
            }

            // Por defecto, es un error genérico (Crash, NullReference, etc.)
            return ApiResponseCode.UnexpectedError;
        }
    }
}
