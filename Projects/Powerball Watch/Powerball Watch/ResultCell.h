//
//  ResultCell.h
//  Powerball Watch
//
//  Created by Keli'i Martin on 3/7/14.
//  Copyright (c) 2014 WERUreo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ResultCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *winningNumbersLabel;
@property (weak, nonatomic) IBOutlet UILabel *multiplierLabel;
@end
