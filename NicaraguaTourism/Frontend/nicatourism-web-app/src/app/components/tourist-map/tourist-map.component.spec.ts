import { ComponentFixture, TestBed } from '@angular/core/testing';

import { TouristMap } from './tourist-map.component';

describe('TuristicMap', () => {
  let component: TouristMap;
  let fixture: ComponentFixture<TouristMap>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [TouristMap]
    })
    .compileComponents();

    fixture = TestBed.createComponent(TouristMap);
    component = fixture.componentInstance;
    await fixture.whenStable();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
