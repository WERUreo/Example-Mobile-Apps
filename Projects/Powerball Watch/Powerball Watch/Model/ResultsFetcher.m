//
//  ResultsFetcher.m
//  Powerball Watch
//
//  Created by Keli'i Martin on 3/18/14.
//  Copyright (c) 2014 WERUreo. All rights reserved.
//

#import "ResultsFetcher.h"
#import "ResultsFetcherDelegate.h"

@implementation ResultsFetcher

- (void)fetchResults
{
    NSString *urlAsString = [NSString stringWithFormat:@"http://data.ny.gov/resource/d6yy-54nr.json"];
    NSURL *url = [NSURL URLWithString:urlAsString];

    NSURLSession *session = [NSURLSession sharedSession];
    [[session dataTaskWithURL:url
           completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
               if (error)
               {
                   [self.delegate fetchingResultsFailedWithError:error];
               }
               else
               {
                   [self.delegate receivedResultsJSON:data];
               }
           }] resume];
}

@end
