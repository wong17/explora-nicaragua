import { TestBed } from '@angular/core/testing';

import { UserServiceTs } from './user.service.ts';

describe('UserServiceTs', () => {
  let service: UserServiceTs;

  beforeEach(() => {
    TestBed.configureTestingModule({});
    service = TestBed.inject(UserServiceTs);
  });

  it('should be created', () => {
    expect(service).toBeTruthy();
  });
});
