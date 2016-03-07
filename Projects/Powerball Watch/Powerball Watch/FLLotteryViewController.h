//
//  FLLotteryViewController.h
//  Powerball Watch
//
//  Created by Keli'i Martin on 3/21/14.
//  Copyright (c) 2014 WERUreo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FLLotteryViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *loadingIndicator;
@property (strong, nonatomic) NSDate *drawDate;

- (void)loadWebView;
@end
