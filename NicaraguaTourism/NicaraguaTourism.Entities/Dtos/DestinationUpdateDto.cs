
using System.ComponentModel.DataAnnotations;

namespace NicaraguaTourism.Entities.Dtos
{
    public class DestinationUpdateDto
    {
        [Required(ErrorMessage = "El ID del destino es requerido.")]
        [Range(1, int.MaxValue, ErrorMessage = "El ID del destino no es válido.")]
        public int DestinationId { get; set; }

        [Required(ErrorMessage = "El nombre del destino es requerido.")]
        [StringLength(100, ErrorMessage = "El nombre no puede exceder los 100 caracteres.")]
        public string Name { get; set; } = string.Empty;

        [Required(ErrorMessage = "La descripción corta es requerida.")]
        [StringLength(300, ErrorMessage = "La descripción corta no puede exceder los 300 caracteres.")]
        public string ShortDescription { get; set; } = string.Empty;

        public string? LongDescription { get; set; }

        [StringLength(200, ErrorMessage = "La ubicación no puede exceder los 200 caracteres.")]
        public string? Location { get; set; }

        [Range(-90, 90, ErrorMessage = "La latitud debe estar entre -90 y 90.")]
        public decimal? Latitude { get; set; }

        [Range(-180, 180, ErrorMessage = "La longitud debe estar entre -180 y 180.")]
        public decimal? Longitude { get; set; }

        [StringLength(50, ErrorMessage = "El clima promedio no puede exceder los 50 caracteres.")]
        public string? AverageWeather { get; set; }

        [StringLength(50, ErrorMessage = "La dificultad de acceso no puede exceder los 50 caracteres.")]
        public string? AccessDifficulty { get; set; }

        public List<DestinationImageInsertDto> Images { get; set; } = [];
        public List<ActivityInsertDto> Activities { get; set; } = [];
    }
}
