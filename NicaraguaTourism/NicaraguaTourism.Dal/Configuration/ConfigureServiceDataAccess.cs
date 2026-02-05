using Microsoft.Extensions.DependencyInjection;
using NicaraguaTourism.Dal.Core;
using NicaraguaTourism.Dal.Repository.Implements;
using NicaraguaTourism.Dal.Repository.Interfaces;

namespace NicaraguaTourism.Dal.Configuration
{
    public static class ConfigureServiceDataAccess
    {
        public static void AddDataAccessLayer(this IServiceCollection services)
        {
            /* Core */
            services.AddScoped<ISqlConnector, SqlServerConnector>();
            /* Repositories */
            services.AddScoped<IUserRepository, UserRepository>();
            services.AddScoped<IDestinationRepository, DestinationRepository>();
            services.AddScoped<IFavoriteRepository, FavoriteRepository>();
        }
    }
}
