using NicaraguaTourism.Common.Runtime;
using NicaraguaTourism.Dal.Core;
using NicaraguaTourism.Dal.Repository.Implements.Base;
using NicaraguaTourism.Dal.Repository.Interfaces;
using NicaraguaTourism.Entities.Dtos;
using NicaraguaTourism.Entities.Models;

namespace NicaraguaTourism.Dal.Repository.Implements
{
    public class UserRepository(ISqlConnector connector) : RepositoryBase(connector), IUserRepository
    {
        public async Task<ApiResponse<int>> Create(User createDto)
        {
            var parameters = new
            {
                createDto.FullName,
                createDto.Email,
                createDto.Password,
                createDto.RoleId
            };
            var spResponse = await _connector.QuerySingleOrDefaultAsync<SpResponse>("uspRegisterUser", parameters);

            return MapToApiResponse<int>(spResponse);
        }

        public async Task<ApiResponse<bool>> Delete(int id)
        {
            var parameters = new { UserId = id };
            var spResponse = await _connector.QuerySingleOrDefaultAsync<SpResponse>("uspDeleteUser", parameters);

            return MapToApiResponse<bool>(spResponse);
        }

        public async Task<ApiResponse<PaginatedResult<UserDto>>> GetPaginated(int? page, int? rows)
        {
            var parameters = new { PageNumber = page, PageSize = rows };
            var jsonResult = await _connector.QueryJsonAsync("uspGetUsers");
            return MapJsonToApiResponse<PaginatedResult<UserDto>>(jsonResult);
        }

        public async Task<User?> GetByEmail(string email)
        {
            var parameters = new { Email = email };
            var user = await _connector.QuerySingleOrDefaultAsync<User>("uspGetUserByEmail", parameters);

            return user;
        }

        public async Task<ApiResponse<UserDto>> GetById(int id)
        {
            var parameters = new { UserId = id };
            var jsonResult = await _connector.QueryJsonAsync("uspGetUsers", parameters);
            return MapJsonToApiResponse<UserDto>(jsonResult);
        }

        public async Task<ApiResponse<int>> Login(UserLoginDto loginDto)
        {
            var parameters = new
            {
                loginDto.Email,
                loginDto.Password
            };
            var spResponse = await _connector.QuerySingleOrDefaultAsync<SpResponse>("uspLoginUser", parameters);

            return MapToApiResponse<int>(spResponse);
        }

        public async Task<ApiResponse<bool>> Update(User updateDto)
        {
            var parameters = new
            {
                updateDto.UserId,
                updateDto.FullName,
                updateDto.Email,
                updateDto.RoleId
            };
            var spResponse = await _connector.QuerySingleOrDefaultAsync<SpResponse>("uspEditUser", parameters);

            return MapToApiResponse<bool>(spResponse);
        }
    }
}
