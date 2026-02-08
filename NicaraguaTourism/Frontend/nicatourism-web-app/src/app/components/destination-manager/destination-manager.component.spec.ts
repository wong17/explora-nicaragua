import { ComponentFixture, TestBed } from '@angular/core/testing';

import { DestinationManager } from './destination-manager.component';

describe('DestinationManager', () => {
  let component: DestinationManager;
  let fixture: ComponentFixture<DestinationManager>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [DestinationManager]
    })
    .compileComponents();

    fixture = TestBed.createComponent(DestinationManager);
    component = fixture.componentInstance;
    await fixture.whenStable();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
