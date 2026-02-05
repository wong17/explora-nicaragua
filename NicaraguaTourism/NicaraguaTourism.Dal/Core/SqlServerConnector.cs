using Dapper;
using Microsoft.Data.SqlClient;
using Microsoft.Extensions.Configuration;
using NicaraguaTourism.Dal.Enum;
using System.Data;

namespace NicaraguaTourism.Dal.Core
{
    public sealed class SqlServerConnector(IConfiguration configuration, TargetDatabase database = TargetDatabase.NicaraguaTourismDB)
        : ISqlConnector
    {
        private readonly string? _connectionString = configuration.GetConnectionString(database.ToString());

        private SqlConnection CreateConnection() => new(_connectionString);

        /// <summary>
        /// 
        /// </summary>
        /// <typeparam name="T"></typeparam>
        /// <param name="spName"></param>
        /// <param name="parameters"></param>
        /// <returns></returns>
        public async Task<IEnumerable<T>> QueryAsync<T>(string spName, object? parameters = null)
        {
            await using var connection = CreateConnection();
            return await connection.QueryAsync<T>(spName, parameters, commandType: CommandType.StoredProcedure);
        }

        /// <summary>
        /// 
        /// </summary>
        /// <typeparam name="T"></typeparam>
        /// <param name="spName"></param>
        /// <param name="parameters"></param>
        /// <returns></returns>
        public async Task<T?> QuerySingleOrDefaultAsync<T>(string spName, object? parameters = null)
        {
            await using var connection = CreateConnection();
            return await connection.QuerySingleOrDefaultAsync<T>(spName, parameters, commandType: CommandType.StoredProcedure);
        }

        /// <summary>
        /// 
        /// </summary>
        /// <param name="spName"></param>
        /// <param name="parameters"></param>
        /// <returns></returns>
        public async Task<int> ExecuteAsync(string spName, object? parameters = null)
        {
            await using var connection = CreateConnection();
            return await connection.ExecuteAsync(spName, parameters, commandType: CommandType.StoredProcedure);
        }

        /// <summary>
        /// 
        /// </summary>
        /// <typeparam name="T"></typeparam>
        /// <param name="spName"></param>
        /// <param name="parameters"></param>
        /// <returns></returns>
        public async Task<T?> ExecuteScalarAsync<T>(string spName, object? parameters = null)
        {
            await using var connection = CreateConnection();
            return await connection.ExecuteScalarAsync<T>(spName, parameters, commandType: CommandType.StoredProcedure);
        }

        /// <summary>
        /// 
        /// </summary>
        /// <param name="spName"></param>
        /// <param name="parameters"></param>
        /// <returns></returns>
        public async Task<string> QueryJsonAsync(string spName, object? parameters = null)
        {
            await using var connection = CreateConnection();
            var jsonChunks = await connection.QueryAsync<string>(spName, parameters, commandType: CommandType.StoredProcedure);
            return string.Concat(jsonChunks);
        }

        /// <summary>
        /// 
        /// </summary>
        /// <typeparam name="T"></typeparam>
        /// <param name="spName"></param>
        /// <param name="mapFunc"></param>
        /// <param name="parameters"></param>
        /// <returns></returns>
        public async Task<T> QueryMultipleAsync<T>(string spName, Func<SqlMapper.GridReader, Task<T>> mapFunc, object? parameters = null)
        {
            await using var connection = CreateConnection();
            await using var grid = await connection.QueryMultipleAsync(spName, parameters, commandType: CommandType.StoredProcedure);
            return await mapFunc(grid);
        }

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
        /// <param name="extraParams"></param>
        /// <returns></returns>
        public async Task<TResult?> QuerySingleOrDefaultTvpAsync<TInput, TResult>(
            string spName,
            string tvpParamName,
            string tvpTypeName,
            IEnumerable<TInput> data,
            Action<DataTable> defineColumns,
            Func<TInput, object?[]> mapRow,
            object? extraParams = null)
        {
            var dt = new DataTable();
            defineColumns(dt);

            foreach (var item in data)
            {
                dt.Rows.Add(mapRow(item));
            }

            var parameters = new DynamicParameters();
            parameters.Add(tvpParamName, dt.AsTableValuedParameter(tvpTypeName));

            if (extraParams is not null)
            {
                parameters.AddDynamicParams(extraParams);
            }

            await using var connection = CreateConnection();

            return await connection.QuerySingleOrDefaultAsync<TResult>(spName, parameters, commandType: CommandType.StoredProcedure);
        }

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
        public async Task<TResult> QueryMultipleTvpAsync<TInput, TResult>(
            string spName,
            string tvpParamName,
            string tvpTypeName,
            IEnumerable<TInput> data,
            Action<DataTable> defineColumns,
            Func<TInput, object?[]> mapRow,
            Func<SqlMapper.GridReader, Task<TResult>> mapFunc,
            object? extraParams = null)
        {
            var dt = new DataTable();
            defineColumns(dt);

            foreach (var item in data)
            {
                dt.Rows.Add(mapRow(item));
            }

            var parameters = new DynamicParameters();
            parameters.Add(tvpParamName, dt.AsTableValuedParameter(tvpTypeName));

            if (extraParams is not null)
            {
                parameters.AddDynamicParams(extraParams);
            }

            await using var connection = CreateConnection();
            await using var grid = await connection.QueryMultipleAsync(spName, parameters, commandType: CommandType.StoredProcedure);

            return await mapFunc(grid);
        }
    }
}
