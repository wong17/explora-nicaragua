import { TestBed } from '@angular/core/testing';

import { DestinationServiceTs } from './destination.service.ts';

describe('DestinationServiceTs', () => {
  let service: DestinationServiceTs;

  beforeEach(() => {
    TestBed.configureTestingModule({});
    service = TestBed.inject(DestinationServiceTs);
  });

  it('should be created', () => {
    expect(service).toBeTruthy();
  });
});
