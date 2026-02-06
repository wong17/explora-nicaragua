using Microsoft.Extensions.DependencyInjection;
using NicaraguaTourism.Bll.Hashing;
using NicaraguaTourism.Bll.Implements;
using NicaraguaTourism.Bll.Interfaces;
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
            /* Agreagr servicios */
            services.AddScoped<IUserBll, UserBll>();
            services.AddScoped<IFavoriteBll, FavoriteBll>();
            services.AddScoped<IDestinationBll, DestinationBll>();
            /* Agregar configuración de Mappers */
            services.AddSingleton<TourismMapper>();
            /* Agregar Argon2HashingServices */
            services.AddScoped<IPasswordHashingService, Argon2HashingService>();
        }
    }
}
