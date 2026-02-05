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

        public async Task<ApiResponse<IEnumerable<UserDto>>> GetAll()
        {
            var jsonResult = await _connector.QueryJsonAsync("uspGetUsers");
            return MapJsonToApiResponse<IEnumerable<UserDto>>(jsonResult, "No se encontraron usuarios.");
        }

        public async Task<ApiResponse<UserDto>> GetById(int id)
        {
            var parameters = new { UserId = id };
            var result = await _connector.QuerySingleOrDefaultAsync<UserDto>("uspGetUsers", parameters);
            if (result is null)
            {
                return CreateNotFoundApiResponse<UserDto>("Tipo de operación de reembolso no encontrada.");
            }

            return CreateSuccessApiResponse(result);
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
