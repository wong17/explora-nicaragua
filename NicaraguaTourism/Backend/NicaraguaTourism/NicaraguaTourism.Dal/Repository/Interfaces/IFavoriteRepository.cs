using NicaraguaTourism.Common.Runtime;
using NicaraguaTourism.Dal.Repository.Interfaces.Base;
using NicaraguaTourism.Entities.Dtos;

namespace NicaraguaTourism.Dal.Repository.Interfaces
{
    public interface IFavoriteRepository :
        IRepositoryCreate<FavoriteInteractionDto, bool>,
        IRepositoryDelete<FavoriteInteractionDto, bool>,
        IRepositoryGetAllById<int, FavoriteDto>
    {
        Task<ApiResponse<bool>> IsFavorite(FavoriteInteractionDto interactionDto);
    }
}
