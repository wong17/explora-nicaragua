import { Component, inject, signal } from '@angular/core';
import { ApiResponseCode, AuthService, ToasterService, UiService, UserLoginDto, UserRegisterDto, UserService } from '../../core/core.index';
import { DialogModule } from 'primeng/dialog';
import { FormBuilder, ReactiveFormsModule, Validators } from '@angular/forms';
import { ButtonModule } from 'primeng/button';
import { InputTextModule } from 'primeng/inputtext';
import { PasswordModule } from 'primeng/password';
import { FloatLabelModule } from 'primeng/floatlabel';
import { DividerModule } from 'primeng/divider';
import { HttpErrorResponse } from '@angular/common/http';
import { switchMap, throwError } from 'rxjs';

@Component({
  selector: 'app-auth-modal',
  imports: [
    DialogModule, 
    ReactiveFormsModule,
    ButtonModule,
    InputTextModule,
    PasswordModule,
    FloatLabelModule,
    DividerModule
  ],
  templateUrl: './auth-modal.component.html',
  styleUrl: './auth-modal.component.css',
})
export class AuthModal {

  public uiService = inject(UiService);
  private fb = inject(FormBuilder);
  private toaster = inject(ToasterService);
  private userService = inject(UserService);
  private authService = inject(AuthService);

  isLoginMode = signal(true);

  authForm = this.fb.group({
    fullName: [''], // Solo para registro
    email: ['', [Validators.required, Validators.email]],
    password: ['', [Validators.required, Validators.minLength(8)]]
  });

  toggleMode() {
    this.isLoginMode.update(v => !v);
    const isLogin = this.isLoginMode();
    const nameControl = this.authForm.get('fullName');

    if (isLogin) {
      nameControl?.clearValidators();
      nameControl?.setValue('');
    } else {
      nameControl?.setValidators([Validators.required]);
    }
    // Actualizar el estado del control para que Angular sepa del cambio
    nameControl?.updateValueAndValidity();
    this.authForm.markAsUntouched();
  }

  onClose() {
    this.authForm.reset();
    this.isLoginMode.set(true);
    this.authForm.markAsUntouched();
    this.authForm.markAsPristine();
  }

  onSubmit() {
    if (this.authForm.invalid) {
      this.authForm.markAllAsTouched();
      return;
    }

    const { fullName, email, password } = this.authForm.value;

    // Login
    if (this.isLoginMode()) {
      const loginDto: UserLoginDto = {
        email: email!,
        password: password!
      };

      this.userService.login(loginDto).pipe(
        switchMap(loginResponse => {
          if (loginResponse.isSuccess == ApiResponseCode.Success && loginResponse.result) {
            return this.userService.getById(loginResponse.result);
          } 

          return throwError(() => new Error(loginResponse.message));
        })
      ).subscribe({
        next: (userResponse) => {
          if (userResponse.isSuccess == ApiResponseCode.Success && userResponse.result) {
            this.authService.setCurrentUser(userResponse.result);
            this.toaster.success(`Bienvenid@, ${userResponse.result.fullName}`);
            this.uiService.closeLoginModal();
          }
        },
        error: (err: HttpErrorResponse) => {
          this.toaster.error(err.error.message || 'Error de credenciales', 'Error de Acceso');
        }
      });

      return;
    }

    // Registro
    const registerDto: UserRegisterDto = {
      fullName: fullName!,
      email: email!,
      password: password!,
      roleId: 2 // Por defecto Visitante
    };

    this.userService.register(registerDto).subscribe({
      next: (response) => {
        if (response.isSuccess != ApiResponseCode.Success) {
          this.toaster.error(response.message || 'Error al registrarse');
          return;
        } 

        this.toaster.success('Cuenta creada exitosamente. Ahora puedes iniciar sesión.', '¡Éxito!');
        this.toggleMode();
      },
      error: (err: HttpErrorResponse) => {
        this.toaster.error(err.error?.message || 'No se pudo completar el registro', 'Error al registrarse');
      }
    });
  }
}
