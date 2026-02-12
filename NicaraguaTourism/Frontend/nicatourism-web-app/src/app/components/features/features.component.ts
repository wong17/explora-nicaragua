import { AfterViewInit, Component, ElementRef, QueryList, ViewChildren } from '@angular/core';
import { CommonModule } from '@angular/common';
import gsap from 'gsap';
import { ScrollTrigger } from 'gsap/ScrollTrigger';

gsap.registerPlugin(ScrollTrigger);

@Component({
  selector: 'app-features',
  imports: [CommonModule],
  templateUrl: './features.component.html',
  styleUrl: './features.component.css',
})
export class Features implements AfterViewInit {

  @ViewChildren('featureCard') featureCards!: QueryList<ElementRef>;

  features = [
    {
      icon: 'pi pi-compass',
      title: 'Joyas Ocultas',
      description: 'Olvídate de lo típico. Descubre cascadas, miradores y senderos secretos que solo los locales conocen.'
    },
    {
      icon: 'pi pi-verified',
      title: 'Datos Reales',
      description: 'Precios, clima y accesos actualizados. Te damos la información veraz para que viajes sin sorpresas.'
    },
    {
      icon: 'pi pi-heart',
      title: 'Tu Colección Personal',
      description: '¿Ves algo que te enamora? Guárdalo en tu lista de deseos y ten tu próxima aventura siempre lista.'
    }
  ];

  ngAfterViewInit() {
    const cards = this.featureCards.map(c => c.nativeElement);

    gsap.fromTo(cards,
      {
        opacity: 0,
        y: 50
      },
      {
        opacity: 1,
        y: 0,
        duration: 0.8,
        stagger: 0.2,
        ease: 'power3.out',
        scrollTrigger: {
          trigger: '.features-section',
          start: 'top 80%',
        }
      }
    );
  }

}
