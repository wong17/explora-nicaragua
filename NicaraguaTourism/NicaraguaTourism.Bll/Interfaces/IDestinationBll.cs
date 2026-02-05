using NicaraguaTourism.Common.Runtime;
using NicaraguaTourism.Entities.Dtos;

namespace NicaraguaTourism.Bll.Interfaces
{
    public interface IDestinationBll
    {
        Task<ApiResponse<int>> CreateAsync(DestinationRegisterDto createDto, int createdBy);
        Task<ApiResponse<bool>> DeleteAsync(int id);
        Task<ApiResponse<IEnumerable<DestinationDto>>> GetAllAsync();
        Task<ApiResponse<DestinationDto>> GetByIdAsync(int id);
        Task<ApiResponse<bool>> UpdateAsync(DestinationUpdateDto updateDto, int modifiedBy);
    }
}
