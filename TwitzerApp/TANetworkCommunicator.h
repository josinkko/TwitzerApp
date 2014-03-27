//
//  TANetworkCommunicator.h
//  TwitzerApp
//
//  Created by Johanna Sinkkonen on 27/03/14.
//  Copyright (c) 2014 Johanna Sinkkonen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TANetworkCommunicator : NSObject

- (NSArray*)retrieveTweetsSynchronousFromURL:(NSString*)url withParams:(NSArray*)params;

@end
