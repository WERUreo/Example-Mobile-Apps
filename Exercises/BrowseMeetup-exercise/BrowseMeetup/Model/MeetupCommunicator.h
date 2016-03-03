//
//  MeetupCommunicator.h
//  BrowseMeetup
//
//  Created by Keli'i Martin on 3/5/14.
//  Copyright (c) 2014 WERUreo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@protocol MeetupCommunicatorDelegate;

@interface MeetupCommunicator : NSObject
@property (weak, nonatomic) id<MeetupCommunicatorDelegate> delegate;

- (void)searchGroupsAtCoordinate:(CLLocationCoordinate2D)coordinate;
@end
