//
//  MyDrawingView.h
//  navAndViews
//
//  Created by David Rowland on 7/31/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import <MediaPlayer/MediaPlayer.h>
#import <AVFoundation/AVFoundation.h>
#import "GradientButton.h"

@interface INWAudioRecordView : UIView <AVAudioRecorderDelegate, AVAudioPlayerDelegate, UIAlertViewDelegate>
{
  GradientButton* _stopButton;
  GradientButton* _recordButton;
  GradientButton* _pauseButton;
  GradientButton* _playButton;
  GradientButton* _saveButton;
  AVAudioRecorder* _audioRecorder;
  AVAudioPlayer* _audioPlayer;
  CAShapeLayer *shapeLayer;  //used for certain animations
}


-(void)buttonHit:(id)sender;
-(void)stopButtonHit:(id)sender;
-(void)recordButtonHit:(id)sender;
-(void)pauseButtonHit:(id)sender;
-(void)playButtonHit:(id)sender;
-(void)saveButtonHit:(id)sender;

@end
