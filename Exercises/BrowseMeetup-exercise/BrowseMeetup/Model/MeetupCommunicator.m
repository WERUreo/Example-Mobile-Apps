//
//  MeetupCommunicator.m
//  BrowseMeetup
//
//  Created by Keli'i Martin on 3/5/14.
//  Copyright (c) 2014 WERUreo. All rights reserved.
//

#import "MeetupCommunicator.h"
#import "MeetupCommunicatorDelegate.h"

#define API_KEY @"5344e412447814605d63d5f2e4751"
#define PAGE_COUNT 20

@implementation MeetupCommunicator

- (void)searchGroupsAtCoordinate:(CLLocationCoordinate2D)coordinate
{
    NSString *urlAsString = [NSString stringWithFormat:@"https://api.meetup.com/2/groups?lat=%f&lon=%f&page=%d&key=%@", coordinate.latitude, coordinate.longitude, PAGE_COUNT, API_KEY];
    NSURL *url = [[NSURL alloc] initWithString:urlAsString];
    NSLog(@"%@", urlAsString);

    [NSURLConnection sendAsynchronousRequest:[[NSURLRequest alloc] initWithURL:url]
                                       queue:[[NSOperationQueue alloc] init]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
                               if (connectionError)
                               {
                                   [self.delegate fetchingGroupsFailedWithError:connectionError];
                               }
                               else
                               {
                                   [self.delegate receivedGroupsJSON:data];
                               }
                           }];
}

@end
