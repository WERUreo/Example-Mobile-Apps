//
//  ShowLocationViewController.m
//  CoffeeKit
//
//  Created by Keli'i Martin on 3/24/14.
//  Copyright (c) 2014 WERUreo. All rights reserved.
//

#import "ShowLocationViewController.h"
#import "Venue.h"

@interface ShowLocationViewController () <MKMapViewDelegate>

@end

@implementation ShowLocationViewController

////////////////////////////////////////////////////////////

#pragma mark - Setters/Getters

////////////////////////////////////////////////////////////

- (void)setMapView:(MKMapView *)mapView
{
    _mapView = mapView;
    self.mapView.showsUserLocation = YES;
    self.mapView.delegate = self;

    [self updateAnnotations];
}

////////////////////////////////////////////////////////////

- (void)updateAnnotations
{
    [self.mapView removeAnnotations:self.mapView.annotations];
    [self.mapView addAnnotations:@[self.venue]];
    [self.mapView showAnnotations:@[self.venue] animated:YES];

    //[self.mapView viewForAnnotation:self.venue];
    [self.mapView selectAnnotation:self.venue animated:YES];
}

////////////////////////////////////////////////////////////

#pragma mark - MKMapViewDelegate

////////////////////////////////////////////////////////////

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
{
    static NSString *reuseID = @"ShowLocationViewController";
    MKAnnotationView *view = [mapView dequeueReusableAnnotationViewWithIdentifier:reuseID];

    if (!view)
    {
        view = [[MKPinAnnotationView alloc] initWithAnnotation:annotation
                                               reuseIdentifier:reuseID];
        view.canShowCallout = YES;
    }

    view.annotation = annotation;
    return view;
}

////////////////////////////////////////////////////////////

@end
