// Para leer información del usuario
export interface UserDto {
    userId: number;
    fullName: string;
    email: string;
    roleId: number;
    roleName: string;
    createdAt: string; // Se recibe como string ISO
}

// Para Login
export interface UserLoginDto {
    email: string;
    password: string;
}

// Para Registro
export interface UserRegisterDto {
    fullName: string;
    email: string;
    password: string;
    roleId: number;
}

// Para Actualizar
export interface UserUpdateDto {
    userId: number;
    fullName: string;
    email: string;
    roleId: number;
}