using NicaraguaTourism.Dal.Repository.Interfaces.Base;
using NicaraguaTourism.Entities.Dtos;
using NicaraguaTourism.Entities.Models;

namespace NicaraguaTourism.Dal.Repository.Interfaces
{
    public interface IUserRepository :
        IRepositoryCreate<User, int>,
        IRepositoryUpdate<User, bool>,
        IRepositoryDelete<int, bool>,
        IRepositoryGetById<int, UserDto>,
        IRepositoryGetAll<UserDto>
    {
    }
}
