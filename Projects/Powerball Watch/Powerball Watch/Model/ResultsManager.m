//
//  ResultsManager.m
//  Powerball Watch
//
//  Created by Keli'i Martin on 3/18/14.
//  Copyright (c) 2014 WERUreo. All rights reserved.
//

#import "ResultsManager.h"
#import "ResultsFetcher.h"
#import "ResultsBuilder.h"

@implementation ResultsManager

////////////////////////////////////////////////////////////

- (void)fetchResults
{
    [self.fetcher fetchResults];
}

////////////////////////////////////////////////////////////

#pragma mark - ResultsFetcherDelegate

////////////////////////////////////////////////////////////

- (void)receivedResultsJSON:(NSData *)objectNotation
{
    NSError *error = nil;
    NSArray *results = [ResultsBuilder resultsFromJSON:objectNotation
                                                 error:&error];

    if (error != nil)
    {
        [self.delegate fetchingResultsFailedWithError:error];
    }
    else
    {
        [self.delegate didReceiveResults:results];
    }
}

////////////////////////////////////////////////////////////

- (void)fetchingResultsFailedWithError:(NSError *)error
{
    [self.delegate fetchingResultsFailedWithError:error];
}

////////////////////////////////////////////////////////////

@end
