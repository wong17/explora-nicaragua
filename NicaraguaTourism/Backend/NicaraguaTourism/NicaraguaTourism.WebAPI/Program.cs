using NicaraguaTourism.Bll.Configuration;
using NicaraguaTourism.WebAPI.Configuration;
using Scalar.AspNetCore;

var builder = WebApplication.CreateBuilder(args);

// Add services to the container.

builder.Services.AddControllers();
// Learn more about configuring OpenAPI at https://aka.ms/aspnet/openapi
builder.Services.AddOpenApi();
// Configure Global Exception Handling
builder.Services.AddExceptionHandler<GlobalExceptionHandler>();
builder.Services.AddProblemDetails();
// Configure Controllers and standardized error handling
builder.Services.AddApiConfiguration();
// Configure CORS to allow requests from specific origins
var allowedOrigins = builder.Configuration["AllowedOrigins"]?
    .Split(",", StringSplitOptions.RemoveEmptyEntries)
    .Select(o => o.Trim())
    .ToArray() ?? [];
builder.Services.AddCors(options =>
{
    options.AddPolicy("AllowSpecificOrigins",
        corsPolicyBuilder => { corsPolicyBuilder.WithOrigins(allowedOrigins).AllowAnyMethod().AllowAnyHeader().AllowCredentials(); });
});
// Register Business Logic Layer services
builder.Services.AddBusinessLogicLayer();

var app = builder.Build();
// Global Exception Handling
app.UseExceptionHandler();
// Configure the HTTP request pipeline.
if (app.Environment.IsDevelopment())
{
    app.MapOpenApi();
    app.MapScalarApiReference();
}

// Global policies
app.UseCors("AllowSpecificOrigins");

app.UseHttpsRedirection();

app.UseAuthorization();

app.MapControllers();

app.Run();
