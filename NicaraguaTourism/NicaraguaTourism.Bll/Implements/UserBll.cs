using NicaraguaTourism.Bll.Hashing;
using NicaraguaTourism.Bll.Implements.Base;
using NicaraguaTourism.Bll.Interfaces;
using NicaraguaTourism.Bll.Mappings;
using NicaraguaTourism.Common.Runtime;
using NicaraguaTourism.Dal.Repository.Interfaces;
using NicaraguaTourism.Entities.Dtos;

namespace NicaraguaTourism.Bll.Implements
{
    public class UserBll(IUserRepository repository, IPasswordHashingService hashingService, TourismMapper mapper) : BllBase, IUserBll
    {
        public async Task<ApiResponse<int>> CreateAsync(UserRegisterDto createDto)
        {
            if (string.IsNullOrEmpty(createDto.FullName) || string.IsNullOrEmpty(createDto.Password) || string.IsNullOrEmpty(createDto.Email))
            {
                return CreateValidationApiResponse<int>("Los campos obligatorios no pueden estar vacíos.");
            }

            if (createDto.RoleId <= 0)
            {
                return CreateValidationApiResponse<int>("El rol no es válido.");
            }

            createDto.Password = hashingService.HashPassword(createDto.Password);

            var model = mapper.UserRegisterDtoToUser(createDto);
            var response = await repository.Create(model);

            return MapApiResponse(response, result => result);
        }

        public async Task<ApiResponse<bool>> DeleteAsync(int id)
        {
            if (id <= 0)
            {
                return CreateValidationApiResponse<bool>("El ID de usuario no es válido.");
            }

            var dalResponse = await repository.Delete(id);

            return MapApiResponse(dalResponse, result => result);
        }

        public async Task<ApiResponse<IEnumerable<UserDto>>> GetAllAsync()
        {
            var dalResponse = await repository.GetAll();

            return MapApiResponse(dalResponse, result => result);
        }

        public async Task<ApiResponse<UserDto>> GetByIdAsync(int id)
        {
            if (id <= 0)
            {
                return CreateValidationApiResponse<UserDto>("El ID de usuario no es válido.");
            }

            var dalResponse = await repository.GetById(id);

            return MapApiResponse(dalResponse, dto => dto);
        }

        public async Task<ApiResponse<int>> Login(UserLoginDto loginDto)
        {
            if (string.IsNullOrEmpty(loginDto.Email) || string.IsNullOrEmpty(loginDto.Password))
            {
                return CreateValidationApiResponse<int>("Correo y contraseña son obligatorios.");
            }

            var user = await repository.GetByEmail(loginDto.Email);
            if (user is null)
            {
                return CreateValidationApiResponse<int>("Credenciales incorrectas.");
            }

            var isPasswordValid = hashingService.VerifyPassword(loginDto.Password, user.Password);
            if (!isPasswordValid)
            {
                return CreateValidationApiResponse<int>("Credenciales incorrectas.");
            }

            return CreateSuccessApiResponse(user.UserId, $"Bienvenido, {user.FullName}.");
        }

        public async Task<ApiResponse<bool>> UpdateAsync(UserUpdateDto updateDto)
        {
            if (string.IsNullOrEmpty(updateDto.FullName) || string.IsNullOrEmpty(updateDto.Email))
            {
                return CreateValidationApiResponse<bool>("Los campos obligatorios no pueden estar vacíos.");
            }

            if (updateDto.UserId <= 0)
            {
                return CreateValidationApiResponse<bool>("El UserId no es válido.");
            }

            var model = mapper.UserUpdateToDto(updateDto);
            var dalResponse = await repository.Update(model);

            return MapApiResponse(dalResponse, result => result);
        }
    }
}
