//
//  AppDelegate.h
//  drawingDemo
//
//  Created by David Rowland on 11/3/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "INWAudioRecordView.h"
#import "INWAudioPlayerView.h"


@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
//@property (strong, nonatomic) INWAudioRecordView *myView;
@property (strong, nonatomic) INWAudioPlayerView *myView;


@end
