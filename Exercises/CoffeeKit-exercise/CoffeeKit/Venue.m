//
//  Venue.m
//  CoffeeKit
//
//  Created by Keli'i Martin on 3/23/14.
//  Copyright (c) 2014 WERUreo. All rights reserved.
//

#import "Venue.h"
#import "Location.h"

@implementation Venue

////////////////////////////////////////////////////////////

#pragma mark - MKAnnotation

////////////////////////////////////////////////////////////

- (CLLocationCoordinate2D)coordinate
{
    CLLocationCoordinate2D coordinate;

    coordinate.latitude = [self.location.lat doubleValue];
    coordinate.longitude = [self.location.lng doubleValue];

    return coordinate;
}

////////////////////////////////////////////////////////////

- (NSString *)title
{
    return self.name;
}

////////////////////////////////////////////////////////////

- (NSString *)subtitle
{
    return [NSString stringWithFormat:@"%@ %@, %@",
            self.location.address, self.location.city, self.location.state];
}

////////////////////////////////////////////////////////////

@end
