//
//  VenueCell.h
//  CoffeeKit
//
//  Created by Keli'i Martin on 3/24/14.
//  Copyright (c) 2014 WERUreo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VenueCell : UITableViewCell

@property (nonatomic, weak) IBOutlet UILabel *nameLabel;
@property (nonatomic, weak) IBOutlet UILabel *distanceLabel;
@property (nonatomic, weak) IBOutlet UILabel *checkinsLabel;

@end
