//
//  MasterViewController.m
//  CoffeeKit
//
//  Created by Keli'i Martin on 3/23/14.
//  Copyright (c) 2014 WERUreo. All rights reserved.
//

#import "MasterViewController.h"
#import <RestKit/Restkit.h>
#import <CoreLocation/CoreLocation.h>
#import "Venue.h"
#import "Location.h"
#import "VenueCell.h"
#import "Stats.h"
#import "ShowLocationViewController.h"

#define kCLIENTID @"QOF2ASJ1CSPQDQ24D4TMHJF1DEL5I1VDXH5CNIFBRDZMRLXP"
#define kCLIENTSECRET @"IN4ZAMFDM4RYE1QU04N5WGCIFNY0PXML0YCSY5GYFZAWLU11"

@interface MasterViewController ()
@property (nonatomic, strong) NSArray *venues;
@property (nonatomic, strong) CLLocationManager *locationManager;
@end

@implementation MasterViewController

////////////////////////////////////////////////////////////

#pragma mark - Setters/Getters

////////////////////////////////////////////////////////////

- (CLLocationManager *)locationManager
{
    if (!_locationManager)
    {
        _locationManager = [[CLLocationManager alloc] init];
        _locationManager.distanceFilter = kCLDistanceFilterNone;
        _locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters;
        [_locationManager startUpdatingLocation];
    }
    return _locationManager;
}

////////////////////////////////////////////////////////////

#pragma mark - Lifecycle

////////////////////////////////////////////////////////////

- (void)awakeFromNib
{
    [super awakeFromNib];
}

////////////////////////////////////////////////////////////

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self configureRestKit];
    [self loadVenues];
}

////////////////////////////////////////////////////////////

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

////////////////////////////////////////////////////////////

#pragma mark - RestKit

////////////////////////////////////////////////////////////

- (void)configureRestKit
{
    // initialize AFNetworking HTTPClient
    NSURL *baseURL = [NSURL URLWithString:@"https://api.foursquare.com"];
    AFHTTPClient *client = [[AFHTTPClient alloc] initWithBaseURL:baseURL];

    // initialize RestKit
    RKObjectManager *objectManager = [[RKObjectManager alloc] initWithHTTPClient:client];

    // setup object mappings
    RKObjectMapping *venueMapping = [RKObjectMapping mappingForClass:[Venue class]];
    [venueMapping addAttributeMappingsFromArray:@[@"name"]];

    // register mappings with the provider using a response descriptor
    RKResponseDescriptor *responseDescriptor =
    [RKResponseDescriptor responseDescriptorWithMapping:venueMapping
                                                 method:RKRequestMethodGET
                                            pathPattern:@"/v2/venues/search"
                                                keyPath:@"response.venues"
                                            statusCodes:[NSIndexSet indexSetWithIndex:200]];

    [objectManager addResponseDescriptor:responseDescriptor];

    // define location object mapping
    RKObjectMapping *locationMapping = [RKObjectMapping mappingForClass:[Location class]];
    [locationMapping addAttributeMappingsFromArray:@[@"address", @"city", @"country", @"crossStreet", @"postalCode", @"state", @"distance", @"lat", @"lng"]];

    // define relationship mapping
    [venueMapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"location" toKeyPath:@"location" withMapping:locationMapping]];

    RKObjectMapping *statsMapping = [RKObjectMapping mappingForClass:[Stats class]];
    [statsMapping addAttributeMappingsFromDictionary:@{@"checkinsCount": @"checkins", @"tipsCount": @"tips", @"usersCount": @"users"}];

    [venueMapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"stats" toKeyPath:@"stats" withMapping:statsMapping]];
}

////////////////////////////////////////////////////////////

- (void)loadVenues
{
    NSString *latLon = [NSString stringWithFormat:@"%f,%f",
                        self.locationManager.location.coordinate.latitude,
                        self.locationManager.location.coordinate.longitude];
    NSString *clientID = kCLIENTID;
    NSString *clientSecret = kCLIENTSECRET;

    NSDictionary *queryParams = @{@"ll" : latLon,
                                  @"client_id" : clientID,
                                  @"client_secret" : clientSecret,
                                  @"categoryId" : @"4bf58dd8d48988d1e0931735",
                                  @"v" : @"20140118"};

    [[RKObjectManager sharedManager] getObjectsAtPath:@"/v2/venues/search"
                                           parameters:queryParams
                                              success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
                                                  self.venues = [mappingResult.array sortedArrayUsingDescriptors:[NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"location.distance" ascending:YES]]];
                                                  [self.tableView reloadData];
                                              }
                                              failure:^(RKObjectRequestOperation *operation, NSError *error) {
                                                  NSLog(@"What do you mean by 'there is no coffee?': %@", error);
                                              }];
    [self.locationManager stopUpdatingLocation];
}

////////////////////////////////////////////////////////////

#pragma mark - Table View Data Source

////////////////////////////////////////////////////////////

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

////////////////////////////////////////////////////////////

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.venues.count;
}

////////////////////////////////////////////////////////////

#pragma mark - UITableViewDelegate

////////////////////////////////////////////////////////////

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    VenueCell *cell = [tableView dequeueReusableCellWithIdentifier:@"VenueCell" forIndexPath:indexPath];

    Venue *venue = self.venues[indexPath.row];
    cell.nameLabel.text = venue.name;
    cell.distanceLabel.text = [NSString stringWithFormat:@"%.0fm", venue.location.distance.floatValue];
    cell.checkinsLabel.text = [NSString stringWithFormat:@"%d checkins", venue.stats.checkins.intValue];
    
    return cell;
}

////////////////////////////////////////////////////////////

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

////////////////////////////////////////////////////////////

#pragma mark - Navigation

////////////////////////////////////////////////////////////

- (void)prepareViewController:(id)vc forSegue:(NSString *)segueIdentifier fromIndexPath:(NSIndexPath *)indexPath
{
    if ([vc isKindOfClass:[ShowLocationViewController class]])
    {
        if (![segueIdentifier length] || [segueIdentifier isEqualToString:@"Show Location"])
        {
            ShowLocationViewController *slvc = (ShowLocationViewController *)vc;
            Venue *venue = self.venues[indexPath.row];
            slvc.venue = venue;
            slvc.title = venue.name;
        }
    }
}

////////////////////////////////////////////////////////////

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSIndexPath *indexPath = nil;
    if ([sender isKindOfClass:[UITableViewCell class]])
    {
        indexPath = [self.tableView indexPathForCell:sender];
    }
    [self prepareViewController:segue.destinationViewController
                       forSegue:segue.identifier
                  fromIndexPath:indexPath];
}

////////////////////////////////////////////////////////////

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    id detailvc = [self.splitViewController.viewControllers lastObject];
    if ([detailvc isKindOfClass:[UINavigationController class]])
    {
        detailvc = [((UINavigationController *)detailvc).viewControllers firstObject];
        [self prepareViewController:detailvc
                           forSegue:nil
                      fromIndexPath:indexPath];
    }
}

////////////////////////////////////////////////////////////

@end
