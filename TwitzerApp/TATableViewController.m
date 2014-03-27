//
//  TATableViewController.m
//  TwitzerApp
//
//  Created by Johanna Sinkkonen on 27/03/14.
//  Copyright (c) 2014 Johanna Sinkkonen. All rights reserved.
//

#import "TATableViewController.h"
#import "TANetworkCommunicator.h"
#import "TATweet.h"
#import "TACustomFrontTableViewCell.h"
#import "TACustomBackTableViewCell.h"

@implementation TATableViewController
{
    NSArray *tweets;
    NSIndexPath *selectedIndex;
    TANetworkCommunicator *networkCommunicator;
    UIActivityIndicatorView *activityIndicator;
}

- (void)viewDidLoad
{
    networkCommunicator = [[TANetworkCommunicator alloc] init];
    [self styleTableView];
    [self populateTableView];
}

- (void)styleTableView
{
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

- (void)populateTableView
{
    NSArray *params = [NSArray arrayWithObject:@"twitzer"];
    
    activityIndicator = [[UIActivityIndicatorView alloc]
                         initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    activityIndicator.center = self.view.center;
    [self.view addSubview:activityIndicator];
    
    [activityIndicator startAnimating];
    tweets = [networkCommunicator retrieveTweetsSynchronousFromURL:TWITZER_TIMELINE_URL withParams:params];
    [activityIndicator stopAnimating];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([indexPath isEqual:selectedIndex]) {
        TATweet *tweet = [tweets objectAtIndex:indexPath.row];
        UIFont *fontForLabel = [UIFont fontWithName:@"Georgia" size:18.0];
        
        CGSize dynamicCellSize = [tweet.statusMessage boundingRectWithSize:CGSizeMake(300, MAXFLOAT)
                                                                     options:NSStringDrawingUsesLineFragmentOrigin
                                                                  attributes:@{
                                                                               NSFontAttributeName : fontForLabel
                                                                               }
                                                                     context:nil].size;
        
        return dynamicCellSize.height + 72;
    }
    return 44;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [tweets count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TATweet *currentTweet = [tweets objectAtIndex:indexPath.row];
    
    static NSString *customFrontCellIdentifier = @"customFrontCell";
    static NSString *customBackCellIdentifier = @"customBackCell";
    
    id cell;
    
    if (![indexPath isEqual:selectedIndex]) {
        if(!cell) {
            cell = [[TACustomFrontTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:customFrontCellIdentifier];
        } else {
            cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        }
        [(TACustomFrontTableViewCell*)cell setTweetForCell:currentTweet];
        [(TACustomFrontTableViewCell*)cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        
    } else if ([indexPath isEqual:selectedIndex]) {
        if (!cell) {
            cell = [[TACustomBackTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:customBackCellIdentifier];
        } else {
            cell  = [tableView dequeueReusableCellWithIdentifier:@"customCell"];
        }
        [(TACustomBackTableViewCell*)cell setTweetForCell:currentTweet];
        [(TACustomBackTableViewCell*)cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
    return cell;
}

- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (![indexPath isEqual:selectedIndex]) {
        NSMutableArray *indexes = [NSMutableArray arrayWithCapacity:2];
        [indexes addObject:indexPath];
        if (selectedIndex) [indexes addObject:selectedIndex];
        selectedIndex = indexPath;
        [tableView reloadRowsAtIndexPaths:indexes withRowAnimation:UITableViewRowAnimationAutomatic];
    }
    return indexPath;
}

@end
