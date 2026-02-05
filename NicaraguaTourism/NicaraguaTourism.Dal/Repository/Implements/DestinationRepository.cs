using NicaraguaTourism.Common.Runtime;
using NicaraguaTourism.Dal.Core;
using NicaraguaTourism.Dal.Repository.Implements.Base;
using NicaraguaTourism.Dal.Repository.Interfaces;
using NicaraguaTourism.Entities.Dtos;
using System.Text.Json;

namespace NicaraguaTourism.Dal.Repository.Implements
{
    public class DestinationRepository(ISqlConnector connector) : RepositoryBase(connector), IDestinationRepository
    {
        public async Task<ApiResponse<int>> Create(DestinationRegisterDto createDto, int sessionUserId)
        {
            var jsonInput = JsonSerializer.Serialize(createDto, _jsonOptions);
            var parameters = new { Json = jsonInput, CreatedBy = sessionUserId };
            var spResponse = await _connector.QuerySingleOrDefaultAsync<SpResponse>("uspRegisterDestination", parameters);

            return MapToApiResponse<int>(spResponse);
        }

        public async Task<ApiResponse<bool>> Delete(int id)
        {
            var parameters = new { DestinationId = id };
            var spResponse = await _connector.QuerySingleOrDefaultAsync<SpResponse>("uspDeleteDestination", parameters);

            return MapToApiResponse<bool>(spResponse);
        }

        public async Task<ApiResponse<IEnumerable<DestinationDto>>> GetAll()
        {
            var jsonResult = await _connector.QueryJsonAsync("uspGetDestinations");

            return MapJsonToApiResponse<IEnumerable<DestinationDto>>(jsonResult, "No se encontraron destinos turísticos.");
        }

        public async Task<ApiResponse<DestinationDto>> GetById(int id)
        {
            var parameters = new { DestinationId = id };
            var jsonResult = await _connector.QueryJsonAsync("uspGetDestinations", parameters);

            return MapJsonToApiResponse<DestinationDto>(jsonResult, "Destino turístico no encontrado.");
        }

        public async Task<ApiResponse<bool>> Update(DestinationEditDto updateDto, int sessionUserId)
        {
            var jsonInput = JsonSerializer.Serialize(updateDto, _jsonOptions);
            var parameters = new { Json = jsonInput, ModifiedBy = sessionUserId };
            var spResponse = await _connector.QuerySingleOrDefaultAsync<SpResponse>("uspEditDestination", parameters);

            return MapToApiResponse<bool>(spResponse);
        }
    }
}
