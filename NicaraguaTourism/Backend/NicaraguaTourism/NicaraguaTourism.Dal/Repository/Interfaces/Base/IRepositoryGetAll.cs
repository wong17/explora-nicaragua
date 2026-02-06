using NicaraguaTourism.Common.Runtime;

namespace NicaraguaTourism.Dal.Repository.Interfaces.Base
{
    public interface IRepositoryGetAll<TResult>
    {
        Task<ApiResponse<IEnumerable<TResult>>> GetAll();
    }
}
