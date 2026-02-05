namespace NicaraguaTourism.Entities.Models
{
    public class Destination
    {
        public int DestinationId { get; set; }
        public int AdminId { get; set; }
        public string Name { get; set; } = string.Empty;
        public string ShortDescription { get; set; } = string.Empty;
        public string? LongDescription { get; set; }
        public string? Location { get; set; }
        public decimal? Latitude { get; set; }
        public decimal? Longitude { get; set; }
        public string? AverageWeather { get; set; }
        public string? AccessDifficulty { get; set; }
        public DateTime CreatedAt { get; set; }
    }
}
