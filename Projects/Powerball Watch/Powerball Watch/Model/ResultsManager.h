//
//  ResultsManager.h
//  Powerball Watch
//
//  Created by Keli'i Martin on 3/18/14.
//  Copyright (c) 2014 WERUreo. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "ResultsFetcherDelegate.h"
#import "ResultsManagerDelegate.h"

@class ResultsFetcher;

@interface ResultsManager : NSObject<ResultsFetcherDelegate>
@property (strong, nonatomic) ResultsFetcher *fetcher;
@property (weak, nonatomic) id<ResultsManagerDelegate> delegate;

- (void)fetchResults;
@end
