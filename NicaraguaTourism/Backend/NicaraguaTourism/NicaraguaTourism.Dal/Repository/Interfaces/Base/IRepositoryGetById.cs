using NicaraguaTourism.Common.Runtime;

namespace NicaraguaTourism.Dal.Repository.Interfaces.Base
{
    public interface IRepositoryGetById<in TKey, TResult>
    {
        Task<ApiResponse<TResult>> GetById(TKey id);
    }
}
