using NicaraguaTourism.Bll.Files;
using NicaraguaTourism.Bll.Implements.Base;
using NicaraguaTourism.Bll.Interfaces;
using NicaraguaTourism.Common.Runtime;
using NicaraguaTourism.Dal.Repository.Interfaces;
using NicaraguaTourism.Entities.Dtos;
using System.Text.Json;

namespace NicaraguaTourism.Bll.Implements
{
    public class DestinationBll(IDestinationRepository repository, IFileService fileService) : BllBase, IDestinationBll
    {
        private static readonly JsonSerializerOptions _jsonOptions = new()
        {
            PropertyNameCaseInsensitive = true
        };

        public async Task<ApiResponse<int>> CreateAsync(DestinationRegisterDto createDto, int createdBy)
        {
            if (string.IsNullOrEmpty(createDto.Name) || string.IsNullOrEmpty(createDto.ShortDescription))
            {
                return CreateValidationApiResponse<int>("El nombre y la descripción corta son obligatorios.");
            }

            if (createdBy <= 0)
            {
                return CreateValidationApiResponse<int>("El usuario no es válido");
            }

            if (createDto.Images == null || createDto.Images.Count == 0)
            {
                return CreateValidationApiResponse<int>("Debes agregar al menos una imagen para el destino.");
            }

            if (createDto.Latitude.HasValue && (createDto.Latitude < -90 || createDto.Latitude > 90))
            {
                return CreateValidationApiResponse<int>("La latitud debe estar entre -90 y 90.");
            }

            if (createDto.Longitude.HasValue && (createDto.Longitude < -180 || createDto.Longitude > 180))
            {
                return CreateValidationApiResponse<int>("La longitud debe estar entre -180 y 180.");
            }

            var dalResponse = await repository.Create(createDto, createdBy);

            return MapApiResponse(dalResponse, result => result);
        }

        /// <summary>
        /// 
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        public async Task<ApiResponse<bool>> DeleteAsync(int id)
        {
            if (id <= 0)
            {
                return CreateValidationApiResponse<bool>("El ID del destino no es válido.");
            }

            // Obtener el destino antes de borrarlo para tener las URLs
            var destination = await GetByIdAsync(id);
            if (destination.IsSuccess != ApiResponseCode.Success || destination.Result is null)
            {
                return CreateValidationApiResponse<bool>("No se encontró el destino para eliminar.");
            }

            // Intentar borrar las imágenes de Azure primero
            var imagesToDelete = destination.Result.Images.Select(i => i.ImageUrl).ToList();

            // Si se borró de BD, borrar archivos de Azure
            var dalResponse = await repository.Delete(id);
            if (dalResponse.Result)
            {
                await RollbackList(imagesToDelete);
                return CreateSuccessApiResponse(true, "Eliminado correctamente.");
            }

            return MapApiResponse(dalResponse, result => result);
        }

        public async Task<ApiResponse<DestinationDto>> GetByIdAsync(int id)
        {
            if (id <= 0)
            {
                return CreateValidationApiResponse<DestinationDto>("El ID del destino no es válido.");
            }

            var dalResponse = await repository.GetById(id);
            return MapApiResponse(dalResponse, result => result);
        }

        public async Task<ApiResponse<PaginatedResult<DestinationDto>>> GetPaginatedAsync(int? page, int? rows)
        {
            if (page.HasValue && page <= 0)
                return CreateValidationApiResponse<PaginatedResult<DestinationDto>>("El número de página no es válido.");

            if (rows.HasValue && rows <= 0)
                return CreateValidationApiResponse<PaginatedResult<DestinationDto>>("El número de filas no es válido.");

            return await repository.GetPaginated(page ?? 1, rows ?? 50);
        }

        /// <summary>
        /// 
        /// </summary>
        /// <param name="destinationJson"></param>
        /// <param name="imageFiles"></param>
        /// <param name="adminId"></param>
        /// <returns></returns>
        public async Task<ApiResponse<int>> RegisterUnifiedAsync(string destinationJson, List<FileUploadDto> imageFiles, int adminId)
        {
            if (string.IsNullOrEmpty(destinationJson))
            {
                return CreateValidationApiResponse<int>("Los datos del destino son obligatorios.");
            }

            if (imageFiles is null || imageFiles.Count == 0)
            {
                return CreateValidationApiResponse<int>("Debes subir al menos una imagen.");
            }

            if (adminId <= 0)
            {
                return CreateValidationApiResponse<int>("El usuario no es válido");
            }

            // Validación de archivos
            if (imageFiles.Any(x => x.Content is null || x.Content.Length == 0 || string.IsNullOrEmpty(x.FileName) || string.IsNullOrEmpty(x.ContentType)))
            {
                return CreateValidationApiResponse<int>("Uno o más archivos son inválidos (sin contenido o nombre).");
            }

            // Deserializar el JSON
            var createDto = JsonSerializer.Deserialize<DestinationRegisterDto>(destinationJson, _jsonOptions);
            if (createDto is null)
            {
                return CreateValidationApiResponse<int>("El formato de los datos del destino es inválido.");
            }

            createDto.Images ??= [];

            var uploadedUrls = new List<string>();
            // Usamos un índice para saber cuál es la primera (Portada)
            for (int i = 0; i < imageFiles.Count; i++)
            {
                var file = imageFiles[i];

                // Subir a Azure
                var uploadedUrl = await fileService.UploadFileAsync(file.Content, file.FileName, file.ContentType);
                if (string.IsNullOrEmpty(uploadedUrl))
                {
                    await RollbackList(uploadedUrls);
                    return CreateValidationApiResponse<int>($"Error al subir la imagen: {file.FileName}");
                }

                // Puardar la URL para posible rollback
                uploadedUrls.Add(uploadedUrl);

                // Agregar al DTO
                createDto.Images.Add(new DestinationImageInsertDto
                {
                    ImageUrl = uploadedUrl,
                    IsCover = (i == 0), // La primera imagen (índice 0) será la portada
                    AltText = $"Imagen {i + 1} de {createDto.Name}"
                });
            }

            var result = await CreateAsync(createDto, adminId);
            if (result.IsSuccess != ApiResponseCode.Success)
            {
                await RollbackList(uploadedUrls);
            }

            return result;
        }

        public async Task<ApiResponse<bool>> UpdateAsync(DestinationUpdateDto updateDto, int modifiedBy)
        {
            if (updateDto.DestinationId <= 0)
            {
                return CreateValidationApiResponse<bool>("El ID del destino no es válido.");
            }

            if (modifiedBy <= 0)
            {
                return CreateValidationApiResponse<bool>("El usuario no es válido");
            }

            if (string.IsNullOrEmpty(updateDto.Name) || string.IsNullOrEmpty(updateDto.ShortDescription))
            {
                return CreateValidationApiResponse<bool>("El nombre y la descripción corta son obligatorios.");
            }

            if (updateDto.Images is null || updateDto.Images.Count == 0)
            {
                return CreateValidationApiResponse<bool>("El destino debe tener al menos una imagen.");
            }

            var dalResponse = await repository.Update(updateDto, modifiedBy);

            return MapApiResponse(dalResponse, result => result);
        }

        /// <summary>
        /// 
        /// </summary>
        /// <param name="destinationJson"></param>
        /// <param name="newImageFiles"></param>
        /// <param name="adminId"></param>
        /// <returns></returns>
        /// <exception cref="NotImplementedException"></exception>
        public async Task<ApiResponse<bool>> UpdateUnifiedAsync(string destinationJson, List<FileUploadDto> newImageFiles, int adminId)
        {
            if (string.IsNullOrEmpty(destinationJson))
            {
                return CreateValidationApiResponse<bool>("Los datos del destino son obligatorios.");
            }

            if (newImageFiles is null || newImageFiles.Count == 0)
            {
                return CreateValidationApiResponse<bool>("Debes subir al menos una imagen.");
            }

            if (adminId <= 0)
            {
                return CreateValidationApiResponse<bool>("El usuario no es válido");
            }

            // Validación de archivos
            if (newImageFiles.Any(x => x.Content is null || x.Content.Length == 0 || string.IsNullOrEmpty(x.FileName) || string.IsNullOrEmpty(x.ContentType)))
            {
                return CreateValidationApiResponse<bool>("Uno o más archivos son inválidos (sin contenido o nombre).");
            }

            // Deserializar el JSON
            var updateDto = JsonSerializer.Deserialize<DestinationUpdateDto>(destinationJson, _jsonOptions);
            if (updateDto is null)
            {
                return CreateValidationApiResponse<bool>("JSON inválido.");
            }

            // Obtener datos viejos (para saber qué imágenes borrar después)
            var currentDestination = await GetByIdAsync(updateDto.DestinationId);
            if (currentDestination.IsSuccess != ApiResponseCode.Success || currentDestination.Result is null)
            {
                return CreateValidationApiResponse<bool>("El destino no existe.");
            }
            var oldImagesUrls = currentDestination.Result.Images.Select(x => x.ImageUrl).ToList();

            // Subir nuevas imágenes
            var newUploadedUrls = new List<string>();
            updateDto.Images ??= [];

            for (int i = 0; i < newImageFiles.Count; i++)
            {
                var file = newImageFiles[i];
                var url = await fileService.UploadFileAsync(file.Content, file.FileName, file.ContentType);

                if (string.IsNullOrEmpty(url))
                {
                    // Si falla subir una nueva, borramos las nuevas que llevábamos
                    await RollbackList(newUploadedUrls);
                    return CreateValidationApiResponse<bool>($"Error subiendo imagen {file.FileName}");
                }

                newUploadedUrls.Add(url);

                updateDto.Images.Add(new DestinationImageInsertDto
                {
                    ImageUrl = url,
                    IsCover = (i == 0),
                    AltText = $"Actualización {i + 1}"
                });
            }

            var dbResult = await UpdateAsync(updateDto, adminId);
            if (dbResult.IsSuccess == ApiResponseCode.Success)
            {
                await RollbackList(oldImagesUrls);
                return dbResult;
            }
            else
            {
                await RollbackList(newUploadedUrls);
                return dbResult;
            }
        }

        private async Task RollbackList(List<string> urls)
        {
            if (urls is null || urls.Count == 0) return;

            foreach (var url in urls)
            {
                if (!string.IsNullOrEmpty(url))
                {
                    await fileService.DeleteFileAsync(url);
                }
            }
        }
    }
}
