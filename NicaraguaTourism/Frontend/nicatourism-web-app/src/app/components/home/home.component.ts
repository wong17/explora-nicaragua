import { Component } from '@angular/core';
import { Categories } from "../categories/categories.component";
import { Features } from "../features/features.component";
import { Hero } from "../hero/hero.component";

@Component({
  selector: 'app-home',
  imports: [Categories, Features, Hero],
  templateUrl: './home.component.html',
  styleUrl: './home.component.css',
})
export class Home {

}
