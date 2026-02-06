/**
 * DTO para registrar un nuevo usuario.
 */
export class UserRegisterDto {
    constructor(fullName = '', email = '', password = '', roleId = 0) {
        this.fullName = fullName;
        this.email = email;
        this.password = password;
        this.roleId = roleId;
    }
}

/**
 * DTO para inicio de sesión.
 */
export class UserLoginDto {
    constructor(email = '', password = '') {
        this.email = email;
        this.password = password;
    }
}

/**
 * DTO para actualizar un usuario existente.
 */
export class UserUpdateDto {
    constructor(userId = 0, fullName = '', email = '', roleId = 0) {
        this.userId = userId;
        this.fullName = fullName;
        this.email = email;
        this.roleId = roleId;
    }
}

/**
 * DTO de lectura de usuario.
 */
export class UserDto {
    constructor(data = {}) {
        this.userId = data.userId || 0;
        this.fullName = data.fullName || '';
        this.email = data.email || '';
        this.roleId = data.roleId || 0;
        this.roleName = data.roleName || '';
        this.createdAt = data.createdAt ? new Date(data.createdAt) : null;
    }
}