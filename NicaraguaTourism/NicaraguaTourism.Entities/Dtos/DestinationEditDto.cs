
namespace NicaraguaTourism.Entities.Dtos
{
    public class DestinationEditDto
    {
        public int DestinationId { get; set; }
        public string Name { get; set; } = string.Empty;
        public string ShortDescription { get; set; } = string.Empty;
        public string? LongDescription { get; set; }
        public string? Location { get; set; }
        public decimal? Latitude { get; set; }
        public decimal? Longitude { get; set; }
        public string? AverageWeather { get; set; }
        public string? AccessDifficulty { get; set; }
        public List<DestinationImageDto> Images { get; set; } = new List<DestinationImageDto>();
        public List<ActivityDto> Activities { get; set; } = new List<ActivityDto>();
    }
}
