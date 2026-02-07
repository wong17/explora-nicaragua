import { Component, CUSTOM_ELEMENTS_SCHEMA, OnInit, signal } from '@angular/core';
import { RouterOutlet } from '@angular/router';
import Lenis from 'lenis';
import { register as registerSwiper } from 'swiper/element/bundle';
import { Navbar } from "./components/navbar/navbar";

@Component({
  selector: 'app-root',
  imports: [RouterOutlet, Navbar],
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
