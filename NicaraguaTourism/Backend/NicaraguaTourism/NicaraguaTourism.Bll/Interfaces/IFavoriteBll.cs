using NicaraguaTourism.Common.Runtime;
using NicaraguaTourism.Entities.Dtos;

namespace NicaraguaTourism.Bll.Interfaces
{
    public interface IFavoriteBll
    {
        Task<ApiResponse<bool>> CreateAsync(FavoriteInteractionDto createDto);
        Task<ApiResponse<bool>> DeleteAsync(FavoriteInteractionDto dto);
        Task<ApiResponse<IEnumerable<FavoriteDto>>> GetAllByIdAsync(int id);
        Task<ApiResponse<bool>> IsFavoriteAsync(FavoriteInteractionDto interactionDto);
    }
}
