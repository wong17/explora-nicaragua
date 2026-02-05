using Microsoft.Extensions.DependencyInjection;
using NicaraguaTourism.Bll.Hashing;
using NicaraguaTourism.Bll.Mappings;
using NicaraguaTourism.Dal.Configuration;

namespace NicaraguaTourism.Bll.Configuration
{
    public static class ConfigureServicesBussinessLogic
    {
        public static void AddBusinessLogicLayer(this IServiceCollection services)
        {
            /* Agregar primero servicios de Data Access Layer (DAL) */
            services.AddDataAccessLayer();
            /* Agregar configuración de Mappers */
            services.AddSingleton<Mapper>();
            /* Agregar Argon2HashingServices */
            services.AddScoped<IPasswordHashingService, Argon2HashingService>();
        }
    }
}
