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

        [HttpGet("get_by_user/{userId:int}")]
        [ProducesResponseType(typeof(ApiResponse<IEnumerable<FavoriteDto>>), StatusCodes.Status200OK)]
        public async Task<IActionResult> GetByUser(int userId)
        {
            var response = await favoriteBll.GetAllByIdAsync(userId);
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
