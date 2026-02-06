namespace NicaraguaTourism.Entities.Dtos
{
    public class DestinationSummaryDto
    {
        public int DestinationId { get; set; }
        public string Name { get; set; } = string.Empty;
        public string ShortDescription { get; set; } = string.Empty;
        public string? Location { get; set; }
        public string? AverageWeather { get; set; }
        public string? AccessDifficulty { get; set; }
        public string? CoverImage { get; set; }
    }
}
