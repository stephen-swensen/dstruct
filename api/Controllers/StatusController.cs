using Microsoft.AspNetCore.Mvc;

namespace api.Controllers;

[ApiController]
[Route("status")]
public class StatusController : ControllerBase
{

    private readonly ILogger<StatusController> _logger;

    public StatusController(ILogger<StatusController> logger)
    {
        _logger = logger;
    }

    [HttpGet("/")]
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
}
