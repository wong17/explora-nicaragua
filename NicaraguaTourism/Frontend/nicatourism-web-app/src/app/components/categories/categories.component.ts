import { AfterViewInit, Component, CUSTOM_ELEMENTS_SCHEMA, ElementRef, signal, ViewChild } from '@angular/core';
import { CommonModule } from '@angular/common';
import { RouterLink } from '@angular/router';

import { Navigation, Pagination, Autoplay, EffectCoverflow } from 'swiper/modules';
import { SwiperOptions } from 'swiper/types';

@Component({
  selector: 'app-categories',
  imports: [CommonModule, RouterLink],
  templateUrl: './categories.component.html',
  styleUrl: './categories.component.css',
  schemas: [CUSTOM_ELEMENTS_SCHEMA]
})
export class Categories implements AfterViewInit {

  @ViewChild('mainSwiper') mainSwiperRef!: ElementRef;
  @ViewChild('gallerySwiper') gallerySwiperRef!: ElementRef;

  categories = signal([
    {
      id: 'volcanes',
      title: 'Tierra de Fuego',
      subtitle: 'Volcanes y Aventura',
      image: '/assets/images/categories/1_large.webp',
      count: '12 Destinos'
    },
    {
      id: 'playas',
      title: 'Olas del Pacífico',
      subtitle: 'Surf y Relax',
      image: '/assets/images/categories/2_large.webp',
      count: '8 Destinos'
    },
    {
      id: 'colonial',
      title: 'Historia Viva',
      subtitle: 'Ciudades Coloniales',
      image: '/assets/images/categories/3_large.webp',
      count: '5 Destinos'
    },
    {
      id: 'caribe',
      title: 'Aguas Turquesas',
      subtitle: 'Caribe Paradisiaco',
      image: '/assets/images/categories/4_large.webp',
      count: '3 Destinos'
    },
    {
      id: 'selva',
      title: 'Pulmón Verde',
      subtitle: 'Reservas Naturales',
      image: '/assets/images/categories/5_large.webp',
      count: '6 Reservas'
    }
  ]);

  private baseGallery = [
    {
      title: 'Mirador Volcánico',
      image: '/assets/images/categories/6_large.webp'
    },
    {
      title: 'Cráter Santiago',
      image: '/assets/images/categories/7_large.webp'
    },
    {
      title: 'Atardecer en Granada',
      image: '/assets/images/categories/8_large.webp'
    },
    {
      title: 'Techos de León',
      image: '/assets/images/categories/9_large.webp'
    },
    {
      title: 'Fauna Silvestre',
      image: '/assets/images/categories/10_large.webp'
    },
    {
      title: 'Iglesia Xalteva',
      image: '/assets/images/categories/11_large.webp'
    },
    {
      title: 'Patrimonio Mundial',
      image: '/assets/images/categories/12_large.webp'
    },
    {
      title: 'Aves Exóticas',
      image: '/assets/images/categories/13_large.webp'
    },
    {
      title: 'Volcán Concepción',
      image: '/assets/images/categories/14_large.webp'
    },
    {
      title: 'Río San Juan',
      image: '/assets/images/categories/15_large.webp'
    }
  ];

  galleryItems = signal([...this.baseGallery, ...this.baseGallery]);

  ngAfterViewInit() {
    const mainEl = this.mainSwiperRef.nativeElement;
    const galleryEl = this.gallerySwiperRef.nativeElement;

    const modules = [Navigation, Pagination, Autoplay, EffectCoverflow];

    const mainConfig: SwiperOptions = {
      modules: modules,
      loop: true,
      speed: 1000,
      autoplay: {
        delay: 5000,
        disableOnInteraction: false,
        pauseOnMouseEnter: true
      },
      slidesPerView: 'auto',
      centeredSlides: true,
      spaceBetween: 20,
      effect: 'coverflow',
      coverflowEffect: {
        rotate: 0,
        stretch: 0,
        depth: 100,
        modifier: 1,
        slideShadows: false,
      },
      navigation: {
        nextEl: '.custom-next',
        prevEl: '.custom-prev',
      },
      pagination: {
        el: '.external-pagination',
        clickable: true,
        dynamicBullets: true
      }
    };

    const galleryConfig: SwiperOptions = {
      modules: modules,
      loop: true,
      speed: 3000,
      autoplay: {
        delay: 0,
        disableOnInteraction: false,
        pauseOnMouseEnter: true
      },
      slidesPerView: 'auto', 
      spaceBetween: 15,
      centeredSlides: false,
      loopAdditionalSlides: 10
    };

    // Asignar e inicializar por separado
    Object.assign(mainEl, mainConfig);
    Object.assign(galleryEl, galleryConfig);

    mainEl.initialize();
    galleryEl.initialize();
  }

}
