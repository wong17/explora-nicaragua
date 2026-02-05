namespace NicaraguaTourism.Entities.Models
{
    public class DestinationImage
    {
        public int ImageId { get; set; }
        public int DestinationId { get; set; }
        public int AdminId { get; set; }
        public string ImageUrl { get; set; } = string.Empty;
        public bool? IsCover { get; set; }
        public string? AltText { get; set; }
        public DateTime UploadedAt { get; set; }
    }
}
