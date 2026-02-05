using NicaraguaTourism.Common.Runtime;
using NicaraguaTourism.Entities.Dtos;

namespace NicaraguaTourism.Bll.Interfaces
{
    public interface IUserBll
    {
        Task<ApiResponse<int>> Create(UserRegisterDto createDto);
        Task<ApiResponse<bool>> Delete(int id);
        Task<ApiResponse<IEnumerable<UserDto>>> GetAll();
        Task<ApiResponse<UserDto>> GetById(int id);
        Task<ApiResponse<int>> Login(UserLoginDto loginDto);
        Task<ApiResponse<bool>> Update(UserUpdateDto updateDto);
    }
}
