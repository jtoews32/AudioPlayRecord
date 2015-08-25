
#import "INWAudioPlayerView.h"

@implementation INWAudioPlayerView


- (instancetype)initWithFrame:(CGRect)frame audioFilename:(NSString *) audioFilename
{
    CGRect frame1 = CGRectMake(20, 80, frame.size.width-40, 90);
    
    self = [super initWithFrame:frame1];
    if (self) {
        UIColor* color = [UIColor colorWithRed:64.0/255.0 green:144.0/255.0 blue:224.0/255.0
                                       alpha:1.0f];
      
        [self setBackgroundColor:color];
      
        _playButton = [[GradientButton alloc] initWithFrame:CGRectMake(10, 10, 44, 40)];
        [_playButton setTitle:@"Play" forState:UIControlStateNormal];
        [_playButton addTarget:self action:@selector(playButtonHit:) forControlEvents:UIControlEventTouchUpInside];
        [_playButton setShowsTouchWhenHighlighted:YES];
        [_playButton.titleLabel setFont:[_playButton.titleLabel.font fontWithSize:14.0]];
        
        _stopButton = [[GradientButton alloc] initWithFrame:CGRectMake(55, 10, 44, 40)];
        [_stopButton setTitle:@"Stop" forState:UIControlStateNormal];
        [_stopButton addTarget:self action:@selector(stopButtonHit:) forControlEvents:UIControlEventTouchUpInside];
        [_stopButton setShowsTouchWhenHighlighted:YES];
        [_stopButton.titleLabel setFont:[_stopButton.titleLabel.font fontWithSize:14.0]];
        
        _pauseButton = [[GradientButton alloc] initWithFrame:CGRectMake(100, 10, 44, 40)];
        [_pauseButton setTitle:@"Pause" forState:UIControlStateNormal];
        [_pauseButton addTarget:self action:@selector(pauseButtonHit:) forControlEvents:UIControlEventTouchUpInside];
        [_pauseButton setShowsTouchWhenHighlighted:YES];
        [_pauseButton.titleLabel setFont:[_pauseButton.titleLabel.font fontWithSize:14.0]];
        
        [self addSubview:_playButton];
        [self addSubview:_pauseButton];
        [self addSubview:_stopButton];
 
        [_playButton useWhiteActionSheetStyle];
        [_stopButton useWhiteActionSheetStyle];
        [_pauseButton useWhiteActionSheetStyle];

        NSString *docsDir = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
        NSString *soundFilePath = [docsDir stringByAppendingPathComponent:audioFilename ];
        NSURL *soundFileURL = [NSURL fileURLWithPath:soundFilePath];

        NSError *error;
        
        _audioPlayer = [[AVAudioPlayer alloc]
                                      initWithContentsOfURL:soundFileURL error:&error];
        
        
        if (error)
        {
            NSLog(@"error: %@", [error localizedDescription]);
        } else {
            _audioPlayer.delegate = self;
            [_audioPlayer prepareToPlay];
        }

        
        shapeLayer = [CAShapeLayer layer];
        [[self layer] addSublayer:shapeLayer];
    
  }
  return self;
}

-(void)stopButtonHit:(id)sender {
 
    /*
    _stopButton.enabled = NO;
    _playButton.enabled = YES;
     */
    
    if (_audioPlayer.playing) {
        [_audioPlayer stop];
    }
}

-(void)pauseButtonHit:(id)sender {
}

-(void)playButtonHit:(id)sender {
    
    [_audioPlayer play];
    
    
    
    
   // _stopButton.enabled = YES;
   
    
    /*
    NSError *error;
        
    _audioPlayer = [[AVAudioPlayer alloc]
            initWithContentsOfURL:_audioRecorder.url
        error:&error];
        
    _audioPlayer.delegate = self;
        
    if (error)
        NSLog(@"Error: %@",
                  [error localizedDescription]);
    else {
            [_audioPlayer play];
    }
     */
}

-(void)audioPlayerDidFinishPlaying: (AVAudioPlayer *)player successfully:(BOOL)flag
{
    // _stopButton.enabled = NO;
}

-(void)audioPlayerDecodeErrorDidOccur: (AVAudioPlayer *)player error:(NSError *)error
{
    NSLog(@"Decode Error occurred");
}

-(void)audioRecorderDidFinishRecording: (AVAudioRecorder *)recorder successfully:(BOOL)flag
{
    NSLog(@"WTF");
}

-(void)audioRecorderEncodeErrorDidOccur:(AVAudioRecorder *)recorder error:(NSError *)error
{
    NSLog(@"Encode Error occurred");
}

@end
