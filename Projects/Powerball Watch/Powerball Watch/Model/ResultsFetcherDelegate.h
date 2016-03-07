//
//  ResultsFetcherDelegate.h
//  Powerball Watch
//
//  Created by Keli'i Martin on 3/18/14.
//  Copyright (c) 2014 WERUreo. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ResultsFetcherDelegate <NSObject>
- (void)receivedResultsJSON:(NSData *)objectNotation;
- (void)fetchingResultsFailedWithError:(NSError *)error;
@end
