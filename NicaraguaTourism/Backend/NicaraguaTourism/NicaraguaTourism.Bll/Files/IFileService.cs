namespace NicaraguaTourism.Bll.Files
{
    public interface IFileService
    {
        /// <summary>
        /// Sube un archivo a Azure Blob Storage.
        /// </summary>
        /// <param name="fileStream">Flujo de datos del archivo</param>
        /// <param name="fileName">Nombre original del archivo</param>
        /// <param name="contentType">Tipo MIME (ej: image/jpeg)</param>
        /// <returns>La URL pública del archivo</returns>
        Task<string> UploadFileAsync(Stream fileStream, string fileName, string contentType);

        /// <summary>
        /// Elimina un archivo del almacenamiento.
        /// </summary>
        Task<bool> DeleteFileAsync(string imageUrl);
    }
}
