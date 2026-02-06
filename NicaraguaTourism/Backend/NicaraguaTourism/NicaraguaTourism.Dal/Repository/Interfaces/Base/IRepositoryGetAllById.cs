using NicaraguaTourism.Common.Runtime;

namespace NicaraguaTourism.Dal.Repository.Interfaces.Base
{
    public interface IRepositoryGetAllById<in TKey, TResult>
    {
        Task<ApiResponse<IEnumerable<TResult>>> GetAllById(TKey id);
    }
}
