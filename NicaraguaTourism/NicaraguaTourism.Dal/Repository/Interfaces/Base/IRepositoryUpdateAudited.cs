using NicaraguaTourism.Common.Runtime;

namespace NicaraguaTourism.Dal.Repository.Interfaces.Base
{
    public interface IRepositoryUpdateAudited<in TUpdateDto, TResult, in TUserKey>
    {
        Task<ApiResponse<TResult>> Update(TUpdateDto updateDto, TUserKey sessionUserId);
    }
}
