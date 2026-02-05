using System.ComponentModel.DataAnnotations;

namespace NicaraguaTourism.Entities.Dtos
{
    public class FavoriteInteractionDto
    {
        [Required(ErrorMessage = "El ID del usuario es requerido.")]
        [Range(1, int.MaxValue, ErrorMessage = "El ID del usuario no es válido.")]
        public int UserId { get; set; }

        [Required(ErrorMessage = "El ID del destino es requerido.")]
        [Range(1, int.MaxValue, ErrorMessage = "El ID del destino no es válido.")]
        public int DestinationId { get; set; }
    }
}
