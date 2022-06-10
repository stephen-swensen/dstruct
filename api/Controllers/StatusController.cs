using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace api.Controllers;

[ApiController]
public class StatusController : ControllerBase
{

    private readonly ILogger<StatusController> _logger;

    public StatusController(ILogger<StatusController> logger)
    {
        _logger = logger;
    }

    /// <summary>
    /// Basic up check. Includes a test for outbound connectivity.
    /// </summary>
    /// <returns></returns>
    [HttpGet("status")]
    public async Task<IActionResult> Status()
    {
        //ensure outbound connectivity
        var client = new HttpClient();
        var request = new HttpRequestMessage();
        request.RequestUri = new Uri("http://example.org");
        var response = await client.SendAsync(request);
        response.EnsureSuccessStatusCode();

        return new JsonResult(new Object());
    }
    
    /// <summary>
    /// Simple auth check. Lets you validate tenant credentials.
    /// </summary>
    /// <returns></returns>
    [Authorize]
    [HttpGet("status/auth")]
    public async Task<IActionResult> StatusAuth()
    {

        return new JsonResult(new Object());
    }
}
