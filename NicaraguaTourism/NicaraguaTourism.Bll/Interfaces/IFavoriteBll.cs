using NicaraguaTourism.Common.Runtime;
using NicaraguaTourism.Entities.Dtos;

namespace NicaraguaTourism.Bll.Interfaces
{
    public interface IFavoriteBll
    {
        Task<ApiResponse<bool>> Create(FavoriteInteractionDto createDto);
        Task<ApiResponse<bool>> Delete(FavoriteInteractionDto dto);
        Task<ApiResponse<IEnumerable<FavoriteDto>>> GetAllById(int id);
        Task<ApiResponse<bool>> IsFavorite(FavoriteInteractionDto interactionDto);
    }
}
