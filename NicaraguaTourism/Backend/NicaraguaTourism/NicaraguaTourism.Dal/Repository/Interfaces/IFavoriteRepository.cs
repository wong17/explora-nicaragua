using NicaraguaTourism.Common.Runtime;
using NicaraguaTourism.Dal.Repository.Interfaces.Base;
using NicaraguaTourism.Entities.Dtos;

namespace NicaraguaTourism.Dal.Repository.Interfaces
{
    public interface IFavoriteRepository :
        IRepositoryCreate<FavoriteInteractionDto, bool>,
        IRepositoryDelete<FavoriteInteractionDto, bool>
    {
        Task<ApiResponse<bool>> IsFavorite(FavoriteInteractionDto interactionDto);
        Task<ApiResponse<PaginatedResult<FavoriteDto>>> GetPaginated(int userId, int? page, int? rows);
    }
}
