//
//  AppDelegate.m
//  jot
//
//  Created by Laura Skelton on 4/30/15.
//  Copyright (c) 2015 IFTTT. All rights reserved.
//

#import "AppDelegate.h"
#import "ExampleViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    _window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    UIViewController *exampleViewController = [ExampleViewController new];
    self.window.rootViewController = exampleViewController;
    [self.window makeKeyAndVisible];
    
    return YES;
}

@end
