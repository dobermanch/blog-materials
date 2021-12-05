using Microsoft.AspNetCore.Mvc;

namespace DictionaryBinder.Controllers;

[ApiController]
[Route("[controller]")]
public class UploadController : ControllerBase
{
    [HttpPost("multipart")]
    public async Task<IActionResult> MultipartAsync([FromForm] UploadRequest request, CancellationToken cancellationToken)
    {
        if (request.Metadata is null || !request.Metadata.Any())
        {
            return BadRequest();
        }

        return Ok();
    }


    [HttpPost("objfrombody")]
    public async Task<IActionResult> ObjFromBodyAsync([FromBody]MetadataUpdateRequest request, CancellationToken cancellationToken)
    {
        if (request.Metadata is null || !request.Metadata.Any())
        {
            return BadRequest();
        }

        return Ok();
    }

    [HttpPost("dicfrombody")]
    public async Task<IActionResult> DicFromBodyAsync([FromBody] Dictionary<string, string> request, CancellationToken cancellationToken)
    {
        if (request is null || !request.Any())
        {
            return BadRequest();
        }

        return Ok();
    }

    [HttpPost("dicfromquery")]
    public async Task<IActionResult> DicFromQueryAsync([FromQuery] Dictionary<string, string> request, CancellationToken cancellationToken)
    {
        if (request is null || !request.Any())
        {
            return BadRequest();
        }

        return Ok();
    }
}
