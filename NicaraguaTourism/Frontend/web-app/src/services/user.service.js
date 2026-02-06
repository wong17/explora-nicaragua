import { HttpClient } from './base/http-client.js';

class UserService extends HttpClient {
    constructor() {
        super('users');
    }

    /**
     * Registra un nuevo usuario (POST api/users/register)
     * @param {object} registerDto - UserRegisterDto
     */
    async register(registerDto) {
        return await this.post('register', registerDto);
    }

    /**
     * Inicia sesión (POST api/users/login)
     * @param {object} loginDto - UserLoginDto
     */
    async login(loginDto) {
        return await this.post('login', loginDto);
    }

    /**
     * Actualiza un usuario (PUT api/users/update)
     * @param {object} updateDto - UserUpdateDto
     */
    async update(updateDto) {
        return await this.put('update', updateDto);
    }

    /**
     * Elimina un usuario (DELETE api/users/delete/{id})
     * @param {number} id 
     */
    async delete(id) {
        return await this.delete(`delete/${id}`);
    }

    /**
     * Obtiene todos los usuarios (GET api/users/get_all)
     */
    async getAll() {
        return await this.get('get_all');
    }

    /**
     * Obtiene un usuario por ID (GET api/users/get_by_id/{id})
     * @param {number} id 
     */
    async getById(id) {
        return await this.get(`get_by_id/${id}`);
    }
}

// Exportamos la instancia única (Singleton)
export const userService = new UserService();