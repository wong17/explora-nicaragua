using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Components.Authorization;
using Microsoft.AspNetCore.Mvc;
using NicaraguaTourism.Bll.Interfaces;
using NicaraguaTourism.Common.Runtime;
using NicaraguaTourism.Entities.Dtos;
using NicaraguaTourism.WebAPI.Controllers.Base;

namespace NicaraguaTourism.WebAPI.Controllers
{
    [Authorize]
    [Route("api/users")]
    public class UserController(IUserBll userBll) : ApiControllerBase
    {
        [HttpPost("register")]
        [ProducesResponseType(typeof(ApiResponse<int>), StatusCodes.Status200OK)]
        public async Task<IActionResult> Register([FromBody] UserRegisterDto createDto)
        {
            var response = await userBll.CreateAsync(createDto);
            return HandleApiResponse(response);
        }

        [HttpGet("get_by_id/{id:int}")]
        [ProducesResponseType(typeof(ApiResponse<UserDto>), StatusCodes.Status200OK)]
        [ProducesResponseType(typeof(ApiResponse<object>), StatusCodes.Status404NotFound)]
        public async Task<IActionResult> GetById(int id)
        {
            var response = await userBll.GetByIdAsync(id);
            return HandleApiResponse(response);
        }

        [HttpPut("update")]
        [ProducesResponseType(typeof(ApiResponse<bool>), StatusCodes.Status200OK)]
        [ProducesResponseType(typeof(ApiResponse<object>), StatusCodes.Status404NotFound)]
        public async Task<IActionResult> Update([FromBody] UserUpdateDto updateDto)
        {
            var response = await userBll.UpdateAsync(updateDto);
            return HandleApiResponse(response);
        }

        [HttpDelete("delete/{id:int}")]
        [ProducesResponseType(typeof(ApiResponse<bool>), StatusCodes.Status200OK)]
        [ProducesResponseType(typeof(ApiResponse<object>), StatusCodes.Status404NotFound)]
        public async Task<IActionResult> Delete(int id)
        {
            var response = await userBll.DeleteAsync(id);
            return HandleApiResponse(response);
        }

        [HttpGet("get_all")]
        [ProducesResponseType(typeof(ApiResponse<IEnumerable<UserDto>>), StatusCodes.Status200OK)]
        public async Task<IActionResult> GetAll()
        {
            var response = await userBll.GetAllAsync();
            return HandleApiResponse(response);
        }
    }
}
