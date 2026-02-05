using System.ComponentModel.DataAnnotations;

namespace NicaraguaTourism.Entities.Dtos
{
    public class UserUpdateDto
    {
        [Required(ErrorMessage = "El ID del usuario es requerido.")]
        [Range(1, int.MaxValue, ErrorMessage = "ID de usuario no válido.")]
        public int UserId { get; set; }

        [Required(ErrorMessage = "El nombre completo es requerido.")]
        [StringLength(100, ErrorMessage = "El nombre completo no puede exceder los 100 caracteres.")]
        public string FullName { get; set; } = string.Empty;

        [Required(ErrorMessage = "El correo electrónico es requerido.")]
        [EmailAddress(ErrorMessage = "El formato del correo electrónico no es válido.")]
        [StringLength(100, ErrorMessage = "El correo electrónico no puede exceder los 100 caracteres.")]
        public string Email { get; set; } = string.Empty;

        [Required(ErrorMessage = "El Rol es requerido.")]
        [Range(1, int.MaxValue, ErrorMessage = "El Rol seleccionado no es válido.")]
        public int RoleId { get; set; }
    }
}
