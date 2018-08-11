//
//  CNCPlayerSetting.h
//  ZJPlatform
//
//  Created by fk on 2018/8/10.
//  Copyright © 2018年 wzsd. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface CNCPlayerSetting : NSObject

@property (nonatomic) BOOL isAutoPlay;
@property (nonatomic) BOOL isLive;
@property (nonatomic) BOOL isHardware;
@property (nonatomic) BOOL isAutoClearCache;
@property (nonatomic) BOOL isDisableDecodeBackground;
@property (nonatomic) BOOL isPlayBackground;
@property (nonatomic) BOOL isAccelerateOpen;
@property (nonatomic) BOOL isMixOtherPlayer;
@property (nonatomic) BOOL isSuperAccelerate;
@property (nonatomic) BOOL isLowLatencyMode;
@property (nonatomic) BOOL isHLSAdaptation;
@property (nonatomic) BOOL isLocalCache;

@property (nonatomic) NSInteger minBufferTime;
@property (nonatomic) NSInteger maxCacheTime;
@property (nonatomic) NSInteger maxBufferSize;
@property (nonatomic) int gifScale;
@property (nonatomic) int64_t HLSDefaultBitrate;

@property (nonatomic) NSInteger cacheVideoCount;
@property (nonatomic) NSInteger cacheVideoSize;

@property (nonatomic) BOOL isProxy;
@property (nonatomic) BOOL isHTTPS;
@property (nonatomic, assign) NSUInteger    type;
@property (nonatomic, strong) NSString      *socksUser;
@property (nonatomic, strong) NSString      *socksPwd;
@property (nonatomic, strong) NSString      *socksIP;
@property (nonatomic, strong) NSString      *socksPort;

+ (instancetype)defaultSetting;

@end
