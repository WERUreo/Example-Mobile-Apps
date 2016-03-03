//
//  ShowLocationViewController.h
//  CoffeeKit
//
//  Created by Keli'i Martin on 3/24/14.
//  Copyright (c) 2014 WERUreo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@class Venue;

@interface ShowLocationViewController : UIViewController
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (weak, nonatomic) Venue *venue;
@end
