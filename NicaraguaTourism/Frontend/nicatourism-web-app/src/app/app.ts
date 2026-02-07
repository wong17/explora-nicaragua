import { Component, CUSTOM_ELEMENTS_SCHEMA, OnInit } from '@angular/core';
import { RouterOutlet } from '@angular/router';
import Lenis from 'lenis';
import { register as registerSwiper } from 'swiper/element/bundle';
import { Navbar } from "./components/navbar/navbar.component";
import { Hero } from "./components/hero/hero.component";
import { ToastModule } from 'primeng/toast';
import { AuthModal } from './components/auth-modal/auth-modal.component';

@Component({
  selector: 'app-root',
  imports: [RouterOutlet, Navbar, Hero, ToastModule, AuthModal],
  templateUrl: './app.html',
  styleUrl: './app.css',
  schemas: [CUSTOM_ELEMENTS_SCHEMA]
})
export class App implements OnInit {

  ngOnInit(): void {
    // Activamos los componentes de Swiper
    registerSwiper();

    // Activamos el Scroll Suave (Lenis)
    const lenis = new Lenis({
      duration: 1.2, // Ajusta la "pesadez" del scroll
      easing: (t) => Math.min(1, 1.001 - Math.pow(2, -10 * t)),
      smoothWheel: true
    });

    // Conectamos Lenis al loop de animación del navegador
    function raf(time: number) {
      lenis.raf(time);
      requestAnimationFrame(raf);
    }
    requestAnimationFrame(raf);
  }
}
