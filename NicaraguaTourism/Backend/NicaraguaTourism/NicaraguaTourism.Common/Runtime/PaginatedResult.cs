using System.Text.Json.Serialization;

namespace NicaraguaTourism.Common.Runtime
{
    public record PaginatedResult<T>
    {
        public int TotalRecords { get; init; }
        public IReadOnlyList<T> Data { get; init; }

        // Constructor que asegura que Data nunca sea null, incluso si el JSON no lo trae
        [JsonConstructor] // Indica a System.Text.Json que use este constructor
        public PaginatedResult(int totalRecords, IReadOnlyList<T>? data)
        {
            TotalRecords = totalRecords;
            // Si data viene null del JSON, asignamos lista vacía.
            Data = data ?? [];
        }

        // Constructor por defecto para inicialización manual
        public PaginatedResult()
        {
            TotalRecords = 0;
            Data = [];
        }
    }
}
