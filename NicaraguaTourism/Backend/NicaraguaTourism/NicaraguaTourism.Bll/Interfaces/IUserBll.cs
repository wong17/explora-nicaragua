using NicaraguaTourism.Common.Runtime;
using NicaraguaTourism.Entities.Dtos;

namespace NicaraguaTourism.Bll.Interfaces
{
    public interface IUserBll
    {
        Task<ApiResponse<int>> CreateAsync(UserRegisterDto createDto);
        Task<ApiResponse<bool>> DeleteAsync(int id);
        Task<ApiResponse<IEnumerable<UserDto>>> GetAllAsync();
        Task<ApiResponse<UserDto>> GetByIdAsync(int id);
        Task<ApiResponse<int>> Login(UserLoginDto loginDto);
        Task<ApiResponse<bool>> UpdateAsync(UserUpdateDto updateDto);
    }
}
