namespace NicaraguaTourism.Entities.Dtos
{
    public class FavoriteDto
    {
        public int FavoriteId { get; set; }
        public DateTime AddedAt { get; set; }
        public DestinationSummaryDto? Destination { get; set; }
    }
}
