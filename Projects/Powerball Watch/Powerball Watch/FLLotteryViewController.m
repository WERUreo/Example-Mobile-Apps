//
//  FLLotteryViewController.m
//  Powerball Watch
//
//  Created by Keli'i Martin on 3/21/14.
//  Copyright (c) 2014 WERUreo. All rights reserved.
//

#import "FLLotteryViewController.h"

static const NSString *urlFront = @"http://www.flalottery.com/site/winningNumberSearch.do?searchTypeIn=date&gameNameIn=POWERBALL&singleDateIn=";
static const NSString *urlBack = @"&fromDateIn=&toDateIn=&n1In=&n2In=&n3In=&n4In=&n5In=&pbIn=&submitForm=Submit";

@interface FLLotteryViewController () <UIWebViewDelegate, UISplitViewControllerDelegate>

@end

@implementation FLLotteryViewController

////////////////////////////////////////////////////////////

- (void)setDrawDate:(NSDate *)drawDate
{
    _drawDate = drawDate;
}

////////////////////////////////////////////////////////////

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.webView.delegate = self;
    [self loadFLLotteryHomePage];
}

////////////////////////////////////////////////////////////

- (void)loadFLLotteryHomePage
{
    NSString *urlString = @"http://www.flalottery.com/";
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:request];
}

////////////////////////////////////////////////////////////

- (void)loadWebView
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"MM/dd/yyyy";
    NSString *dateString = [formatter stringFromDate:self.drawDate];
    NSString *encodedDate = [dateString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString *urlString = [NSString stringWithFormat:@"%@%@%@", urlFront, encodedDate, urlBack];
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:request];
}

////////////////////////////////////////////////////////////

#pragma mark - UIWebViewDelegate

////////////////////////////////////////////////////////////

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [self.loadingIndicator startAnimating];
}

////////////////////////////////////////////////////////////

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [self.loadingIndicator stopAnimating];
}

////////////////////////////////////////////////////////////

#pragma mark - UISplitViewControllerDelegate

////////////////////////////////////////////////////////////

- (void)awakeFromNib
{
    self.splitViewController.delegate = self;
}

////////////////////////////////////////////////////////////

- (BOOL)splitViewController:(UISplitViewController *)svc shouldHideViewController:(UIViewController *)vc inOrientation:(UIInterfaceOrientation)orientation
{
    return UIInterfaceOrientationIsPortrait(orientation);
}

////////////////////////////////////////////////////////////

- (void)splitViewController:(UISplitViewController *)svc willHideViewController:(UIViewController *)aViewController withBarButtonItem:(UIBarButtonItem *)barButtonItem forPopoverController:(UIPopoverController *)pc
{
    barButtonItem.title = aViewController.title;
    self.navigationItem.leftBarButtonItem = barButtonItem;
}

////////////////////////////////////////////////////////////

- (void)splitViewController:(UISplitViewController *)svc willShowViewController:(UIViewController *)aViewController invalidatingBarButtonItem:(UIBarButtonItem *)barButtonItem
{
    self.navigationItem.leftBarButtonItem = nil;
}

@end
