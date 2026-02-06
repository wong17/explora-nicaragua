using System.ComponentModel.DataAnnotations;

namespace NicaraguaTourism.Entities.Dtos
{
    public class ActivityInsertDto
    {
        [Required(ErrorMessage = "El nombre de la actividad es requerido.")]
        [StringLength(100, ErrorMessage = "El nombre de la actividad no puede exceder los 100 caracteres.")]
        public string ActivityName { get; set; } = string.Empty;

        [StringLength(50, ErrorMessage = "El nombre del ícono no puede exceder los 50 caracteres.")]
        public string? IconName { get; set; }
    }
}
