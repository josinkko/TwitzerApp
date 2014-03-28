//
//  TANetworkCommunicator.m
//  TwitzerApp
//
//  Created by Johanna Sinkkonen on 27/03/14.
//  Copyright (c) 2014 Johanna Sinkkonen. All rights reserved.
//
/*
 Notes: This class downloads the JSON from twitzerFeed and parses into TATweet-objects.
 [self createFeedFromJSON:] - checks for exception and does the parsing.
 TweetDate is parsed with NSDateFormatter in [self formatDate:];
 
 */

#import "TANetworkCommunicator.h"
#import "TATweet.h"

@implementation TANetworkCommunicator

- (NSArray*)retrieveTweetsSynchronousFromURL:(NSString*)url withParams:(NSArray*)params
{
    NSMutableString *urlString = [NSMutableString stringWithString:url];
    for (NSString *param in params) {
        [urlString appendString:[NSString stringWithFormat:@"%@/", param]];
    }
    
    NSURL *fetchURL = [NSURL URLWithString:urlString];
    NSURLResponse *resp;
    NSError *err;
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:fetchURL];
    
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&resp error:&err];
    NSArray *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:&err];

    return [self createTweetsFromJSON:json];
}

- (NSArray*)createTweetsFromJSON:(NSArray*)jsonArray
{
    NSMutableArray *tweets = [[NSMutableArray alloc] init];
    for (int i = 0; i < jsonArray.count; i++) {
        
        NSMutableDictionary *tweetDictionary = [[NSMutableDictionary alloc] init];
        NSDictionary *jsonForArrayItem = jsonArray[i];
        
        if ([jsonForArrayItem[@"date"] length] == 10) {
            double dateAsDouble = [jsonForArrayItem[@"date"] doubleValue];
            NSDate *tweetDate = [NSDate dateWithTimeIntervalSince1970:dateAsDouble];
            [tweetDictionary setValue:[NSString stringWithString:[self formatDate:tweetDate]] forKey:@"dateOfTweet"];
        }
        if (jsonForArrayItem[@"user"] != [NSNull null]) {
            NSString *usernameFormatted = [jsonForArrayItem[@"user"] stringByReplacingOccurrencesOfString:@"/" withString:@"@"];
            [tweetDictionary setValue:usernameFormatted forKey:@"username"];
        }
        if (jsonForArrayItem[@"text"] != [NSNull null]) {
            [tweetDictionary setValue:jsonForArrayItem[@"text"] forKey:@"statusMessage"];
        }
        if (jsonForArrayItem[@"img"] != [NSNull null]) {
            [tweetDictionary setValue:jsonForArrayItem[@"img"] forKey:@"imageURL"];
        }
        TATweet *currentTweet = [[TATweet alloc] initWithDict:tweetDictionary];
        [tweets addObject:currentTweet];
        
    }
    return [NSArray arrayWithArray:tweets];
}

- (NSString*)formatDate:(NSDate*)tweetDate
{
    NSString *dateString = [[NSString alloc] init];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSInteger desiredComponents = (NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit);
    
    NSDate *now = [NSDate date];
    
    NSDateComponents *firstComponents = [calendar components:desiredComponents fromDate:now];
    NSDateComponents *secondComponents = [calendar components:desiredComponents fromDate:tweetDate];
    
    NSDate *truncatedFirst = [calendar dateFromComponents:firstComponents];
    NSDate *truncatedSecond = [calendar dateFromComponents:secondComponents];
    
    NSComparisonResult result = [truncatedFirst compare:truncatedSecond];
    
    if (result == NSOrderedSame) {
        dateString = @"today";
    }  else {
        NSDateFormatter *weekdayFormatter = [[NSDateFormatter alloc] init];
        NSArray *daysOfWeek = @[@"Sun", @"Mon", @"Tue", @"Wed", @"Thu", @"Fri", @"Sat"];
        [weekdayFormatter setDateFormat:@"e"];
        
        NSInteger weekdayNumber = (NSInteger)[[weekdayFormatter stringFromDate:tweetDate] integerValue];

        [weekdayFormatter setDateFormat:@"dd"];
        dateString = [NSString stringWithFormat:@"%@ %@", daysOfWeek[weekdayNumber], [weekdayFormatter stringFromDate:tweetDate]];
        
    }
    return dateString;
}

@end
