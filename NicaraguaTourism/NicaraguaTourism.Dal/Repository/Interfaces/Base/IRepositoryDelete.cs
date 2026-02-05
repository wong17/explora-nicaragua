using NicaraguaTourism.Common.Runtime;

namespace NicaraguaTourism.Dal.Repository.Interfaces.Base
{
    public interface IRepositoryDelete<in TKey, TResult>
    {
        Task<ApiResponse<TResult>> Delete(TKey id);
    }
}
