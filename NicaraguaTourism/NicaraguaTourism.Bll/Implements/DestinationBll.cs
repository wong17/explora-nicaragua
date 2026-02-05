using NicaraguaTourism.Bll.Implements.Base;
using NicaraguaTourism.Bll.Interfaces;
using NicaraguaTourism.Common.Runtime;
using NicaraguaTourism.Dal.Repository.Interfaces;
using NicaraguaTourism.Entities.Dtos;

namespace NicaraguaTourism.Bll.Implements
{
    public class DestinationBll(IDestinationRepository repository) : BllBase, IDestinationBll
    {
        public Task<ApiResponse<int>> Create(DestinationRegisterDto createDto)
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

        public Task<ApiResponse<bool>> Update(DestinationUpdateDto updateDto)
        {
            throw new NotImplementedException();
        }
    }
}
