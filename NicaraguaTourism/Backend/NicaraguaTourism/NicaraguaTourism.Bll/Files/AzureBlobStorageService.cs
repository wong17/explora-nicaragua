
using Azure.Storage.Blobs;
using Azure.Storage.Blobs.Models;
using Microsoft.Extensions.Configuration;

namespace NicaraguaTourism.Bll.Files
{
    public class AzureBlobStorageService(IConfiguration configuration) : IFileService
    {
        private readonly string? _connectionString = configuration["AzureStorage:ConnectionString"];
        private readonly string? _containerName = configuration["AzureStorage:ContainerName"];

        public async Task<bool> DeleteFileAsync(string imageUrl)
        {
            if (_connectionString is null || _containerName is null)
                throw new InvalidOperationException("Azure Storage configuration is missing.");

            var uri = new Uri(imageUrl);
            // El nombre del blob es el último segmento de la URL
            var fileName = Path.GetFileName(uri.LocalPath);

            var blobServiceClient = new BlobServiceClient(_connectionString);
            var containerClient = blobServiceClient.GetBlobContainerClient(_containerName);
            var blobClient = containerClient.GetBlobClient(fileName);

            // Borrar si existe
            return await blobClient.DeleteIfExistsAsync();
        }

        public async Task<string> UploadFileAsync(Stream fileStream, string fileName, string contentType)
        {
            if (_connectionString is null || _containerName is null)
                throw new InvalidOperationException("Azure Storage configuration is missing.");

            // Crear cliente del servicio Blob
            var blobServiceClient = new BlobServiceClient(_connectionString);
            // Obtener referencia al contenedor
            var containerClient = blobServiceClient.GetBlobContainerClient(_containerName);
            // Crear el contenedor si no existe y habilitar acceso público a Blobs (Esto asegura que las URLs sean accesibles por el navegador)
            await containerClient.CreateIfNotExistsAsync(PublicAccessType.Blob);

            // Generar un nombre único para evitar colisiones (Guid + Extensión original)
            var extension = Path.GetExtension(fileName);
            var uniqueFileName = $"{Guid.NewGuid()}{extension}";

            // Obtener referencia al Blob (el archivo individual)
            var blobClient = containerClient.GetBlobClient(uniqueFileName);
            // Configurar cabeceras (Importante para que se vea como imagen)
            var blobHttpHeaders = new BlobHttpHeaders { ContentType = contentType };

            // Subir, reseteamos la posición del stream por seguridad
            fileStream.Position = 0;
            await blobClient.UploadAsync(fileStream, new BlobUploadOptions { HttpHeaders = blobHttpHeaders });

            // Retornar la URL absoluta
            return blobClient.Uri.ToString();
        }
    }
}
