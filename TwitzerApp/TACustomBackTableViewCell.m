//
//  TACustomBackTableViewCell.m
//  TwitzerApp
//
//  Created by Johanna Sinkkonen on 27/03/14.
//  Copyright (c) 2014 Johanna Sinkkonen. All rights reserved.
//

#import "TACustomBackTableViewCell.h"
#import "TATweet.h"
@implementation TACustomBackTableViewCell

-(void)layoutSubviews
{
    self.backgroundColor = [UIColor colorWithRed:(81/255.0) green:(161/255.0) blue:(202/255.0) alpha:1.0];
    UIView *overlay = [[UIView alloc] initWithFrame:CGRectMake(0, 7, 320, 55)];
    overlay.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.1];
    
    CGFloat cornerRadius = 22.0;
    UIView *imageViewContainer = [[UIView alloc] initWithFrame:CGRectMake(10, 12, 44, 44)];

    imageViewContainer.layer.shadowOffset = CGSizeMake(0, 1);
    imageViewContainer.layer.shadowOpacity = 0.8;
    imageViewContainer.layer.shadowRadius = 1.0;
    imageViewContainer.layer.shadowColor = [UIColor blackColor].CGColor;
    imageViewContainer.layer.shadowPath = [[UIBezierPath bezierPathWithRoundedRect:imageViewContainer.bounds cornerRadius:cornerRadius] CGPath];

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

    UILabel *statusLabel = [[UILabel alloc] init];
    statusLabel.font = [UIFont fontWithName:@"Georgia" size:18.0];
    statusLabel.textColor = [UIColor whiteColor];
    
    statusLabel.text = _tweetForCell.statusMessage;
    
    CGSize statusLabelDynamicSize = [statusLabel.text boundingRectWithSize:CGSizeMake(300, MAXFLOAT)
                                          options:NSStringDrawingUsesLineFragmentOrigin
                                       attributes:@{
                                                    NSFontAttributeName : statusLabel.font
                                                    }
                                          context:nil].size;
    
    CGFloat statusLabelHeight = statusLabelDynamicSize.height;

    statusLabel.frame = CGRectMake(10, 65, 300, statusLabelHeight);
    
    statusLabel.numberOfLines = 0;
    
    
    self.layer.shadowOffset = CGSizeMake(1, 1);
    self.layer.shadowColor = [[[UIColor blackColor] colorWithAlphaComponent:0.3] CGColor];
    self.layer.shadowOpacity = 1.0;
    CGRect shadowFrame = self.layer.bounds;
    CGPathRef shadowPath = [UIBezierPath bezierPathWithRect:shadowFrame].CGPath;
    self.layer.shadowPath = shadowPath;
    
    [imageViewContainer addSubview:avatarImageView];
    [overlay addSubview:titleLabel];
    [overlay addSubview:timeLabel];
    [self addSubview:statusLabel];
    [self addSubview:overlay];
    [self addSubview:imageViewContainer];
}

@end
