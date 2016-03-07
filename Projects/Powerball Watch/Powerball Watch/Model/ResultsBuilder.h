//
//  ResultsBuilder.h
//  Powerball Watch
//
//  Created by Keli'i Martin on 3/17/14.
//  Copyright (c) 2014 WERUreo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ResultsBuilder : NSObject

+ (NSArray *)resultsFromJSON:(NSData *)objectNotation error:(NSError **)error;

@end
