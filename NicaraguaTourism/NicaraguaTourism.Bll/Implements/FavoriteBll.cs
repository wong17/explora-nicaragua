using NicaraguaTourism.Bll.Implements.Base;
using NicaraguaTourism.Bll.Interfaces;
using NicaraguaTourism.Common.Runtime;
using NicaraguaTourism.Dal.Repository.Interfaces;
using NicaraguaTourism.Entities.Dtos;

namespace NicaraguaTourism.Bll.Implements
{
    public class FavoriteBll(IFavoriteRepository repository) : BllBase, IFavoriteBll
    {
        public Task<ApiResponse<bool>> Create(FavoriteInteractionDto createDto)
        {
            throw new NotImplementedException();
        }

        public Task<ApiResponse<bool>> Delete(FavoriteInteractionDto dto)
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
