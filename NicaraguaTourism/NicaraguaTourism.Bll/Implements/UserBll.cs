using NicaraguaTourism.Bll.Hashing;
using NicaraguaTourism.Bll.Implements.Base;
using NicaraguaTourism.Bll.Interfaces;
using NicaraguaTourism.Common.Runtime;
using NicaraguaTourism.Dal.Repository.Interfaces;
using NicaraguaTourism.Entities.Dtos;

namespace NicaraguaTourism.Bll.Implements
{
    public class UserBll(IUserRepository repository, IPasswordHashingService hashingService) : BllBase, IUserBll
    {
        public async Task<ApiResponse<int>> Create(UserRegisterDto createDto)
        {
            throw new NotImplementedException();
        }

        public async Task<ApiResponse<bool>> Delete(int id)
        {
            throw new NotImplementedException();
        }

        public async Task<ApiResponse<IEnumerable<UserDto>>> GetAll()
        {
            throw new NotImplementedException();
        }

        public async Task<ApiResponse<UserDto>> GetById(int id)
        {
            throw new NotImplementedException();
        }

        public async Task<ApiResponse<int>> Login(UserLoginDto loginDto)
        {
            throw new NotImplementedException();
        }

        public async Task<ApiResponse<bool>> Update(UserUpdateDto updateDto)
        {
            throw new NotImplementedException();
        }
    }
}
