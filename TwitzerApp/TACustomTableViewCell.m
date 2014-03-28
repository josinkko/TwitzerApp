//
//  TACustomTableViewCell.m
//  TwitzerApp
//
//  Created by Johanna Sinkkonen on 27/03/14.
//  Copyright (c) 2014 Johanna Sinkkonen. All rights reserved.
//

#import "TACustomTableViewCell.h"
#import "TATweet.h"

@implementation TACustomTableViewCell

- (void)layoutSubviews
{
    [super layoutSubviews];

    self.backgroundColor = [UIColor colorWithRed:(81/255.0) green:(161/255.0) blue:(202/255.0) alpha:1.0];
    UIView *overlay = [[UIView alloc] initWithFrame:CGRectMake(0, 7, 320, 55)];
    overlay.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.1];
    
    CGFloat cornerRadius = 22.0;
    UIView *imageViewContainer = [[UIView alloc] initWithFrame:CGRectMake(10, 12, 44, 44)];

    imageViewContainer.layer.shadowOffset = CGSizeMake(0, 1);
    imageViewContainer.layer.shadowOpacity = 0.8;
    imageViewContainer.layer.shadowRadius = 1.0;
    imageViewContainer.layer.shadowColor = [UIColor blackColor].CGColor;
    imageViewContainer.layer.shadowPath = [[UIBezierPath bezierPathWithRoundedRect:imageViewContainer.bounds
                                                                      cornerRadius:cornerRadius] CGPath];
    UIImageView *avatarImageView = [[UIImageView alloc] init];
    avatarImageView.layer.cornerRadius = cornerRadius;
    avatarImageView.layer.masksToBounds = YES;
    avatarImageView.frame = imageViewContainer.bounds;
    
    NSURL *imageURL = [NSURL URLWithString:_tweetForCell.avatarImageURL];
    NSError *error = nil;
    [avatarImageView setImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:imageURL options:0 error:&error]]];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(64, 15, 200, 20)];
    titleLabel.text = _tweetForCell.username;
    titleLabel.font = [UIFont fontWithName:@"Georgia" size:17.0];
    titleLabel.textColor = [UIColor whiteColor];
    
    UILabel *timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(75, 30, 200, 20)];
    timeLabel.text = _tweetForCell.dateOfTweet;
    timeLabel.font = [UIFont fontWithName:@"Helvetica Neue" size:11.0];
    timeLabel.textColor = [UIColor whiteColor];
    
    _statusLabel.text = _tweetForCell.statusMessage;

    [imageViewContainer addSubview:avatarImageView];
    [overlay addSubview:titleLabel];
    [overlay addSubview:timeLabel];
    [self addSubview:_statusLabel];
    [self addSubview:overlay];
    [self addSubview:imageViewContainer];
}


@end
