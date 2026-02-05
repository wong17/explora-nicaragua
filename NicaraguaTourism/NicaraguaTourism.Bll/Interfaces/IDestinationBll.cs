using NicaraguaTourism.Common.Runtime;
using NicaraguaTourism.Entities.Dtos;

namespace NicaraguaTourism.Bll.Interfaces
{
    public interface IDestinationBll
    {
        Task<ApiResponse<int>> Create(DestinationRegisterDto createDto, int createdBy);
        Task<ApiResponse<bool>> Delete(int id);
        Task<ApiResponse<IEnumerable<DestinationDto>>> GetAll();
        Task<ApiResponse<DestinationDto>> GetById(int id);
        Task<ApiResponse<bool>> Update(DestinationUpdateDto updateDto, int modifiedBy);
    }
}
