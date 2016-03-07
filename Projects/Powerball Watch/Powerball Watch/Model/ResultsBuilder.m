//
//  ResultsBuilder.m
//  Powerball Watch
//
//  Created by Keli'i Martin on 3/17/14.
//  Copyright (c) 2014 WERUreo. All rights reserved.
//

#import "ResultsBuilder.h"
#import "Ticket.h"

@implementation ResultsBuilder

////////////////////////////////////////////////////////////

+ (NSDate *)dateFromDateString:(NSString *)dateString
{
    NSDate *date = [[NSDate alloc] init];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    NSLocale *enUSPOSIXLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
    [dateFormatter setLocale:enUSPOSIXLocale];
    [dateFormatter setDateFormat:@"yyyy'-'MM'-'dd'T'HH':'mm':'ss"];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"America/New_York"]];
    date = [dateFormatter dateFromString:dateString];

    return date;
}

////////////////////////////////////////////////////////////

+ (NSNumber *)numberFromString:(NSString *)numberString
{
    NSLog(@"numberString: %@", numberString);
    NSNumber *number = [[NSNumber alloc] init];
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    number = [numberFormatter numberFromString:numberString];
    return number;
}

////////////////////////////////////////////////////////////

+ (NSMutableArray *)numberArrayFromString:(NSString *)numberString
{
    NSMutableArray *numberArray = [NSMutableArray array];
    NSArray *numberStringArray = [numberString componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    for (NSString *numString in numberStringArray)
    {
        NSNumber *num = [self numberFromString:numString];
        [numberArray addObject:num];
    }

    return numberArray;
}

////////////////////////////////////////////////////////////

+ (NSArray *)resultsFromJSON:(NSData *)objectNotation error:(NSError **)error
{
    NSError *localError = nil;
    NSArray *parsedObject = [NSJSONSerialization JSONObjectWithData:objectNotation
                                                            options:0
                                                              error:&localError];
    if (localError != nil)
    {
        *error = localError;
        return nil;
    }

    NSMutableArray *results = [NSMutableArray array];

    for (NSDictionary *result in parsedObject)
    {
        Ticket *ticket = [[Ticket alloc] init];
        ticket.drawDate = [self dateFromDateString:[result valueForKeyPath:@"draw_date"]];
        ticket.multiplier = [self numberFromString:[result valueForKeyPath:@"multiplier"]];
        NSMutableArray *numArray = [self numberArrayFromString:[result valueForKeyPath:@"winning_numbers"]];
        ticket.powerballNumber = [numArray lastObject];
        [numArray removeLastObject];
        ticket.numbers = numArray;

        [results addObject:ticket];
    }

    return results;
}

////////////////////////////////////////////////////////////

@end
