using NicaraguaTourism.Bll.Implements.Base;
using NicaraguaTourism.Bll.Interfaces;
using NicaraguaTourism.Common.Runtime;
using NicaraguaTourism.Dal.Repository.Interfaces;
using NicaraguaTourism.Entities.Dtos;

namespace NicaraguaTourism.Bll.Implements
{
    public class FavoriteBll(IFavoriteRepository repository) : BllBase, IFavoriteBll
    {
        public async Task<ApiResponse<bool>> CreateAsync(FavoriteInteractionDto createDto)
        {
            if (createDto.UserId <= 0 || createDto.DestinationId <= 0)
            {
                return CreateValidationApiResponse<bool>("Usuario o Destino no válidos.");
            }

            var dalResponse = await repository.Create(createDto);
            return MapApiResponse(dalResponse, result => result);
        }

        public async Task<ApiResponse<bool>> DeleteAsync(FavoriteInteractionDto dto)
        {
            if (dto.UserId <= 0 || dto.DestinationId <= 0)
            {
                return CreateValidationApiResponse<bool>("Usuario o Destino no válidos.");
            }

            var dalResponse = await repository.Delete(dto);
            return MapApiResponse(dalResponse, result => result);
        }

        public async Task<ApiResponse<IEnumerable<FavoriteDto>>> GetAllByIdAsync(int id)
        {
            if (id <= 0)
            {
                return CreateValidationApiResponse<IEnumerable<FavoriteDto>>("El ID de usuario no es válido.");
            }

            var dalResponse = await repository.GetAllById(id);
            return MapApiResponse(dalResponse, result => result);
        }

        public async Task<ApiResponse<bool>> IsFavoriteAsync(FavoriteInteractionDto interactionDto)
        {
            if (interactionDto.UserId <= 0 || interactionDto.DestinationId <= 0)
            {
                return CreateSuccessApiResponse(false);
            }

            var dalResponse = await repository.IsFavorite(interactionDto);
            return MapApiResponse(dalResponse, result => result);
        }
    }
}
