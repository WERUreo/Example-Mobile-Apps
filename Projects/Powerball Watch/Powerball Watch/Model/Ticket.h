//
//  Pick.h
//  Powerball Watch
//
//  Created by Keli'i Martin on 3/7/14.
//  Copyright (c) 2014 WERUreo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Ticket : NSObject
@property (strong, nonatomic) NSDate *drawDate;
@property (strong, nonatomic) NSMutableArray *numbers; // of NSNumber
@property (strong, nonatomic) NSNumber *powerballNumber;
@property (strong, nonatomic) NSNumber *multiplier;
@end
