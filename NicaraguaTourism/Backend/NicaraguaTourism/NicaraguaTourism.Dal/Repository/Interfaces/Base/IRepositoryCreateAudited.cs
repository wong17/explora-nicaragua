using NicaraguaTourism.Common.Runtime;

namespace NicaraguaTourism.Dal.Repository.Interfaces.Base
{
    public interface IRepositoryCreateAudited<in TCreateDto, TResult, in TUserKey>
    {
        Task<ApiResponse<TResult>> Create(TCreateDto createDto, TUserKey sessionUserId);
    }
}
