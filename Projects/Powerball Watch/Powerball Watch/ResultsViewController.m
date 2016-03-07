//
//  ResultsViewController.m
//  Powerball Watch
//
//  Created by Keli'i Martin on 3/7/14.
//  Copyright (c) 2014 WERUreo. All rights reserved.
//

#import "ResultsViewController.h"
#import "ResultCell.h"
#import "ResultsManager.h"
#import "ResultsFetcher.h"
#import "Ticket.h"
#import "FLLotteryViewController.h"

@interface ResultsViewController () <ResultsManagerDelegate>
@property (strong, nonatomic) ResultsManager *manager;
@end

@implementation ResultsViewController

////////////////////////////////////////////////////////////

#pragma mark - Setters/getters

////////////////////////////////////////////////////////////

- (void)setResults:(NSArray *)results
{
    _results = results;
    [self.tableView reloadData];
}

////////////////////////////////////////////////////////////

- (ResultsManager *)manager
{
    if (!_manager)
    {
        _manager = [[ResultsManager alloc] init];
        _manager.fetcher = [[ResultsFetcher alloc] init];
        _manager.fetcher.delegate = _manager;
        _manager.delegate = self;
    }

    return _manager;
}

////////////////////////////////////////////////////////////

#pragma mark - View controller lifecycle

////////////////////////////////////////////////////////////

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self fetchResults];
}

////////////////////////////////////////////////////////////

- (IBAction)fetchResults
{
    [self.refreshControl beginRefreshing];
    [self.manager fetchResults];
}

////////////////////////////////////////////////////////////

#pragma mark - ResultsManagerDelegate

////////////////////////////////////////////////////////////

- (void)didReceiveResults:(NSArray *)results
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.refreshControl endRefreshing];
        self.results = results;
    });
}

////////////////////////////////////////////////////////////

- (void)fetchingResultsFailedWithError:(NSError *)error
{
    NSLog(@"Error %@: %@", error, [error localizedDescription]);
}

////////////////////////////////////////////////////////////

- (NSString *)dateStringFromDate:(NSDate *)date
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterLongStyle];
    [dateFormatter setTimeStyle:NSDateFormatterNoStyle];
    NSString *dateString = [dateFormatter stringFromDate:date];
    return dateString;
}

////////////////////////////////////////////////////////////

#pragma mark - Table view data source

////////////////////////////////////////////////////////////

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

////////////////////////////////////////////////////////////

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.results count];
}

////////////////////////////////////////////////////////////

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Results Cell";
    ResultCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    if ([self.results[indexPath.row] isKindOfClass:[Ticket class]])
    {
        Ticket *ticket = (Ticket *)self.results[indexPath.row];
        cell.dateLabel.text = [self dateStringFromDate:ticket.drawDate];
        NSAttributedString *powerballNumber = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@", ticket.powerballNumber]
                                                                              attributes:@{ NSForegroundColorAttributeName : [UIColor redColor] }];
        NSLog(@"%@", powerballNumber);
        NSMutableAttributedString *numbers = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@ %@ %@ %@ %@ ",
                                                                                                ticket.numbers[0], ticket.numbers[1],
                                                                                                ticket.numbers[2], ticket.numbers[3],
                                                                                                ticket.numbers[4]]];
        [numbers appendAttributedString:powerballNumber];
        cell.winningNumbersLabel.attributedText = numbers;
        if (ticket.multiplier)
        {
            cell.multiplierLabel.text = [NSString stringWithFormat:@"x%@", ticket.multiplier];
        }
    }

    return cell;
}

////////////////////////////////////////////////////////////

#pragma mark - Navigation

////////////////////////////////////////////////////////////
/*
- (void)prepareViewController:(id)vc forSegue:(NSString *)segueIdentifier fromIndexPath:(NSIndexPath *)indexPath
{
    if ([vc isKindOfClass:[FLLotteryViewController class]])
    {
        if (![segueIdentifier length] || [segueIdentifier isEqualToString:@"Show Web Site"])
        {
            FLLotteryViewController *fvc = (FLLotteryViewController *)vc;
            fvc.drawDate = [self.results[[self.tableView indexPathForSelectedRow].row] drawDate];
            fvc.title = [self dateStringFromDate:fvc.drawDate];
            [fvc loadWebView];
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
*/
////////////////////////////////////////////////////////////

@end
