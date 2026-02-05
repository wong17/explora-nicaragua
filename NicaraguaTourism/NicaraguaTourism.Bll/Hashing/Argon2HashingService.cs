using Isopoh.Cryptography.Argon2;
using System.Security.Cryptography;
using System.Text;

namespace NicaraguaTourism.Bll.Hashing
{
    public class Argon2HashingService : IPasswordHashingService
    {
        // Estos son los parámetros recomendados por OWASP
        // https://cheatsheetseries.owasp.org/cheatsheets/Password_Storage_Cheat_Sheet.html
        private const int MemoryCost = 19456; // 19 MiB
        private const int TimeCost = 2;       // 2 iteraciones
        private const int DegreeOfParallelism = 1;
        private const int SaltSize = 16; // 16 bytes es el estándar

        public string HashPassword(string password)
        {
            // 1. Generamos un salt aleatorio PRIMERO
            byte[] salt = new byte[SaltSize];
            using (var rng = RandomNumberGenerator.Create())
            {
                rng.GetBytes(salt);
            }

            // 2. Configuramos Argon2 CON el salt
            var config = new Argon2Config
            {
                Type = Argon2Type.HybridAddressing,
                Version = Argon2Version.Nineteen,
                MemoryCost = MemoryCost,
                TimeCost = TimeCost,
                Lanes = DegreeOfParallelism,
                Threads = DegreeOfParallelism, // Usar 1 hilo para p=1
                Password = Encoding.UTF8.GetBytes(password),

                // Asignamos nuestro salt generado
                Salt = salt
            };

            // 3. Hasheamos
            using var argon2 = new Argon2(config);
            using var hash = argon2.Hash();

            // 4. Ahora, 'config.EncodeString' tiene el salt
            // y generará el string completo (ej. $argon2id$v=19...$salt...$hash)
            return config.EncodeString(hash.Buffer);
        }

        public bool VerifyPassword(string password, string hash)
        {
            if (string.IsNullOrEmpty(hash))
            {
                return false;
            }

            // La biblioteca lee automáticamente los parámetros y el salt
            // desde el string del hash.
            return Argon2.Verify(hash, password);
        }
    }
}
