//
//  TATwit.m
//  TwitzerApp
//
//  Created by Johanna Sinkkonen on 27/03/14.
//  Copyright (c) 2014 Johanna Sinkkonen. All rights reserved.
//

#import "TATweet.h"

@implementation TATweet

- (id)initWithDict:(NSDictionary*)dict
{
    self = [super init];
    if (self) {
        self.username = dict[@"username"];
        self.avatarImageURL = dict[@"imageURL"];
        self.statusMessage = dict[@"statusMessage"];
        self.dateOfTweet = dict[@"dateOfTweet"];
    }
    return self;
}

@end
