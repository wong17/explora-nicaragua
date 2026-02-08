using NicaraguaTourism.Common.Runtime;
using NicaraguaTourism.Entities.Dtos;

namespace NicaraguaTourism.Bll.Interfaces
{
    public interface IDestinationBll
    {
        Task<ApiResponse<int>> CreateAsync(DestinationRegisterDto createDto, int createdBy);
        Task<ApiResponse<bool>> DeleteAsync(int id);
        Task<ApiResponse<PaginatedResult<DestinationDto>>> GetPaginatedAsync(int? page, int? rows);
        Task<ApiResponse<DestinationDto>> GetByIdAsync(int id);
        Task<ApiResponse<bool>> UpdateAsync(DestinationUpdateDto updateDto, int modifiedBy);
        Task<ApiResponse<int>> RegisterUnifiedAsync(string destinationJson, List<FileUploadDto> imageFiles, int adminId);
        Task<ApiResponse<bool>> UpdateUnifiedAsync(string destinationJson, List<FileUploadDto> newImageFiles, int adminId);
    }
}
