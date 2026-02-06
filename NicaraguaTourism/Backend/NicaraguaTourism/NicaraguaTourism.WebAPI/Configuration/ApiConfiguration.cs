using NicaraguaTourism.WebAPI.Controllers.Base;

namespace NicaraguaTourism.WebAPI.Configuration
{
    public static class ApiConfiguration
    {
        public static void AddApiConfiguration(this IServiceCollection services)
        {
            services.AddControllers().ConfigureApiBehaviorOptions(options =>
            {
                options.InvalidModelStateResponseFactory = context =>
                {
                    return ApiControllerBase.ProcessValidationFailure(context);
                };
            });
        }
    }
}
