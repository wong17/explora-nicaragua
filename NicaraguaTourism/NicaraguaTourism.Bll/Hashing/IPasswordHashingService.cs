namespace NicaraguaTourism.Bll.Hashing
{
    public interface IPasswordHashingService
    {
        /// <summary>
        /// Crea un hash de contraseña usando Argon2id.
        /// El salt se genera automáticamente y se incluye en el hash.
        /// </summary>
        /// <param name="password">La contraseña en texto plano.</param>
        /// <returns>El string del hash de la contraseña.</returns>
        string HashPassword(string password);

        /// <summary>
        /// Verifica una contraseña en texto plano contra un hash existente.
        /// </summary>
        /// <param name="password">La contraseña en texto plano a verificar.</param>
        /// <param name="hash">El hash guardado en la base de datos.</param>
        /// <returns>True si la contraseña coincide, false en caso contrario.</returns>
        bool VerifyPassword(string password, string hash);
    }
}
