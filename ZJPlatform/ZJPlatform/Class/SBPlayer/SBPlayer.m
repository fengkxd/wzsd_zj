//
//  SBView.m
//  SBPlayer
//
//  Created by sycf_ios on 2017/4/10.
//  Copyright © 2017年 shibiao. All rights reserved.
//

#import "SBPlayer.h"
#import "AFNetworkReachabilityManager.h"
#import "Masonry.h"
#import <CNCLiveMediaPlayerFramework/CNCMediaPlayerSDK.h>

@interface SBPlayer (){
    NSInteger count;
  
}

//当前播放url
@property (nonatomic,strong) NSURL *url;
//原始约束
@property (nonatomic,strong) NSArray *oldConstriants;
//添加标题
@property (nonatomic,strong) UILabel *titleLabel;
//加载动画

@property (nonatomic,assign)UIInterfaceOrientation interfaceOrientation;

@property (nonatomic,assign) CGRect rect;
//@property (nonatomic,strong) UIView *viewFullScreen;
@end

@implementation SBPlayer



// 初始化播放器 设置参数
- (void)initPlayer {
    count = 0;
    self.player = [[CNCMediaPlayerController alloc] initWithContentURL:self.url];
    self.player.view.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    [self addSubview:self.player.view];
    [self.player.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
        make.left.mas_equalTo(0);
        
    }];
    self.interfaceOrientation = UIInterfaceOrientationPortrait;
    if (self.player) {
        // setting
        self.setting =  [CNCPlayerSetting defaultSetting];
        [self.player setPlayMode:self.setting.isLive ? CNC_MEDIA_PLAYER_MODE_LIVE : CNC_MEDIA_PLAYER_MODE_VOD];
        [self.player setShouldAutoPlay:self.setting.isAutoPlay];
        [self.player setVideoDecoderMode:self.setting.isHardware ? CNC_VIDEO_DECODER_MODE_HARDWARE : CNC_VIDEO_DECODER_MODE_SOFTWARE];
        [self.player setShouldAutoClearCache:self.setting.isAutoClearCache];
        [self.player setAbleVideoPlayingInBackground:self.setting.isPlayBackground];
        [self.player setDisableVideoDecodeInBackground:self.setting.isDisableDecodeBackground];
        [self.player accelerateOpen:self.setting.isAccelerateOpen];
        [self.player setMixOtherPlayer:self.setting.isMixOtherPlayer];
        [self.player setMinBufferTime:self.setting.minBufferTime];
        [self.player setMaxCacheTime:self.setting.maxCacheTime];
        [self.player superAccelerate:self.setting.isSuperAccelerate];
        [self.player setShouldLowLatencyMode:self.setting.isLowLatencyMode];
        [self.player setHLSAdaptation:self.setting.isHLSAdaptation];
        [self.player setDefaultHLSBitrate:self.setting.HLSDefaultBitrate];
        [self.player setMaxBufferSize:self.setting.maxBufferSize];
        [self.player setScalingMode:CNC_MP_VIDEO_SCALE_MODE_ASPECTFIT];
        if (self.setting.isProxy) {
            switch (self.setting.type) {
                    // socks5
                case 0:
                    [self.player enableSocks5:self.setting.socksUser pwd:self.setting.socksPwd ip:self.setting.socksIP port:self.setting.socksPort];
                    break;
                    // socks4
                case 1:
                    [self.player enableSocks4WithIP:self.setting.socksIP port:self.setting.socksPort];
                    break;
                    // http
                case 2:
                    [self.player enableHttpProxyWithUsername:self.setting.socksUser pwd:self.setting.socksPwd IP:self.setting.socksIP port:self.setting.socksPort isHtpps:self.setting.isHTTPS];
                    break;
                default:
                    break;
            }
        }
    }
    _currentBrightness = _originBrightness = [UIScreen mainScreen].brightness;
    [self.player prepareToPlay];
    [self showLog:@"预准备播放"];

}

//MARK:实例化
-(instancetype)initWithFrame:(CGRect)frame WithUrl:(NSURL *)url{
    self = [super initWithFrame:frame];
    self.rect = frame;
    if (self) {
        _url = url;
        [self initPlayer];
        [self initFullView];
        [self initNotification];

    }
    return self;
}


#pragma mark -- init
// 初始化UI控件
- (void)initFullView {
    // 全屏View
//    UITapGestureRecognizer *_recognizerDisplay1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapAction:)];
//    _recognizerDisplay1.numberOfTapsRequired = 1;
//    self.viewFullScreen = [[UIView alloc] initWithFrame:CGRectZero];
//    self.viewFullScreen.backgroundColor = [UIColor blackColor];
//    [self.viewFullScreen addGestureRecognizer:_recognizerDisplay1];
//    self.viewFullScreen.hidden = YES;
//    [self addSubview:self.viewFullScreen];
//    [self bringSubviewToFront:self.viewFullScreen];
//
//
//    self.viewFullScreen.frame = CGRectMake(0, 0, MainScreenheight, MainScreenWidth);

    

}



- (void)calcWaitTime {
    NSInteger now = [[CNCPlayerCommonFunc getTimeNowWithMilliSecond] integerValue];
    if (now - _startBufferTime > self.setting.minBufferTime + 4000) {
        // 进行提醒
        [self showLog:@"当前网络较差，可降低播放码率"];
        _startBufferTime = now;
    }
}

- (void)cncPlayerloadStateChanged:(NSNotification *)notification {
    NSString *playState = (NSString *)[[notification userInfo] objectForKey:CNCMediaPlayerLoadStateDidChangeUserInfoKey];
    switch ([playState integerValue]) {
        case CNC_MEDIA_LOAD_STATE_STALLED:
            [self showLog:@"缓冲中"];
            self.activityIndeView.hidden = NO;
            _startBufferTime = [[CNCPlayerCommonFunc getTimeNowWithMilliSecond] integerValue];
            // 开启计时器？
            if (_alertChangeBitrateTimer == nil) {
                _alertChangeBitrateTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(calcWaitTime) userInfo:nil repeats:YES];
            }
            break;
        case CNC_MEDIA_LOAD_STATE_PLAYABLE:
            [self showLog:@"缓冲结束，可播放"];
            self.activityIndeView.hidden = YES;
            _startBufferTime = 0;
            if (_alertChangeBitrateTimer != nil) {
                [_alertChangeBitrateTimer invalidate];
                _alertChangeBitrateTimer = nil;
            }
            break;
        case CNC_MEDIA_LOAD_STATE_PLAYTHROUGHOK:
            [self showLog:@"缓冲结束，播放中"];
            self.activityIndeView.hidden = YES;
            _startBufferTime = 0;
            if (_alertChangeBitrateTimer != nil) {
                [_alertChangeBitrateTimer invalidate];
                _alertChangeBitrateTimer = nil;
            }
            break;
        case CNC_MEDIA_LOAD_STATE_UNKNOWN:
            [self showLog:@"缓冲错误"];
            self.activityIndeView.hidden = YES;
            break;
        default:
            break;
    }
}

- (void)cncPlayerDidFinish:(NSNotification *)notification {
    NSString *playState = (NSString *)[[notification userInfo] objectForKey:CNCMediaPlayerPlayDidFinishUserInfoKey];
    NSString *value = [NSString stringWithFormat:@"%@",[[notification userInfo] objectForKey:@"error"]];
    
    switch ([playState integerValue]) {
        case CNC_MEDIA_PLAYER_DID_FINISH_END: {
            [self showLog:@"播放结束"];
        }
            break;
        case CNC_MEDIA_PLAYER_DID_FINISH_ERROR: {
            if (![_lastErrorCode isEqualToString:value]) {
                [self showLog:[NSString stringWithFormat:@"网络不稳定，自动重连...(%@)", value]];
                if (![[self internetStatus] isEqualToString:@"无网络"]) {
                    [self.player reloadWithContentURL:nil fromStart:NO];
                } else {
                    [self showLog:[NSString stringWithFormat:@"无网络，重连失败"]];
                }
                _lastErrorCode = value;
            }
        }
            break;
        default:
            break;
    }
}


// 判断网络状态
- (NSString *)internetStatus {
    AFNetworkReachabilityManager *reachability   = [AFNetworkReachabilityManager managerForDomain:@"www.apple.com"];
    AFNetworkReachabilityStatus internetStatus = reachability.networkReachabilityStatus;
    NSString *net = @"WIFI";
    switch (internetStatus) {
        case AFNetworkReachabilityStatusReachableViaWiFi:
            net = @"WIFI";
            break;
            
        case AFNetworkReachabilityStatusReachableViaWWAN:
            net = @"蜂窝数据";
            //net = [self getNetType ];   //判断具体类型
            break;
            
        case AFNetworkReachabilityStatusNotReachable:
            net = @"无网络";
            
        default:
            break;
    }
    return net;
}

- (void)cncPlayerStatus:(NSNotification *)notification {
    NSString *key_value = [NSString stringWithFormat:@"%@", [[notification userInfo] objectForKey:CNCMediaPlayerStatusKey]];
    NSInteger detail_value = [[NSString stringWithFormat:@"%@", [[notification userInfo] objectForKey:CNCMediaPlayerDetailCode]] integerValue];
    
    CNC_MediaPlayer_ret_Code int_key_value = [[[notification userInfo] valueForKey:CNCMediaPlayerStatusKey] integerValue];
    NSString *msg;
    
    switch (int_key_value) {
        case CNC_MediaPlayer_RCode_Proxy_Port_Connect_Failed:
        {
            msg = [NSString stringWithFormat:@"code:%lu(%@)--%@",(unsigned long)detail_value,key_value,@"代理开启失败(SOCKS4/SOCKS5/HTTP/HTTPS PROXY)"];
            [self showLog:msg];
            _isVideoOver = YES;
        }
            break;
        case CNC_MediaPlayer_RCode_Player_Initialization_Failed:
            msg = [NSString stringWithFormat:@"code:%lu(%@)--%@",(unsigned long)detail_value,key_value,@"播放器初始化失败"];
            [self showLog:msg];
            _isVideoOver = YES;
            break;
        case CNC_MediaPlayer_RCode_Player_Request_Success:
            msg = [NSString stringWithFormat:@"code:%lu(%@)--%@",(unsigned long)detail_value,key_value,@"请求成功"];
            [self showLog:msg];
            break;
        case CNC_MediaPlayer_RCode_Decode_HW_Decoder_Initialization_Failed:
            msg = [NSString stringWithFormat:@"code:%lu(%@)--%@",(unsigned long)detail_value,key_value,@"硬解解码器初始化失败"];
            [self showLog:msg];
            
            break;
        case CNC_MediaPlayer_RCode_Decode_SW_Decoder_Initialization_Failed:
            msg = [NSString stringWithFormat:@"code:%lu(%@)--%@",(unsigned long)detail_value,key_value,@"软解解码器初始化失败"];
            [self showLog:msg];
            
            break;
        case CNC_MediaPlayer_RCode_Decode_Video_Decoding_Failed:
            //            msg = [NSString stringWithFormat:@"code:%lu(%@)--%@",(unsigned long)detail_value,key_value,@"当前帧视频解码失败"];
            
            break;
        case CNC_MediaPlayer_RCode_Decode_Audio_Decoding_Failed:
            //            msg = [NSString stringWithFormat:@"code:%lu(%@)--%@",(unsigned long)detail_value,key_value,@"当前帧音频解码失败"];
            
            break;
        case CNC_MediaPlayer_RCode_Player_Unresolved_URL: {
            msg = [NSString stringWithFormat:@"code:%lu(%@)--%@",(unsigned long)detail_value,key_value,@"无法解析URL"];
            [self showLog:msg];
            //            [_player_ui set_buffer_image_hidden:YES];
            _isVideoOver = YES;
        }
            break;
        case CNC_MediaPlayer_RCode_Parse_URL_Failed: {
            msg = [NSString stringWithFormat:@"code:%lu(%@)--%@",(unsigned long)detail_value,key_value,@"URL解析失败"];
            [self showLog:msg];
            [MBProgressHUD showError:@"播放错误" toView:self];
            //            [_player_ui set_buffer_image_hidden:YES];
            _isVideoOver = YES;
        }
            break;
        case CNC_MediaPlayer_RCode_Player_Connect_Server_Failed: {
            msg = [NSString stringWithFormat:@"code:%lu(%@)--%@",(unsigned long)detail_value,key_value,@"连接服务器失败"];
            [self showLog:msg];
            //            [_player_ui set_buffer_image_hidden:YES];
            _isVideoOver = YES;
        }
            break;
        case CNC_MediaPlayer_RCode_Player_SW_Decoder_Switched_on: {
            msg = [NSString stringWithFormat:@"code:%lu(%@)--%@",(unsigned long)detail_value,key_value,@"硬解初始化失败、转为软解"];
            [self showLog:msg];
        }
            break;
        default:
            break;
    }
}


// 注册通知
- (void)initNotification {

    // 加载状态通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(cncPlayerloadStateChanged:) name:CNCMediaPlayerLoadStateDidChangeNotification object:nil];
    // 播放状态通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(cncPlayerPlayStateChanged:) name:CNCMediaPlayerPlayStateDidChangeNotification object:nil];

    // 播放结束
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(cncPlayerDidFinish:) name:CNCMediaPlayerPlayDidFinishNotification object:nil];
    // 视频比例改变
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(cncPlayerScalingModeChanged) name:CNCMediaPlayerScalingModeDidChangeNotification object:nil];
    // 视频分辨率改变
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(cncPlayerResolutionChanged) name:CNCMediaPlayerResolutionChangedNotification object:nil];
    // 首帧视频
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(cncPlayerFirstVideoRender) name:CNCMediaPlayerFirstVideoFrameRenderedNotification object:nil];
    // 首帧音频
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(cncPlayerFirstAudioRender) name:CNCMediaPlayerFirstAudioFrameRenderedNotification object:nil];
    // seek完成
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(cncPlayerSeekDidFinish) name:CNCMediaPlayerDidSeekCompleteNotification object:nil];
    // 播放器状态
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(cncPlayerStatus:) name:CNCMediaPlayerStatusCodeNotification object:nil];

    // 播放器释放完毕
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(cncPlayerDidShutdown) name:CNCMediaPlayerDidShutdown object:nil];
 
     [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(deviceOrientationDidChange:) name:UIDeviceOrientationDidChangeNotification object:nil];
}




// 刷新播放控件显示
- (void)refreshMediaControl{
    
    if (!_isMediaSliderBeingDragged) {
        NSTimeInterval duration = self.player.duration;
        NSInteger intDuration = floor(duration);
        
        self.controlView.maxValue = intDuration;

        if (self.setting.isLive) {
            self.controlView.totalTime = @"--:--";
        }else{
            self.controlView.totalTime = [NSString stringWithFormat:@"%02d:%02d", (int)(intDuration / 60), (int)(intDuration % 60)];
        }
        // 当前播放位置
        NSTimeInterval position;
        position = self.player.currentPlaybackTime;
        NSInteger intPosition = ceil(position);
        if ((intPosition >= intDuration) && !self.setting.isLive) {
            self.controlView.currentTime = [NSString stringWithFormat:@"%02d:%02d", (int)(intDuration / 60), (int)(intDuration % 60)];
        } else {
            self.controlView.currentTime = [NSString stringWithFormat:@"%02d:%02d", (int)(intPosition / 60), (int)(intPosition % 60)];
        }
        
//        self.controlView.minValue = intDuration;
        self.controlView.value = self.player.currentPlaybackTime;
        if (self.player.playbackState == CNC_PLAYER_STATE_ON_MEDIA_STOP) {
            self.controlView.currentTime = @"00:00";
        }
        if (count>=5) {
            [self setSubViewsIsHide:YES];
        }else{
            [self setSubViewsIsHide:NO];
        }
        count += 1;
    }
  
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(refreshMediaControl) object:nil];

    [self performSelector:@selector(refreshMediaControl) withObject:nil afterDelay:1];
}



// 若是shutdown，则接受不到该通知
- (void)cncPlayerDidShutdown {
    [self showLog:@"播放器释放完毕"];
}


- (void)cncPlayerScalingModeChanged {
    [self showLog:@"切换显示比例"];
}

- (void)cncPlayerResolutionChanged {
    [self showLog:@"视频分辨率改变"];
}

- (void)cncPlayerFirstVideoRender {
    [self showLog:@"首帧视频渲染"];
}

- (void)cncPlayerFirstAudioRender {
    [self showLog:@"首帧音频渲染"];
}

- (void)cncPlayerSeekDidFinish {
    [self showLog:@"seek结束"];
}

- (void)cncPlayerPlayStateChanged:(NSNotification *)notification {
    NSString *playState = (NSString *)[[notification userInfo] objectForKey:CNCMediaPlayerPlayStateDidChangeUserInfoKey];
    switch ([playState integerValue]) {
        case CNC_PLAYER_STATE_ON_MEDIA_START: {
            [self showLog:@"开始播放"];
            [_pauseOrPlayView.imageBtn setSelected:YES];
            [self refreshMediaControl];
        }
            break;
        case CNC_PLAYER_STATE_ON_MEDIA_PAUSE:
            [self showLog:@"暂停播放"];
            [_pauseOrPlayView.imageBtn setSelected:NO];
            break;
        case CNC_PLAYER_STATE_ON_MEDIA_STOP:
            [self showLog:@"停止播放"];
            [_pauseOrPlayView.imageBtn setSelected:NO];
            break;
        case CNC_PLAYER_STATE_ON_MEDIA_SEEKING_FORWARD:
            [self showLog:@"seeking..."];
            break;
        default:
            break;
    }
}





#pragma mark -- private method
- (void)showLog:(NSString *)message {
    NSLog(@"%@",message);
}


//获取当前屏幕显示的viewcontroller
- (UIViewController *)getCurrentVC
{
    UIViewController *result = nil;
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal)
    {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows)
        {
            if (tmpWin.windowLevel == UIWindowLevelNormal)
            {
                window = tmpWin;
                break;
            }
        }
    }
    UIView *frontView = [[window subviews] objectAtIndex:0];
    id nextResponder = [frontView nextResponder];
    if ([nextResponder isKindOfClass:[UIViewController class]])
        result = nextResponder;
    else
        result = window.rootViewController;
    
    while (result.presentedViewController) {
        result = result.presentedViewController;
    }
    
    
    return result;
}
- (void)drawRect:(CGRect)rect {
    [self setupPlayerUI];
}
//MARK: 设置界面 在此方法下面可以添加自定义视图，和删除视图
-(void)setupPlayerUI{
    [self.activityIndeView startAnimating];
    //添加标题
    [self addTitle];
    //添加点击事件
    [self addGestureEvent];
    //添加播放和暂停按钮
    [self addPauseAndPlayBtn];
    //添加控制视图
    [self addControlView];
    //添加加载视图
    [self addLoadingView];
    //初始化时间
    [self initTimeLabels];
}
//初始化时间
-(void)initTimeLabels{
    self.controlView.currentTime = @"00:00";
    self.controlView.totalTime = @"00:00";
}
//添加加载视图
-(void)addLoadingView{
    [self addSubview:self.activityIndeView];
    [self.activityIndeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(@80);
        make.center.mas_equalTo(self);
    }];
}
//添加标题
-(void)addTitle{
    [self addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self);
        make.top.mas_equalTo(self).offset(12);
        make.width.mas_equalTo(self.mas_width);
    }];
}
//添加点击事件
-(void)addGestureEvent{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleTapAction:)];
    tap.delegate = self;
    [self addGestureRecognizer:tap];
    
  
}
-(void)handleTapAction:(UITapGestureRecognizer *)gesture{
    if (self.controlView.alpha == 0) {
        [self setSubViewsIsHide:NO];
       count = 0;
    }else{
        [self setSubViewsIsHide:YES];
        count = 5;

    }
}


//添加播放和暂停按钮
-(void)addPauseAndPlayBtn{
    [self addSubview:self.pauseOrPlayView];
    [self.pauseOrPlayView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self);
    }];
}
//添加控制视图
-(void)addControlView{

    [self addSubview:self.controlView];
    [self.controlView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(self);
        make.height.mas_equalTo(@44);
    }];
    [self layoutIfNeeded];
}
//懒加载ActivityIndicateView
-(UIActivityIndicatorView *)activityIndeView{
    if (!_activityIndeView) {
        _activityIndeView = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        _activityIndeView.hidesWhenStopped = YES;
    }
    return _activityIndeView;
}
//懒加载标题
-(UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.backgroundColor = [UIColor clearColor];
        _titleLabel.font = [UIFont systemFontOfSize:15];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.textColor = [UIColor whiteColor];
        _titleLabel.numberOfLines = 2;
    }
    return _titleLabel;
}
//懒加载暂停或者播放视图
-(SBPauseOrPlayView *)pauseOrPlayView{
    if (!_pauseOrPlayView) {
        _pauseOrPlayView = [[SBPauseOrPlayView alloc]init];
        _pauseOrPlayView.backgroundColor = [UIColor clearColor];
        _pauseOrPlayView.delegate = self;
        _pauseOrPlayView.moreisHidden = self.moreisHidden;
        _pauseOrPlayView.moreisSelected = self.moreisSelected;
    }
    return _pauseOrPlayView;
}
//懒加载控制视图
-(SBControlView *)controlView{
    if (!_controlView) {
        _controlView = [[SBControlView alloc]init];
        _controlView.delegate = self;
        _controlView.backgroundColor = [UIColor clearColor];
        [_controlView.tapGesture requireGestureRecognizerToFail:self.pauseOrPlayView.imageBtn.gestureRecognizers.firstObject];
   
    }
    return _controlView;
}
//设置子视图是否隐藏
-(void)setSubViewsIsHide:(BOOL)isHide{
    
    if (isHide && self.controlView.alpha == 0) {
        return;
    }
    [UIView animateWithDuration:0.3 animations:^{
        self.controlView.alpha = isHide?0:1;
        self.pauseOrPlayView.alpha = isHide?0:1;
        self.titleLabel.alpha = isHide?0:1;
    }];
    
 }
//MARK: SBPauseOrPlayViewDeleagate
-(void)pauseOrPlayView:(SBPauseOrPlayView *)pauseOrPlayView withState:(BOOL)state{
    count = 0;
    if (state) {
        [self play];
    }else{
        [self pause];
    }
}

-(void)hanleBackButton{
    count = 0;
    
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
    _dismissBlock();
}




//MARK: SBControlViewDelegate
-(void)controlView:(SBControlView *)controlView pointSliderLocationWithCurrentValue:(CGFloat)value{
    count = 0;
    _isMediaSliderBeingDragged = NO;
    NSTimeInterval duration = self.player.duration;
    NSTimeInterval position = duration * value;
    position = self.player.currentPlaybackTime;
    NSInteger intPosition = ceil(position);
    self.controlView.currentTime = [NSString stringWithFormat:@"%02d:%02d", (int)(intPosition / 60), (int)(intPosition % 60)];
    
}



-(void)controlView:(SBControlView *)controlView changedPositionWithSlider:(UISlider *)slider{
    _isMediaSliderBeingDragged  = NO;
    NSLog(@"%@",slider);
    self.player.currentPlaybackTime = slider.value;
    self.controlView.value = self.player.currentPlaybackTime;

}

-(void)controlView:(SBControlView *)controlView draggedPositionWithSlider:(UISlider *)slider{
    count = 0;
    NSTimeInterval position = slider.value;
    NSInteger intPosition = ceil(position);
    self.controlView.currentTime = [NSString stringWithFormat:@"%02d:%02d", (int)(intPosition / 60), (int)(intPosition % 60)];
    NSLog(@"%f===%f",self.player.currentPlaybackTime,slider.value);
    
}



-(void)controlView:(SBControlView *)controlView withLargeButton:(UIButton *)button{
    count = 0;
    [UIView animateWithDuration:0.25 animations:^{
        if (self.interfaceOrientation == UIInterfaceOrientationPortrait ||
            self.interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown) {
            self.transform = CGAffineTransformMakeRotation(90 *M_PI / 180.0);
            self.frame = CGRectMake(0, 0, MainScreenWidth, MainScreenheight);
            [[UIApplication sharedApplication] setStatusBarHidden:YES];
            self.interfaceOrientation = UIInterfaceOrientationLandscapeRight;
        }else{
            self.transform = CGAffineTransformMakeRotation(0);
            self.frame = self.rect;
            [[UIApplication sharedApplication] setStatusBarHidden:NO];
            self.interfaceOrientation == UIInterfaceOrientationPortrait;
            
        }

    }];
}

-(void)deviceOrientationDidChange:(NSNotification *)notification{
    UIDeviceOrientation orientation = [[UIDevice currentDevice] orientation] ;
    [UIView animateWithDuration:0.25 animations:^{
        
        switch (orientation) {
            case UIDeviceOrientationPortrait:
                self.transform = CGAffineTransformMakeRotation(0);
                self.frame = self.rect;
                [[UIApplication sharedApplication] setStatusBarHidden:NO];
                self.interfaceOrientation = UIInterfaceOrientationPortrait;
                break;
            case UIDeviceOrientationLandscapeLeft:
                self.transform = CGAffineTransformMakeRotation(90 *M_PI / 180.0);
                self.frame = CGRectMake(0, 0, MainScreenWidth, MainScreenheight);
                [[UIApplication sharedApplication] setStatusBarHidden:YES];
                self.interfaceOrientation = UIInterfaceOrientationLandscapeRight;
                break;
            case UIDeviceOrientationLandscapeRight:
                
                self.transform = CGAffineTransformMakeRotation(270 *M_PI / 180.0);
                self.frame = CGRectMake(0, 0, MainScreenWidth, MainScreenheight);
                [[UIApplication sharedApplication] setStatusBarHidden:YES];
                self.interfaceOrientation = UIInterfaceOrientationLandscapeLeft;
                
                break;
            case UIInterfaceOrientationPortraitUpsideDown:
                
                break;
                
            default:
                break;
        }
    }];
    
}




//MARK: UIGestureRecognizer
-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    if ([touch.view isKindOfClass:[SBControlView class]]) {
        return NO;
    }
    return YES;
}
//将数值转换成时间
- (NSString *)convertTime:(CGFloat)second{
    NSDate *d = [NSDate dateWithTimeIntervalSince1970:second];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    if (second/3600 >= 1) {
        [formatter setDateFormat:@"HH:mm:ss"];
    } else {
        [formatter setDateFormat:@"mm:ss"];
    }
    NSString *showtimeNew = [formatter stringFromDate:d];
    return showtimeNew;
}

-(void)play{
    if (self.player) {
        [self.player play];
    }
}
-(void)pause{
    if (self.player) {
        [self.player pause];
    }
}


-(void)stop{
 

    [[NSNotificationCenter defaultCenter] removeObserver:self];
    // 停止刷新UI显示
    [_refresh_timer invalidate];
    _refresh_timer = nil;
    
    [_refresh_dyinfo_timer invalidate];
    _refresh_dyinfo_timer = nil;
    
    if (_alertChangeBitrateTimer != nil) {
        [_alertChangeBitrateTimer invalidate];
        _alertChangeBitrateTimer = nil;
    }
    // 停止缓冲动画
    [self.activityIndeView stopAnimating];
    [self.player.view removeFromSuperview];
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(refreshMediaControl) object:nil];
    [self.player stopScreenRecordWithHandler:^(NSDictionary * _Nullable object, NSError * _Nullable error) {
        //
    }];
    [self.player shutdown];
    self.player = nil;
    [CNCMediaPlayerSDK setPlyerMute:0];
}

@end
