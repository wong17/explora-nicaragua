namespace NicaraguaTourism.Entities.Dtos
{
    public class DestinationImageDto
    {
        public string ImageUrl { get; set; } = string.Empty;
        public bool? IsCover { get; set; }
        public string? AltText { get; set; }
    }
}
