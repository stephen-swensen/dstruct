using Dapper;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Data.SqlClient;

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
    [HttpGet("status/auth")]
    public async Task<IActionResult> StatusAuth(
        [FromQuery] string tenantName,
        [FromQuery] string tenantKey)
    {
        var server = Environment.GetEnvironmentVariable("DSTRUCT_DB_SERVER");
        var user = Environment.GetEnvironmentVariable("DSTRUCT_DB_USER");
        var password = Environment.GetEnvironmentVariable("DSTRUCT_DB_USER");
        var connStrBuilder = new SqlConnectionStringBuilder
        {
            DataSource = server,
            UserID = user,
            Password = password,
            InitialCatalog = "DStruct"
        };
        var connStr = connStrBuilder.ToString();
        using (var conn = new SqlConnection(connStr))
        {
            var sql = "exec access.Authenticate @TenantName, @TenantKey";
            var values = new { TenantName = tenantName, TenantKey = tenantKey };
            var result = await conn.ExecuteScalarAsync<int>(sql, values);
            if (result == 1)
            {
                return new JsonResult(new Object());
            }
            else
            {
                return new StatusCodeResult(401);
            }
        }
    }
}
