//
//  Vehicle.m
//  GettersSetters
//
//  Created by Keli'i Martin on 2/25/16.
//  Copyright © 2016 WERUreo. All rights reserved.
//

#import "Vehicle.h"

@implementation Vehicle

-(void)setOdometer:(long)odometer
{
    if (odometer > _odometer)
    {
        _odometer = odometer;
    }
}

-(NSString *)model
{
    if ([_model isEqualToString:@"Honda Civic"])
    {
        return @"POS";
    }
    else
    {
        return _model;
    }
}

@end
