using NicaraguaTourism.Common.Runtime;
using NicaraguaTourism.Dal.Core;
using NicaraguaTourism.Dal.Repository.Implements.Base;
using NicaraguaTourism.Dal.Repository.Interfaces;
using NicaraguaTourism.Entities.Dtos;

namespace NicaraguaTourism.Dal.Repository.Implements
{
    public class FavoriteRepository(ISqlConnector connector) : RepositoryBase(connector), IFavoriteRepository
    {
        public Task<ApiResponse<bool>> Create(FavoriteInteractionDto createDto)
        {
            throw new NotImplementedException();
        }

        public Task<ApiResponse<bool>> Delete(FavoriteInteractionDto id)
        {
            throw new NotImplementedException();
        }

        public Task<ApiResponse<IEnumerable<FavoriteDto>>> GetAllById(int id)
        {
            throw new NotImplementedException();
        }

        public Task<ApiResponse<bool>> IsFavorite(FavoriteInteractionDto interactionDto)
        {
            throw new NotImplementedException();
        }
    }
}
