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
        public async Task<IActionResult> Create([FromBody] DestinationRegisterDto createDto, [FromQuery] int adminId)
        {
            var response = await destinationBll.CreateAsync(createDto, adminId);
            return HandleApiResponse(response);
        }

        [HttpPut("update")]
        [ProducesResponseType(typeof(ApiResponse<bool>), StatusCodes.Status200OK)]
        [ProducesResponseType(typeof(ApiResponse<object>), StatusCodes.Status404NotFound)]
        public async Task<IActionResult> Update([FromBody] DestinationUpdateDto updateDto, [FromQuery] int adminId)
        {
            var response = await destinationBll.UpdateAsync(updateDto, adminId);
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

        [HttpGet("get_all")]
        [ProducesResponseType(typeof(ApiResponse<IEnumerable<DestinationDto>>), StatusCodes.Status200OK)]
        public async Task<IActionResult> GetAll()
        {
            var response = await destinationBll.GetAllAsync();
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
