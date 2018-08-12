//
//  SBView.h
//  SBPlayer
//
//  Created by sycf_ios on 2017/4/10.
//  Copyright © 2017年 shibiao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import "SBCommonHeader.h"
#import "SBControlView.h"
#import "SBPauseOrPlayView.h"
#import "CNCPlayerCommonFunc.h"
#import <CNCLiveMediaPlayerFramework/CNCMediaPlayerController.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import "CNCPlayerSetting.h"


//横竖屏的时候过渡动画时间，设置为0.0则是无动画
#define kTransitionTime 0.2
//填充模式枚举值
typedef NS_ENUM(NSInteger,SBLayerVideoGravity){
    SBLayerVideoGravityResizeAspect,
    SBLayerVideoGravityResizeAspectFill,
    SBLayerVideoGravityResize,
};
//播放状态枚举值
typedef NS_ENUM(NSInteger,SBPlayerStatus){
    SBPlayerStatusFailed,
    SBPlayerStatusReadyToPlay,
    SBPlayerStatusUnknown,
    SBPlayerStatusBuffering,
    SBPlayerStatusPlaying,
    SBPlayerStatusStopped,
};
@interface SBPlayer : UIView<SBControlViewDelegate,SBPauseOrPlayViewDelegate,UIGestureRecognizerDelegate>{
    id playbackTimerObserver;
    
    
    // 刷新控制界面显示定时器
    NSTimer *_refresh_timer;
    // 刷新动态信息定时器
    NSTimer *_refresh_dyinfo_timer;
    // 播放器是否stop
    BOOL _isVideoOver;
    // 进度条是否正在拖拉
    BOOL _isMediaSliderBeingDragged;
    
    // 断网重连
    /* 是否断网过 */
    BOOL _isConnectionBreak; // 切换网络时判断
    // 当前的显示比例
    CncMpVideoScalingMode _currentScaling;
    
    /* 音量控制 */
    UISlider    *_sliderVolume;
    // 记录当前屏幕亮度
    float _currentBrightness;
    // 记录进入播放前的屏幕亮度
    float _originBrightness;
    // 检测卡顿时长，进行切换码率提示
    NSInteger _startBufferTime;
    
    // 监听缓冲等待时间,进行切换码率提醒
    NSTimer *_alertChangeBitrateTimer;
    // 记录网络不稳定时的errorCode
    NSString *_lastErrorCode;
    
}

@property (nonatomic, strong) CNCMediaPlayerController *player;
@property (nonatomic, strong) SBPauseOrPlayView *pauseOrPlayView;
@property (nonatomic,strong) SBControlView *controlView;
@property (nonatomic, strong) CNCPlayerSetting *setting;
@property (nonatomic,strong) UIActivityIndicatorView *activityIndeView;

//总时长
@property (nonatomic,assign) CMTime totalTime;
//当前时间
@property (nonatomic,assign) CMTime currentTime;

//播放器Playback Rate
@property (nonatomic,assign) CGFloat rate;
//播放状态
@property (nonatomic,assign,readonly) SBPlayerStatus status;
//videoGravity设置屏幕填充模式，（只写）
@property (nonatomic,assign) SBLayerVideoGravity mode;
//是否正在播放
@property (nonatomic,assign,readonly) BOOL isPlaying;
//是否全屏
@property (nonatomic,assign,readonly) BOOL isFullScreen;
//设置标题
@property (nonatomic,copy) NSString *title;


//与url初始化
-(instancetype)initWithFrame:(CGRect)frame WithUrl:(NSURL *)url;

//公用同一个资产请使用此方法初始化
-(instancetype)initWithAsset:(AVURLAsset *)asset;
//播放
-(void)play;
//暂停
-(void)pause;
//停止 （移除当前视频播放下一个或者销毁视频，需调用Stop方法）
-(void)stop;

@property (nonatomic,assign)BOOL moreisHidden;
@property (nonatomic,assign)BOOL moreisSelected;

//暂停和播放视图

@property (copy) void (^ _Nullable dismissBlock)();
@property (copy) void (^ _Nullable moreBlock)();
@property (copy) void (^ _Nullable updateWatchNumBlock)();


@end
