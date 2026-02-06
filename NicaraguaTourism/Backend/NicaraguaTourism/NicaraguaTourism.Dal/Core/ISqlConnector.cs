using Dapper;
using System.Data;

namespace NicaraguaTourism.Dal.Core
{
    public interface ISqlConnector
    {
        /// <summary>
        /// Obtiene una lista de resultados mapeados a T.
        /// </summary>
        /// <typeparam name="T"></typeparam>
        /// <param name="spName"></param>
        /// <param name="parameters"></param>
        /// <returns></returns>
        Task<IEnumerable<T>> QueryAsync<T>(string spName, object? parameters = null);

        /// <summary>
        /// Obtiene un único registro mapeado a T (o null/default si no existe).
        /// </summary>
        /// <typeparam name="T"></typeparam>
        /// <param name="spName"></param>
        /// <param name="parameters"></param>
        /// <returns></returns>
        Task<T?> QuerySingleOrDefaultAsync<T>(string spName, object? parameters = null);

        /// <summary>
        /// Ejecuta una acción (Insert, Update, Delete) y devuelve el número de filas afectadas.
        /// </summary>
        /// <param name="spName"></param>
        /// <param name="parameters"></param>
        /// <returns></returns>
        Task<int> ExecuteAsync(string spName, object? parameters = null);

        /// <summary>
        /// Ejecuta una consulta que devuelve un solo valor (ej. Insertar y devolver ID, o Count).
        /// </summary>
        /// <typeparam name="T"></typeparam>
        /// <param name="spName"></param>
        /// <param name="parameters"></param>
        /// <returns></returns>
        Task<T?> ExecuteScalarAsync<T>(string spName, object? parameters = null);

        /// <summary>
        /// Lee un resultado JSON desde SQL Server (incluso si viene fragmentado en varias filas).
        /// </summary>
        /// <param name="spName"></param>
        /// <param name="parameters"></param>
        /// <returns></returns>
        Task<string> QueryJsonAsync(string spName, object? parameters = null);

        /// <summary>
        /// Ejecuta un SP que devuelve múltiples resultados (Selects múltiples) y permite mapearlos.
        /// </summary>
        /// <typeparam name="T"></typeparam>
        /// <param name="spName"></param>
        /// <param name="mapFunc"></param>
        /// <param name="parameters"></param>
        /// <returns></returns>
        Task<T> QueryMultipleAsync<T>(string spName, Func<Dapper.SqlMapper.GridReader, Task<T>> mapFunc, object? parameters = null);

        /// <summary>
        /// Ejecuta un SP enviando una lista como TVP (Table-Valued Parameter) y mapea el resultado.
        /// </summary>
        /// <typeparam name="TInput"></typeparam>
        /// <typeparam name="TResult"></typeparam>
        /// <param name="spName"></param>
        /// <param name="tvpParamName"></param>
        /// <param name="tvpTypeName"></param>
        /// <param name="data"></param>
        /// <param name="defineColumns"></param>
        /// <param name="mapRow"></param>
        /// <param name="extraParams"></param>
        /// <returns></returns>
        Task<TResult?> QuerySingleOrDefaultTvpAsync<TInput, TResult>(
            string spName,
            string tvpParamName,            // Nombre del parámetro en el SP
            string tvpTypeName,             // Tipo de dato en SQL
            IEnumerable<TInput> data,       // La lista de datos
            Action<DataTable> defineColumns,// Acción para definir columnas
            Func<TInput, object?[]> mapRow, // Función para transformar objeto -> fila
            object? extraParams = null      // Parámetros adicionales
        );

        /// <summary>
        /// 
        /// </summary>
        /// <typeparam name="TInput"></typeparam>
        /// <typeparam name="TResult"></typeparam>
        /// <param name="spName"></param>
        /// <param name="tvpParamName"></param>
        /// <param name="tvpTypeName"></param>
        /// <param name="data"></param>
        /// <param name="defineColumns"></param>
        /// <param name="mapRow"></param>
        /// <param name="mapFunc"></param>
        /// <param name="extraParams"></param>
        /// <returns></returns>
        Task<TResult> QueryMultipleTvpAsync<TInput, TResult>(
            string spName,
            string tvpParamName,                                // Nombre del parámetro en el SP
            string tvpTypeName,                                 // Tipo de dato en SQL
            IEnumerable<TInput> data,                           // La lista de datos
            Action<DataTable> defineColumns,                    // Acción para definir columnas
            Func<TInput, object?[]> mapRow,                     // Función para transformar objeto -> fila
            Func<SqlMapper.GridReader, Task<TResult>> mapFunc,  // Función para leer los resultados
            object? extraParams = null                          // Parámetros adicionales
        );
    }
}
