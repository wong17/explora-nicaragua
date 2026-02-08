using Microsoft.AspNetCore.Mvc;
using NicaraguaTourism.Bll.Interfaces;
using NicaraguaTourism.Common.Runtime;
using NicaraguaTourism.Entities.Dtos;
using NicaraguaTourism.WebAPI.Controllers.Base;

namespace NicaraguaTourism.WebAPI.Controllers
{
    [Route("api/destinations")]
    public class DestinationController(IDestinationBll destinationBll) : ApiControllerBase
    {
        [HttpPost("register")]
        [ProducesResponseType(typeof(ApiResponse<int>), StatusCodes.Status200OK)]
        public async Task<IActionResult> Create([FromForm] string destinationJson, [FromForm] List<IFormFile> images, [FromQuery] int adminId)
        {
            if (images is null || images.Count == 0)
            {
                return HandleApiResponse(CreateValidationApiResponse<int>("Debes enviar al menos una imagen."));
            }

            var fileDtos = new List<FileUploadDto>();
            foreach (var img in images)
            {
                if (img.Length > 0)
                {
                    fileDtos.Add(new FileUploadDto
                    {
                        Content = img.OpenReadStream(),
                        FileName = img.FileName,
                        ContentType = img.ContentType
                    });
                }
            }
            var response = await destinationBll.RegisterUnifiedAsync(destinationJson, fileDtos, adminId);
            return HandleApiResponse(response);
        }

        [HttpPut("update")]
        [ProducesResponseType(typeof(ApiResponse<bool>), StatusCodes.Status200OK)]
        [ProducesResponseType(typeof(ApiResponse<object>), StatusCodes.Status404NotFound)]
        public async Task<IActionResult> Update([FromForm] string destinationJson, [FromForm] List<IFormFile> images, [FromQuery] int adminId)
        {
            if (images is null || images.Count == 0)
            {
                return HandleApiResponse(CreateValidationApiResponse<int>("Debes enviar al menos una imagen."));
            }

            var fileDtos = new List<FileUploadDto>();
            foreach (var img in images)
            {
                if (img.Length > 0)
                {
                    fileDtos.Add(new FileUploadDto
                    {
                        Content = img.OpenReadStream(),
                        FileName = img.FileName,
                        ContentType = img.ContentType
                    });
                }
            }
            var response = await destinationBll.UpdateUnifiedAsync(destinationJson, fileDtos, adminId);
            return HandleApiResponse(response);
        }

        [HttpDelete("delete/{id:int}")]
        [ProducesResponseType(typeof(ApiResponse<bool>), StatusCodes.Status200OK)]
        [ProducesResponseType(typeof(ApiResponse<object>), StatusCodes.Status404NotFound)]
        public async Task<IActionResult> Delete(int id)
        {
            var response = await destinationBll.DeleteAsync(id);
            return HandleApiResponse(response);
        }

        [HttpGet("get_paginated")]
        [ProducesResponseType(typeof(ApiResponse<PaginatedResult<DestinationDto>>), StatusCodes.Status200OK)]
        [ProducesResponseType(typeof(ApiResponse<object>), StatusCodes.Status404NotFound)]
        public async Task<IActionResult> GetPaginated([FromQuery] int? page, [FromQuery] int? rows)
        {
            var response = await destinationBll.GetPaginatedAsync(page, rows);
            return HandleApiResponse(response);
        }

        [HttpGet("get_by_id/{id:int}")]
        [ProducesResponseType(typeof(ApiResponse<DestinationDto>), StatusCodes.Status200OK)]
        [ProducesResponseType(typeof(ApiResponse<object>), StatusCodes.Status404NotFound)]
        public async Task<IActionResult> GetById(int id)
        {
            var response = await destinationBll.GetByIdAsync(id);
            return HandleApiResponse(response);
        }
    }
}
