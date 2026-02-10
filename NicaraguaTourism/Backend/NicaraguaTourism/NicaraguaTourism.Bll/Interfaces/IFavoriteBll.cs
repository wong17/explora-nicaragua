using NicaraguaTourism.Common.Runtime;
using NicaraguaTourism.Entities.Dtos;

namespace NicaraguaTourism.Bll.Interfaces
{
    public interface IFavoriteBll
    {
        Task<ApiResponse<bool>> CreateAsync(FavoriteInteractionDto createDto);
        Task<ApiResponse<bool>> DeleteAsync(FavoriteInteractionDto dto);
        Task<ApiResponse<PaginatedResult<FavoriteDto>>> GetPaginatedAsync(int userId, int? page, int? rows);
        Task<ApiResponse<bool>> IsFavoriteAsync(FavoriteInteractionDto interactionDto);
    }
}
