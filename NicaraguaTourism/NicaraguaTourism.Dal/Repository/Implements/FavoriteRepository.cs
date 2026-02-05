using NicaraguaTourism.Common.Runtime;
using NicaraguaTourism.Dal.Core;
using NicaraguaTourism.Dal.Repository.Implements.Base;
using NicaraguaTourism.Dal.Repository.Interfaces;
using NicaraguaTourism.Entities.Dtos;

namespace NicaraguaTourism.Dal.Repository.Implements
{
    public class FavoriteRepository(ISqlConnector connector) : RepositoryBase(connector), IFavoriteRepository
    {
        public async Task<ApiResponse<bool>> Create(FavoriteInteractionDto createDto)
        {
            var parameters = new
            {
                createDto.UserId,
                createDto.DestinationId
            };
            var spResponse = await _connector.QuerySingleOrDefaultAsync<SpResponse>("uspAddFavorite", parameters);

            return MapToApiResponse<bool>(spResponse);
        }

        public async Task<ApiResponse<bool>> Delete(FavoriteInteractionDto dto)
        {
            var parameters = new
            {
                dto.UserId,
                dto.DestinationId
            };
            var spResponse = await _connector.QuerySingleOrDefaultAsync<SpResponse>("uspRemoveFavorite", parameters);

            return MapToApiResponse<bool>(spResponse);
        }

        public async Task<ApiResponse<IEnumerable<FavoriteDto>>> GetAllById(int id)
        {
            var parameters = new { UserId = id };
            var jsonResult = await _connector.QueryJsonAsync("uspGetUserFavorites", parameters);

            return MapJsonToApiResponse<IEnumerable<FavoriteDto>>(jsonResult, "Aún no tienes destinos favoritos.");
        }

        public async Task<ApiResponse<bool>> IsFavorite(FavoriteInteractionDto interactionDto)
        {
            var parameters = new
            {
                interactionDto.UserId,
                interactionDto.DestinationId
            };
            var isFavorite = await _connector.QuerySingleOrDefaultAsync<bool>("uspCheckIsFavorite", parameters);

            return CreateSuccessApiResponse(isFavorite);
        }
    }
}
