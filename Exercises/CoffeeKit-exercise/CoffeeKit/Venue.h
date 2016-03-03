//
//  Venue.h
//  CoffeeKit
//
//  Created by Keli'i Martin on 3/23/14.
//  Copyright (c) 2014 WERUreo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@class Location;
@class Stats;

@interface Venue : NSObject <MKAnnotation>
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) Location *location;
@property (nonatomic, strong) Stats *stats;
@end
