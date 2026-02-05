using System.ComponentModel.DataAnnotations;

namespace NicaraguaTourism.Entities.Dtos
{
    public class DestinationImageInsertDto
    {
        [Required(ErrorMessage = "La URL de la imagen es requerida.")]
        [StringLength(500, ErrorMessage = "La URL de la imagen no puede exceder los 500 caracteres.")]
        public string ImageUrl { get; set; } = string.Empty;

        public bool? IsCover { get; set; }

        [StringLength(100, ErrorMessage = "El texto alternativo no puede exceder los 100 caracteres.")]
        public string? AltText { get; set; }
    }
}
