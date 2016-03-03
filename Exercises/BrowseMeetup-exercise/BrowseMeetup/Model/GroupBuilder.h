//
//  GroupBuilder.h
//  BrowseMeetup
//
//  Created by Keli'i Martin on 3/5/14.
//  Copyright (c) 2014 WERUreo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GroupBuilder : NSObject

+ (NSArray *)groupsFromJSON:(NSData *)objectNotation error:(NSError **)error;

@end
