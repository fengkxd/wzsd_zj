//
//  MRVLCPlayer.m
//  MRVLCPlayer
//
//  Created by apple on 16/3/5.
//  Copyright © 2016年 Alloc. All rights reserved.
//

#import "MRVLCPlayer.h"
#import <MediaPlayer/MediaPlayer.h>
#import <AVFoundation/AVFoundation.h>
#import "MRVideoConst.h"


static const NSTimeInterval kVideoPlayerAnimationTimeinterval = 0.3f;

@interface MRVLCPlayer ()
{
    
    BOOL  wifiFlag;
    CGRect _originFrame;
}
@property (nonatomic,strong) VLCMediaPlayer *player;
@end

@implementation MRVLCPlayer

#pragma mark - Life Cycle
- (instancetype)init {
    if (self = [super init]) {
        
        [self setupNotification];
        
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setupNotification];
    }
    return self;
}


- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    
    [self setupPlayer];
    
    [self setupView];
    
    [self setupControlView];
}

-(void) stopPlay{
    [self.player stop];
    self.player.delegate = nil;
    self.player.drawable = nil;
    self.player = nil;
    // 注销通知
    [[UIDevice currentDevice] endGeneratingDeviceOrientationNotifications];
    [[NSNotificationCenter defaultCenter] removeObserver:self];

}

#pragma mark - Public Method
- (void)showInView:(UIView *)view {
    
    NSAssert(_mediaURL != nil, @"MRVLCPlayer Exception: mediaURL could not be nil!");
    
    [view addSubview:self];
    
    self.alpha = 0.0;
    [UIView animateWithDuration:kVideoPlayerAnimationTimeinterval animations:^{
        self.alpha = 1.0;
    } completion:^(BOOL finished) {
        [self play];
    }];
}

- (void)dismiss {
    [self.player stop];
    self.player.delegate = nil;
    self.player.drawable = nil;
    self.player = nil;
    
    // 注销通知
    [[UIDevice currentDevice] endGeneratingDeviceOrientationNotifications];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
//    [self removeFromSuperview];
    self.dismissBlock();
}

#pragma mark - Private Method
- (void)setupView {
    [self setBackgroundColor:[UIColor blackColor]];
}

- (void)setupPlayer {
    [self.player setDrawable:self];
    //self.player.media = [[VLCMedia alloc] initWithURL:self.mediaURL];
    self.player.media = [VLCMedia mediaWithURL:self.mediaURL];
  
//    
//    VLCLibrary *sharedLibrary = [VLCLibrary sharedLibrary];
//    sharedLibrary.debugLogging = YES;
//    VLCMediaThumbnailer *thumbnailer = [VLCMediaThumbnailer thumbnailerWithMedia:self.player.media delegate:self andVLCLibrary:[VLCLibrary sharedLibrary]];
//    [thumbnailer fetchThumbnail];
//
}


//- (void)mediaThumbnailerDidTimeOut:(VLCMediaThumbnailer *)mediaThumbnailer
//{
//    NSLog(@"%s: %@", __PRETTY_FUNCTION__, mediaThumbnailer);
//}
//
//- (void)mediaThumbnailer:(VLCMediaThumbnailer *)mediaThumbnailer didFinishThumbnail:(CGImageRef)thumbnail
//{
//    NSLog(@"%s: %@", __PRETTY_FUNCTION__, mediaThumbnailer);
//}
//

- (void)setupControlView {

    [self addSubview:self.controlView];
    
    //添加控制界面的监听方法
    [self.controlView.playButton addTarget:self action:@selector(playButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.controlView.pauseButton addTarget:self action:@selector(pauseButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.controlView.closeButton addTarget:self action:@selector(closeButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.controlView.moreButton addTarget:self action:@selector(moreButtonClick) forControlEvents:UIControlEventTouchUpInside];

    [self.controlView.fullScreenButton addTarget:self action:@selector(fullScreenButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.controlView.shrinkScreenButton addTarget:self action:@selector(shrinkScreenButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.controlView.progressSlider addTarget:self action:@selector(progressClick) forControlEvents:UIControlEventTouchUpInside];
    
    [self.controlView.progressSlider addTarget:self action:@selector(sliderValueChanged:) forControlEvents:UIControlEventValueChanged];

}

- (void)setupNotification {
    
    [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(orientationHandler)
                                                 name:UIDeviceOrientationDidChangeNotification
                                               object:nil
     ];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(applicationWillEnterForeground)
                                                 name:UIApplicationWillEnterForegroundNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(applicationWillResignActive)
                                                 name:UIApplicationWillResignActiveNotification
                                               object:nil];
}

/**
 *    强制横屏
 *
 *    @param orientation 横屏方向
 */
- (void)forceChangeOrientation:(UIInterfaceOrientation)orientation
{
    int val = orientation;
    if ([[UIDevice currentDevice] respondsToSelector:@selector(setOrientation:)]) {
        SEL selector = NSSelectorFromString(@"setOrientation:");
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:[UIDevice instanceMethodSignatureForSelector:selector]];
        [invocation setSelector:selector];
        [invocation setTarget:[UIDevice currentDevice]];
        [invocation setArgument:&val atIndex:2];
        [invocation invoke];
    }
}

#pragma mark Notification Handler
/**
 *    屏幕旋转处理
 */
- (void)orientationHandler {
    
    if (UIDeviceOrientationIsLandscape([UIDevice currentDevice].orientation)) {
        self.isFullscreenModel = YES;
        
    }else {
        self.isFullscreenModel = NO;
    }
    [self.controlView autoFadeOutControlBar];
}

/**
 *    即将进入后台的处理
 */
- (void)applicationWillEnterForeground {
    [self play];
}

/**
 *    即将返回前台的处理
 */
- (void)applicationWillResignActive {
    [self pause];
}


#pragma mark Button Event
- (void)playButtonClick {
    
    [self play];
    
}

- (void)pauseButtonClick {
    
    [self pause];
}

- (void)closeButtonClick {
    [self dismiss];
}

- (void)moreButtonClick {
    self.moreBlock();
}


- (void)fullScreenButtonClick {
    
    [self forceChangeOrientation:UIInterfaceOrientationLandscapeRight];

}

- (void)shrinkScreenButtonClick {
    
    [self forceChangeOrientation:UIInterfaceOrientationPortrait];;
}

- (void)progressClick {

    int targetIntvalue = (int)(self.controlView.progressSlider.value * (float)kMediaLength.intValue);
    
    VLCTime *targetTime = [[VLCTime alloc] initWithInt:targetIntvalue];
    
    [self.player setTime:targetTime];
    
    [self.controlView autoFadeOutControlBar];
}


- (void)sliderValueChanged:(id)sender {
    UISlider *slider = (UISlider *)sender;
    NSLog(@"------%f",slider.value);
}




#pragma mark Player Logic
- (void)play {
    [self.player play];
    self.controlView.playButton.hidden = YES;
    self.controlView.pauseButton.hidden = NO;
    [self.controlView autoFadeOutControlBar];
}

- (void)pause {
    [self.player pause];
    self.controlView.playButton.hidden = NO;
    self.controlView.pauseButton.hidden = YES;
    [self.controlView autoFadeOutControlBar];
}

- (void)stop {
    [self.player stop];
    self.controlView.progressSlider.value = 0;
    self.controlView.playButton.hidden = NO;
    self.controlView.pauseButton.hidden = YES;
    self.controlView.indicatorView.hidden = YES;

}

#pragma mark - Delegate
#pragma mark VLC



- (void)mediaPlayerTitleChanged:(NSNotification *)aNotification{
    NSLog(@"mediaPlayerTitleChanged:");

}

- (void)mediaPlayerChapterChanged:(NSNotification *)aNotification{

    NSLog(@"mediaPlayerChapterChanged:");

}

- (void)mediaPlayerSnapshot:(NSNotification *)aNotification{
    NSLog(@"mediaPlayerSnapshot:");


}



- (void)mediaPlayerStateChanged:(NSNotification *)aNotification {
    NSLog(@"mediaPlayerStateChanged:%zi",self.player.state);

    // Every Time change the state,The VLC will draw video layer on this layer.
    [self bringSubviewToFront:self.controlView];
    if (self.player.media.state == VLCMediaStateBuffering) {
        self.controlView.indicatorView.hidden = NO;
        self.controlView.bgLayer.hidden = NO;
    }else if (self.player.media.state == VLCMediaStatePlaying) {
        self.controlView.indicatorView.hidden = YES;
        self.controlView.bgLayer.hidden = YES;
    }else if (self.player.state == VLCMediaPlayerStateStopped) {
        [self stop];
    }else {
        self.controlView.indicatorView.hidden = NO;
        self.controlView.bgLayer.hidden = NO;
    }
    
}

- (void)mediaPlayerTimeChanged:(NSNotification *)aNotification {
    [self bringSubviewToFront:self.controlView];
    if (self.controlView.progressSlider.state != UIControlStateNormal) {
        return;
    }
    
    float precentValue = ([[self.player.time value] floatValue]) / ([[kMediaLength value] floatValue]);
    if ([[self.player.time value] integerValue] > 1000) {
        self.updateWatchNumBlock();
    }
    
//    NSLog(@"-%d-%d----%f",[self.player.remainingTime intValue] ,[self.player.time intValue],[[kMediaLength value] floatValue]);

   [self.controlView.progressSlider setValue:precentValue animated:YES];
    [self.controlView.timeLabel setText:[NSString stringWithFormat:@"%@/%@",_player.time.stringValue,kMediaLength.stringValue]];
    WS(weakSelf);
    
    if ([[Utility getObjectForkey:WIFI_PLAY] boolValue]) {
        AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
        [manager startMonitoring];
        [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
//            NSLog(@"网络状态%zi",status);
            if (status != AFNetworkReachabilityStatusReachableViaWiFi) {
                if (!wifiFlag) {
                    wifiFlag = YES;
                    [weakSelf stop];
                    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"您正在非wifi状态下观看此视频" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
                    [alertView show];
                }
            }
        } ];
    }
}




#pragma mark ControlView
- (void)controlViewFingerMoveLeft {
    
    [self.player shortJumpBackward];
    
}

- (void)controlViewFingerMoveRight {

    [self.player shortJumpForward];
    
}

- (void)controlViewFingerMoveUp {
    
    self.controlView.volumeSlider.value += 0.05;
}

- (void)controlViewFingerMoveDown {
    
    self.controlView.volumeSlider.value -= 0.05;
}

#pragma mark - Property
- (VLCMediaPlayer *)player {
    if (!_player) {
        _player = [[VLCMediaPlayer alloc] init];
        _player.delegate = self;
    }
    return _player;
}

- (MRVideoControlView *)controlView {
    if (!_controlView) {
        _controlView = [[MRVideoControlView alloc] initWithFrame:self.bounds];
        _controlView.delegate = self;
    }
    return _controlView;
}


- (void)setIsFullscreenModel:(BOOL)isFullscreenModel {
    
    if (self.controlView.timeLabel.text == nil) {
        return;
    }
     if (_isFullscreenModel == isFullscreenModel) {
        return;
    }
    
    _isFullscreenModel = isFullscreenModel;
    
    if (isFullscreenModel) {
        _originFrame = self.frame;
        CGFloat height = kMRSCREEN_BOUNDS.size.width;
        CGFloat width = kMRSCREEN_BOUNDS.size.height;
        CGRect frame = CGRectMake((height - width) / 2, (width - height) / 2, width, height);
        [UIView animateWithDuration:kVideoPlayerAnimationTimeinterval animations:^{
            /**
             *    此判断是为了适配项目在Deployment Info中是否勾选了横屏
             */
            if (UIDeviceOrientationIsLandscape([UIDevice currentDevice].orientation)) {
                if ([UIDevice currentDevice].orientation == UIDeviceOrientationLandscapeLeft) {
                    self.frame = frame;
                    self.transform = CGAffineTransformMakeRotation(M_PI_2);
 
                }else{
                    self.frame = frame;
                    self.transform = CGAffineTransformMakeRotation(-M_PI_2);
                 }
            }else {
                self.frame = self.frame = kMRSCREEN_BOUNDS;
            }
            self.controlView.frame = self.bounds;
            [self.controlView layoutIfNeeded];
            self.controlView.fullScreenButton.hidden = YES;
            self.controlView.shrinkScreenButton.hidden = NO;
        } completion:^(BOOL finished) {}];
        
    }else {
        [UIView animateWithDuration:kVideoPlayerAnimationTimeinterval animations:^{
            self.transform = CGAffineTransformIdentity;
            self.frame = _originFrame;
            self.controlView.frame = self.bounds;
            [self.controlView layoutIfNeeded];
            self.controlView.fullScreenButton.hidden = NO;
            self.controlView.shrinkScreenButton.hidden = YES;
            
        } completion:^(BOOL finished) {}];

        
    }

}


@end
