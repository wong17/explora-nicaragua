using Microsoft.AspNetCore.Mvc;
using NicaraguaTourism.Bll.Interfaces;
using NicaraguaTourism.Common.Runtime;
using NicaraguaTourism.Entities.Dtos;
using NicaraguaTourism.WebAPI.Controllers.Base;

namespace NicaraguaTourism.WebAPI.Controllers
{
    [Route("api/favorites")]
    public class FavoriteController(IFavoriteBll favoriteBll) : ApiControllerBase
    {
        [HttpPost("add")]
        [ProducesResponseType(typeof(ApiResponse<bool>), StatusCodes.Status200OK)]
        public async Task<IActionResult> Add([FromBody] FavoriteInteractionDto interactionDto)
        {
            var response = await favoriteBll.CreateAsync(interactionDto);
            return HandleApiResponse(response);
        }

        [HttpPost("remove")]
        [ProducesResponseType(typeof(ApiResponse<bool>), StatusCodes.Status200OK)]
        public async Task<IActionResult> Remove([FromBody] FavoriteInteractionDto interactionDto)
        {
            var response = await favoriteBll.DeleteAsync(interactionDto);
            return HandleApiResponse(response);
        }

        [HttpGet("get_paginated/{userId:int}")]
        [ProducesResponseType(typeof(ApiResponse<PaginatedResult<FavoriteDto>>), StatusCodes.Status200OK)]
        public async Task<IActionResult> GetPaginated(int userId, [FromQuery] int? page, [FromQuery] int? rows)
        {
            var response = await favoriteBll.GetPaginatedAsync(userId, page, rows);
            return HandleApiResponse(response);
        }

        [HttpPost("check_status")]
        [ProducesResponseType(typeof(ApiResponse<bool>), StatusCodes.Status200OK)]
        public async Task<IActionResult> CheckIsFavorite([FromBody] FavoriteInteractionDto interactionDto)
        {
            var response = await favoriteBll.IsFavoriteAsync(interactionDto);
            return HandleApiResponse(response);
        }
    }
}
