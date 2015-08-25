#import "INWAudioRecordView.h"

@implementation INWAudioRecordView

- (instancetype)initWithFrame:(CGRect)frame
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
        
        
        _recordButton = [[GradientButton alloc] initWithFrame:CGRectMake(145, 10, 44, 40)];
        [_recordButton setTitle:@"Rec" forState:UIControlStateNormal];
        [_recordButton addTarget:self action:@selector(recordButtonHit:) forControlEvents:UIControlEventTouchUpInside];
        [_recordButton setShowsTouchWhenHighlighted:YES];
        [_recordButton.titleLabel setFont:[_recordButton.titleLabel.font fontWithSize:14.0]];
        
        _saveButton = [[GradientButton alloc] initWithFrame:CGRectMake(205, 10, 44, 40)];
        [_saveButton setTitle:@"Save" forState:UIControlStateNormal];
        [_saveButton addTarget:self action:@selector(saveButtonHit:) forControlEvents:UIControlEventTouchUpInside];
        [_saveButton setShowsTouchWhenHighlighted:YES];
        [_saveButton.titleLabel setFont:[_saveButton.titleLabel.font fontWithSize:14.0]];
        
        
        [self addSubview:_recordButton];
        [self addSubview:_playButton];
        [self addSubview:_pauseButton];
        [self addSubview:_stopButton];
        [self addSubview:_saveButton];
        
        
        
        [_playButton useWhiteActionSheetStyle]; // useGreenStyle];
        [_stopButton useWhiteActionSheetStyle]; // useGreenConfirmStyle];
        [_pauseButton useWhiteActionSheetStyle];
        [_recordButton useWhiteActionSheetStyle]; //useRedDeleteStyle];
        [_saveButton useWhiteActionSheetStyle];
        
        
        [_playButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_playButton setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
        
        
        [_stopButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_stopButton setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
        
        
        [_pauseButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_pauseButton setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
        
        
        [_recordButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_recordButton setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
        
        [_saveButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_saveButton setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
        
        
        //   _playButton.enabled = NO;
        // _stopButton.enabled = NO;
        //  _pauseButton.enabled = NO;
        //  _saveButton.enabled = NO;
        
        NSString *docsDir = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
        NSString *soundFilePath = [docsDir stringByAppendingPathComponent:@"audio.m4a"];
        NSURL *soundFileURL = [NSURL fileURLWithPath:soundFilePath];

        NSDictionary *recordSettings = [NSDictionary dictionaryWithObjectsAndKeys:
                                        [NSNumber numberWithInt:kAudioFormatMPEG4AAC], AVFormatIDKey,
                                        [NSNumber numberWithInt:AVAudioQualityMin], AVEncoderAudioQualityKey,
                                        [NSNumber numberWithInt: 1], AVNumberOfChannelsKey,
                                        [NSNumber numberWithFloat:8000.0], AVSampleRateKey,
                                        nil];
        
        NSError *error = nil;
        
        AVAudioSession *audioSession = [AVAudioSession sharedInstance];
        [audioSession setCategory:AVAudioSessionCategoryPlayAndRecord
                            error:nil];
        
        _audioRecorder = [[AVAudioRecorder alloc]
                          initWithURL:soundFileURL
                          settings:recordSettings
                          error:&error];
        
        if (error)
        {
            NSLog(@"error: %@", [error localizedDescription]);
        } else {
            [_audioRecorder prepareToRecord];
        }
        
        
        
        //For the more elaborate animations we must deal with a CAShapeLayer which we add to this UIView.
        shapeLayer = [CAShapeLayer layer];
        [[self layer] addSublayer:shapeLayer];
        
    }
    return self;
}



// Override drawRect to perform custom drawing.
- (void)drawRect:(CGRect)rect
{
    //  CGContextRef context = UIGraphicsGetCurrentContext();
    //  [self drawCircleInContext:context];
    // [self fillEllipseInContext:context];
    // [self drawPathInContext:context];
    // [self drawTextInContext:context];
    // [self drawImageInContext:context];
    // [self drawImageInContext1:context];
    // [self drawPathAnimated];
}




-(void)stopButtonHit:(id)sender {
    
    // _stopButton.enabled = NO;
    //  _playButton.enabled = YES;
    //  _recordButton.enabled = YES;
    
    if (_audioRecorder.recording)
    {
        [_pauseButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_pauseButton setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
        
        
        [_stopButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_stopButton setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
        
        [_saveButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_saveButton setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
        
        [_recordButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_recordButton setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
        
        
        [_playButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_playButton setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
        
        
        
        [_audioRecorder stop];
    } else if (_audioPlayer.playing) {
        
        
        
        [_pauseButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_pauseButton setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
        
        
        [_stopButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_stopButton setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
        
        [_saveButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_saveButton setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
        
        [_recordButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_recordButton setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
        
        
        [_playButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_playButton setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
        
        
        
        [_audioPlayer stop];
    }
    
    
}

-(void)recordButtonHit:(id)sender {
    // [self resetBackgroundColor];
    // [_recordButton setBackgroundColor:[UIColor redColor]]; // useRedDeleteStyle]; // setBackgroundColor:[UIColor redColor]];
    [_recordButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [_recordButton setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
    
    [_stopButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_stopButton setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
    
    [_playButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_playButton setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    
    
    [_saveButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_saveButton setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    
    
    
    // [self setNeedsDisplay];
    // [_recordButton useRedDeleteStyle];
    
    
    
    if (!_audioRecorder.recording)
    {
        //  _playButton.enabled = NO;
        //  _stopButton.enabled = YES;
        [_audioRecorder record];
    }
    
}

-(void)saveButtonHit:(id)sender {
    
    
    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Save the audio" message:@"enter a name" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Save", nil];
    
    [alert setTag:9999];
    
    alert.alertViewStyle = UIAlertViewStylePlainTextInput;
    UITextField * alertTextField = [alert textFieldAtIndex:0];
    alertTextField.keyboardType = UIKeyboardTypeDefault;
    alertTextField.placeholder = @"audio name";
    
    [alert show];
    
}

-(void)pauseButtonHit:(id)sender {
 
    
    if (_audioPlayer.playing) {
        
        [_pauseButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [_pauseButton setTitleColor:[UIColor blueColor] forState:UIControlStateHighlighted];
        
        [_playButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_playButton setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
        
        
        [_audioPlayer pause];
        
    } else {
        
        [_playButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [_playButton setTitleColor:[UIColor blueColor] forState:UIControlStateHighlighted];
        
        [_pauseButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_pauseButton setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
        
        
        [_audioPlayer play];
    }
 
}

-(void)playButtonHit:(id)sender {

    
    if (_audioRecorder.recording || _audioPlayer.playing || _playButton.titleLabel.textColor == [UIColor whiteColor]) {
        return;
        
    }

    [_stopButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_stopButton setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
    
    [_pauseButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_pauseButton setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
    
    [_saveButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_saveButton setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    
    [_recordButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_recordButton setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    
    [_playButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [_playButton setTitleColor:[UIColor blueColor] forState:UIControlStateHighlighted];
    
    
    
    
    if (!_audioRecorder.recording)
    {
        /// _stopButton.enabled = YES;
        //_recordButton.enabled = NO;
        
        NSError *error;
        
        _audioPlayer = [[AVAudioPlayer alloc]
                        initWithContentsOfURL:_audioRecorder.url
                        error:&error];
        
        _audioPlayer.delegate = self;
        
        if (error)
            NSLog(@"Error: %@",
                  [error localizedDescription]);
        else
            [_audioPlayer play];
    }
}



-(void)audioPlayerDidFinishPlaying: (AVAudioPlayer *)player successfully:(BOOL)flag
{
    // [self resetBackgroundColor];
    
    
    [_pauseButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_pauseButton setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    
    
    [_stopButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_stopButton setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    
    [_saveButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_saveButton setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
    
    [_recordButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_recordButton setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
    
    
    [_playButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_playButton setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
    
    
    
    // _recordButton.enabled = YES;
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




- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 9999) {
        NSString *audioName =[alertView textFieldAtIndex:0].text;
        NSTimeInterval today = ([[NSDate date] timeIntervalSince1970] * 1000);
        NSString *intervalString = [NSString stringWithFormat:@"%f", today];
        
        if ( [ audioName length] == 0 ) {
            audioName = intervalString;
        }
        NSString *fileName = [NSString stringWithFormat:@"%@%@%@%@", audioName, @"_", intervalString, @".m4a"];
        NSString *button = [alertView buttonTitleAtIndex:buttonIndex];
        if ([button isEqualToString:@"Save"]){

            NSFileManager *fileManager = [NSFileManager defaultManager];
            NSString *docsDir = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
            NSString *currentPath = [docsDir  stringByAppendingPathComponent:@"therapydailyAudio.m4a"];
            NSString *newPath = [docsDir  stringByAppendingPathComponent:fileName];
            [fileManager moveItemAtPath:currentPath toPath:newPath error:nil];
            NSNumber *category = [NSNumber numberWithInt:1];
            
        }
        
        
    }
    
    
}









@end
