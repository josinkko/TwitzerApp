//
//  TATweet.h
//  TwitzerApp
//
//  Created by Johanna Sinkkonen on 27/03/14.
//  Copyright (c) 2014 Johanna Sinkkonen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TATweet : NSObject

@property (nonatomic, copy) NSString *username;
@property (nonatomic, copy) NSString *statusMessage;
@property (nonatomic, copy) NSString *avatarImageURL;
@property (nonatomic, copy) NSString *dateOfTweet;

- (id)initWithDict:(NSDictionary*)dict;

@end
