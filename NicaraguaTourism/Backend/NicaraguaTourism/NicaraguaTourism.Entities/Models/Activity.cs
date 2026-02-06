namespace NicaraguaTourism.Entities.Models
{
    public class Activity
    {
        public int ActivityId { get; set; }
        public int DestinationId { get; set; }
        public int AdminId { get; set; }
        public string ActivityName { get; set; } = string.Empty;
        public string? IconName { get; set; }
    }
}
