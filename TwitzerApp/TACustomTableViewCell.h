//
//  TACustomTableViewCell.h
//  TwitzerApp
//
//  Created by Johanna Sinkkonen on 27/03/14.
//  Copyright (c) 2014 Johanna Sinkkonen. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TATweet;

@interface TACustomTableViewCell : UITableViewCell

@property (nonatomic) TATweet *tweetForCell;
@property (nonatomic) UILabel *statusLabel;

@end
