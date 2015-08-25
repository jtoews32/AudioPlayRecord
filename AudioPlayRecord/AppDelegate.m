//
//  AppDelegate.m
//  drawingDemo
//
//  Created by David Rowland on 11/3/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "AppDelegate.h"
#import "INWAudioRecordView.h"
#import "INWAudioPlayerView.h"

@implementation AppDelegate

@synthesize window = _window;
@synthesize myView;


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];

    CGRect frame = [self.window frame];
    // myView = [[INWAudioRecordView alloc] initWithFrame:frame];
    
    /*
    test_1440358600433.102051.m4a
    test_3_1440358795015.395020.m4a
    */
    
    myView = [[INWAudioPlayerView alloc] initWithFrame:frame audioFilename:@"test_3_1440358795015.395020.m4a"];
    
    [self.window addSubview:myView];
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {}
- (void)applicationDidEnterBackground:(UIApplication *)application {}
- (void)applicationWillEnterForeground:(UIApplication *)application {}
- (void)applicationDidBecomeActive:(UIApplication *)application {}
- (void)applicationWillTerminate:(UIApplication *)application {}

@end
