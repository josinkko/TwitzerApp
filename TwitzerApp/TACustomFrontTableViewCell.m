//
//  TACustomTableViewCell.m
//  TwitzerApp
//
//  Created by Johanna Sinkkonen on 27/03/14.
//  Copyright (c) 2014 Johanna Sinkkonen. All rights reserved.
//

#import "TACustomFrontTableViewCell.h"
#import "TATweet.h"

@implementation TACustomFrontTableViewCell

- (void)layoutSubviews
{
    self.backgroundColor = [UIColor colorWithRed:(81/255.0) green:(161/255.0) blue:(202/255.0) alpha:1.0];
    UILabel *statusLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, 300, 34)];
    statusLabel.font = [UIFont fontWithName:@"Georgia" size:18.0];
    statusLabel.textColor = [UIColor whiteColor];
    statusLabel.text = _tweetForCell.statusMessage;
    
    self.layer.shadowOffset = CGSizeMake(1, 1);
    self.layer.shadowColor = [[[UIColor blackColor] colorWithAlphaComponent:0.3] CGColor];
    self.layer.shadowOpacity = 1.0;
    CGRect shadowFrame = self.layer.bounds;
    CGPathRef shadowPath = [UIBezierPath bezierPathWithRect:shadowFrame].CGPath;
    self.layer.shadowPath = shadowPath;
    
    [self addSubview:statusLabel]; 
}

@end
