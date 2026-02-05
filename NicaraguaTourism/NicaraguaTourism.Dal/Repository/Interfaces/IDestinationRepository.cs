using NicaraguaTourism.Dal.Repository.Interfaces.Base;
using NicaraguaTourism.Entities.Dtos;

namespace NicaraguaTourism.Dal.Repository.Interfaces
{
    public interface IDestinationRepository :
        IRepositoryCreateAudited<DestinationRegisterDto, int, int>,
        IRepositoryUpdateAudited<DestinationEditDto, bool, int>,
        IRepositoryDelete<int, bool>,
        IRepositoryGetById<int, DestinationDto>,
        IRepositoryGetAll<DestinationDto>
    {
    }
}
