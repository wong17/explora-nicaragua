import { TestBed } from '@angular/core/testing';

import { FavoriteServiceTs } from './favorite.service.ts';

describe('FavoriteServiceTs', () => {
  let service: FavoriteServiceTs;

  beforeEach(() => {
    TestBed.configureTestingModule({});
    service = TestBed.inject(FavoriteServiceTs);
  });

  it('should be created', () => {
    expect(service).toBeTruthy();
  });
});
