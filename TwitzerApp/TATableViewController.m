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
#import "TACustomTableViewCell.h"

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
    networkCommunicator.delegate = self;
    
    [self styleTableView];
    [self populateTableView];
}

- (void)retriveFromNetworkCommunicator:(NSArray *)foundTweets
{
    tweets = foundTweets;
    [self.tableView reloadData];
    [activityIndicator stopAnimating];
}

- (void)styleTableView
{
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [UIColor colorWithRed:(81/255.0) green:(161/255.0) blue:(202/255.0) alpha:1.0];
    self.tableView.contentInset = UIEdgeInsetsMake(20, 0, 0, 0);
}

- (void)populateTableView
{
    NSArray *params = [NSArray arrayWithObject:@"twitzer"];
    
    activityIndicator = [[UIActivityIndicatorView alloc]
                         initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    activityIndicator.center = self.tableView.center;
    [self.tableView addSubview:activityIndicator];
    [activityIndicator startAnimating];
    [networkCommunicator retrieveTweetsAsynchronousFromURL:TWITZER_TIMELINE_URL withParams:params];

////    dispatch_sync(dispatch_get_main_queue(), ^{
////        tweets = [networkCommunicator retrieveTweetsSynchronousFromURL:TWITZER_TIMELINE_URL withParams:params];
////        [activityIndicator stopAnimating];
////    });
//    
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//                    
//        
//        
//        dispatch_async(dispatch_get_main_queue(), ^{
//
//        });
//    });
//    
////    dispatch_sync(dispatch_get_main_queue(), ^{
//        [networkCommunicator retrieveTweetsAsynchronousFromURL:TWITZER_TIMELINE_URL withParams:params];
//        [activityIndicator stopAnimating];
//    });

//
//
//    [activityIndicator startAnimating];
//
//    [activityIndicator stopAnimating];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([indexPath isEqual:selectedIndex]) {
        TATweet *tweet = [tweets objectAtIndex:indexPath.row];
        UIFont *fontForLabel = [UIFont fontWithName:@"Georgia" size:18.0];
        
        CGSize dynamicCellSize = [tweet.statusMessage boundingRectWithSize:CGSizeMake(300, MAXFLOAT)
                                                                     options:NSStringDrawingUsesLineFragmentOrigin
                                                                  attributes:@{NSFontAttributeName : fontForLabel}
                                                                     context:nil].size;
        
        return dynamicCellSize.height + 77;
    }
    return 110;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [tweets count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TATweet *currentTweet = [tweets objectAtIndex:indexPath.row];
    
    static NSString *customCellIdentifier = @"customCell";

    TACustomTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:customCellIdentifier];
    
    if(!cell) {
        cell = [[TACustomTableViewCell alloc] init];
    }
    
    cell.tweetForCell = currentTweet;
    cell.statusLabel = [[UILabel alloc] init];
    cell.statusLabel.font = [UIFont fontWithName:@"Georgia" size:18.0];
    cell.statusLabel.textColor = [UIColor whiteColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.statusLabel.numberOfLines = 0;
    
    if (![indexPath isEqual:selectedIndex]) {

        cell.statusLabel.frame = CGRectMake(10, 60, 300, 55);
        
    } else if ([indexPath isEqual:selectedIndex]) {
        CGSize statusLabelDynamicSize = [currentTweet.statusMessage boundingRectWithSize:CGSizeMake(300, MAXFLOAT)
                                                  options:NSStringDrawingUsesLineFragmentOrigin
                                             attributes:@{ NSFontAttributeName : cell.statusLabel.font}
                                                  context:nil].size;
        
        cell.statusLabel.frame = CGRectMake(10, 70, 300, statusLabelDynamicSize.height);
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
