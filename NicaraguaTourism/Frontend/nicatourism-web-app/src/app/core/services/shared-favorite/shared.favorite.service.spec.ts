import { TestBed } from '@angular/core/testing';

import { SharedFavoriteService } from './shared.favorite.service';

describe('SharedFavoriteService', () => {
  let service: SharedFavoriteService;

  beforeEach(() => {
    TestBed.configureTestingModule({});
    service = TestBed.inject(SharedFavoriteService);
  });

  it('should be created', () => {
    expect(service).toBeTruthy();
  });
});
