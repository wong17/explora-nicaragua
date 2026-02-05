using NicaraguaTourism.Common.Runtime;
using NicaraguaTourism.Dal.Core;
using NicaraguaTourism.Dal.Repository.Implements.Base;
using NicaraguaTourism.Dal.Repository.Interfaces;
using NicaraguaTourism.Entities.Dtos;

namespace NicaraguaTourism.Dal.Repository.Implements
{
    public class DestinationRepository(ISqlConnector connector) : RepositoryBase(connector), IDestinationRepository
    {
        public Task<ApiResponse<int>> Create(DestinationRegisterDto createDto, int sessionUserId)
        {
            throw new NotImplementedException();
        }

        public Task<ApiResponse<bool>> Delete(int id)
        {
            throw new NotImplementedException();
        }

        public Task<ApiResponse<IEnumerable<DestinationDto>>> GetAll()
        {
            throw new NotImplementedException();
        }

        public Task<ApiResponse<DestinationDto>> GetById(int id)
        {
            throw new NotImplementedException();
        }

        public Task<ApiResponse<bool>> Update(DestinationEditDto updateDto, int sessionUserId)
        {
            throw new NotImplementedException();
        }
    }
}
