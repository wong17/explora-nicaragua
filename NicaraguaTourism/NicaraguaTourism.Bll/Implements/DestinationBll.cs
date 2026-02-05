using NicaraguaTourism.Bll.Implements.Base;
using NicaraguaTourism.Bll.Interfaces;
using NicaraguaTourism.Common.Runtime;
using NicaraguaTourism.Dal.Repository.Interfaces;
using NicaraguaTourism.Entities.Dtos;

namespace NicaraguaTourism.Bll.Implements
{
    public class DestinationBll(IDestinationRepository repository) : BllBase, IDestinationBll
    {
        public async Task<ApiResponse<int>> CreateAsync(DestinationRegisterDto createDto, int createdBy)
        {
            if (string.IsNullOrEmpty(createDto.Name) || string.IsNullOrEmpty(createDto.ShortDescription))
            {
                return CreateValidationApiResponse<int>("El nombre y la descripción corta son obligatorios.");
            }

            if (createdBy <= 0) 
            {
                return CreateValidationApiResponse<int>("El usuario no es válido");
            }

            if (createDto.Images == null || createDto.Images.Count == 0)
            {
                return CreateValidationApiResponse<int>("Debes agregar al menos una imagen para el destino.");
            }

            if (createDto.Latitude.HasValue && (createDto.Latitude < -90 || createDto.Latitude > 90))
            {
                return CreateValidationApiResponse<int>("La latitud debe estar entre -90 y 90.");
            }

            if (createDto.Longitude.HasValue && (createDto.Longitude < -180 || createDto.Longitude > 180))
            {
                return CreateValidationApiResponse<int>("La longitud debe estar entre -180 y 180.");
            }

            var dalResponse = await repository.Create(createDto, createdBy);

            return MapApiResponse(dalResponse, result => result);
        }

        public async Task<ApiResponse<bool>> DeleteAsync(int id)
        {
            if (id <= 0)
            {
                return CreateValidationApiResponse<bool>("El ID del destino no es válido.");
            }

            var dalResponse = await repository.Delete(id);

            return MapApiResponse(dalResponse, result => result);
        }

        public async Task<ApiResponse<IEnumerable<DestinationDto>>> GetAllAsync()
        {
            var dalResponse = await repository.GetAll();
            return MapApiResponse(dalResponse, result => result);
        }

        public async Task<ApiResponse<DestinationDto>> GetByIdAsync(int id)
        {
            if (id <= 0)
            {
                return CreateValidationApiResponse<DestinationDto>("El ID del destino no es válido.");
            }

            var dalResponse = await repository.GetById(id);
            return MapApiResponse(dalResponse, result => result);
        }

        public async Task<ApiResponse<bool>> UpdateAsync(DestinationUpdateDto updateDto, int modifiedBy)
        {
            if (updateDto.DestinationId <= 0)
            {
                return CreateValidationApiResponse<bool>("El ID del destino no es válido.");
            }

            if (modifiedBy <= 0)
            {
                return CreateValidationApiResponse<bool>("El usuario no es válido");
            }

            if (string.IsNullOrEmpty(updateDto.Name) || string.IsNullOrEmpty(updateDto.ShortDescription))
            {
                return CreateValidationApiResponse<bool>("El nombre y la descripción corta son obligatorios.");
            }

            if (updateDto.Images == null || updateDto.Images.Count == 0)
            {
                return CreateValidationApiResponse<bool>("El destino debe tener al menos una imagen.");
            }

            var dalResponse = await repository.Update(updateDto, modifiedBy);

            return MapApiResponse(dalResponse, result => result);
        }
    }
}
