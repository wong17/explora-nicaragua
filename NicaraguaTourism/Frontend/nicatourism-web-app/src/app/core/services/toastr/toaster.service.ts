import { Injectable } from '@angular/core';
import { MessageService } from 'primeng/api';

@Injectable({
  providedIn: 'root',
})
export class ToasterService {

  constructor(private messageService: MessageService) { }

  /**
   * Muestra un mensaje de éxito (Verde)
   */
  success(message: string, title: string = 'Éxito') {
    this.show('success', title, message);
  }

  /**
   * Muestra un mensaje de error (Rojo)
   */
  error(message: string, title: string = 'Error') {
    this.show('error', title, message, 5000); // Dura más tiempo para que el usuario pueda leerlo
  }

  /**
   * Muestra un mensaje de información (Azul)
   */
  info(message: string, title: string = 'Información') {
    this.show('info', title, message);
  }

  /**
   * Muestra un mensaje de advertencia (Amarillo)
   */
  warning(message: string, title: string = 'Advertencia') {
    this.show('warn', title, message, 4000);
  }

  /**
   * Muestra un mensaje que NO desaparece hasta que el usuario lo cierre.
   * Útil para errores críticos o procesos de carga manuales.
   */
  sticky(message: string, title: string = 'Aviso Importante', severity: 'info' | 'warn' | 'error' = 'info') {
    this.messageService.add({
      severity: severity,
      summary: title,
      detail: message,
      sticky: true // Esta es la magia de PrimeNG
    });
  }

  /**
   * Limpia todas las notificaciones en pantalla
   */
  clear() {
    this.messageService.clear();
  }

  // Método privado helper para no repetir código
  private show(severity: string, summary: string, detail: string, life: number = 3000) {
    this.messageService.add({
      severity: severity,
      summary: summary,
      detail: detail,
      life: life
    });
  }
}
