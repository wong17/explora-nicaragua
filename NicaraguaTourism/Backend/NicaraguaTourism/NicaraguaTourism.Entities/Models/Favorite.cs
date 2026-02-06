namespace NicaraguaTourism.Entities.Models
{
    public class Favorite
    {
        public int FavoriteId { get; set; }
        public int UserId { get; set; }
        public int DestinationId { get; set; }
        public DateTime AddedAt { get; set; }
    }
}
