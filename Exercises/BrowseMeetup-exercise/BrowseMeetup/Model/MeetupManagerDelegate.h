//
//  MeetupManagerDelegate.h
//  BrowseMeetup
//
//  Created by Keli'i Martin on 3/5/14.
//  Copyright (c) 2014 WERUreo. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol MeetupManagerDelegate <NSObject>
- (void)didReceiveGroups:(NSArray *)groups;
- (void)fetchingGroupsFailedWithError:(NSError *)error;
@end
