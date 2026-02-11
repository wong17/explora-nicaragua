import { ComponentFixture, TestBed } from '@angular/core/testing';

import { FavoritesDialog } from './favorites-dialog.component';

describe('FavoritesDialog', () => {
  let component: FavoritesDialog;
  let fixture: ComponentFixture<FavoritesDialog>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [FavoritesDialog]
    })
    .compileComponents();

    fixture = TestBed.createComponent(FavoritesDialog);
    component = fixture.componentInstance;
    await fixture.whenStable();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
