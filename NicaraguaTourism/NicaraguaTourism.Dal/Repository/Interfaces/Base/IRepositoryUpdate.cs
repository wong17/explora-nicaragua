using NicaraguaTourism.Common.Runtime;

namespace NicaraguaTourism.Dal.Repository.Interfaces.Base
{
    public interface IRepositoryUpdate<in TUpdate, TResult>
    {
        Task<ApiResponse<TResult>> Update(TUpdate updateDto);
    }
}
