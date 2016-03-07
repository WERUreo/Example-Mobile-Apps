//
//  ResultsFetcher.h
//  Powerball Watch
//
//  Created by Keli'i Martin on 3/18/14.
//  Copyright (c) 2014 WERUreo. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ResultsFetcherDelegate;

@interface ResultsFetcher : NSObject
@property (weak, nonatomic) id<ResultsFetcherDelegate> delegate;

- (void)fetchResults;
@end
