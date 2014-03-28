//
//  TANetworkCommunicator.h
//  TwitzerApp
//
//  Created by Johanna Sinkkonen on 27/03/14.
//  Copyright (c) 2014 Johanna Sinkkonen. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol TANetworkCommunicatorDelegate
- (void)retriveFromNetworkCommunicator:(NSArray*)foundTweets;
@end

@interface TANetworkCommunicator : NSObject

@property (retain) id <NSObject, TANetworkCommunicatorDelegate> delegate;
- (void)retrieveTweetsAsynchronousFromURL:(NSString*)url withParams:(NSArray*)params;

@end
