using NicaraguaTourism.Common.Runtime;
using NicaraguaTourism.Dal.Repository.Interfaces.Base;
using NicaraguaTourism.Entities.Dtos;

namespace NicaraguaTourism.Dal.Repository.Interfaces
{
    public interface IDestinationRepository :
        IRepositoryCreateAudited<DestinationRegisterDto, int, int>,
        IRepositoryUpdateAudited<DestinationUpdateDto, bool, int>,
        IRepositoryDelete<int, bool>,
        IRepositoryGetById<int, DestinationDto>
    {
        Task<ApiResponse<PaginatedResult<DestinationDto>>> GetPaginated(int? page, int? rows);
    }
}
