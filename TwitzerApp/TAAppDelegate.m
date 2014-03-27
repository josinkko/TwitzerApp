//
//  TAAppDelegate.m
//  TwitzerApp
//
//  Created by Johanna Sinkkonen on 27/03/14.
//  Copyright (c) 2014 Johanna Sinkkonen. All rights reserved.
//

#import "TAAppDelegate.h"
#import "TATableViewController.h"

@implementation TAAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    TATableViewController *tableViewController = [[TATableViewController alloc] init];
    self.window.rootViewController = tableViewController;
    
//    self.window.bounds = CGRectMake(0, -20, self.window.frame.size.width, self.window.frame.size.height);
    
    [self.window makeKeyAndVisible];
    return YES;
}



@end
