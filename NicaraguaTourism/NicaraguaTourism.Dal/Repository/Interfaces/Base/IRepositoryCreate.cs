using NicaraguaTourism.Common.Runtime;

namespace NicaraguaTourism.Dal.Repository.Interfaces.Base
{
    public interface IRepositoryCreate<in TCreate, TResult>
    {
        Task<ApiResponse<TResult>> Create(TCreate createDto);
    }
}
