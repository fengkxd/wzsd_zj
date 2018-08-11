//
//  CNCPlayerSetting.m
//  ZJPlatform
//
//  Created by fk on 2018/8/10.
//  Copyright © 2018年 wzsd. All rights reserved.
//

#import "CNCPlayerSetting.h"


@implementation CNCPlayerSetting
+ (instancetype)defaultSetting {
    static CNCPlayerSetting* s_instance = nil;
    if (!s_instance) {
        @synchronized(self) {
            if (!s_instance) {
                s_instance = [[CNCPlayerSetting alloc] init];
            }
        }
    }
    return s_instance;
}

- (instancetype)init {
    if (self = [super init]) {
        self.isLive = NO;
        self.isAutoPlay = YES;
        self.isHardware = YES;
        self.isAccelerateOpen = YES;
        self.isAutoClearCache = NO;
        self.isMixOtherPlayer = NO;
        self.isPlayBackground = YES;
        self.isDisableDecodeBackground = YES;
        self.isSuperAccelerate = NO;
        self.isLowLatencyMode = NO;
        self.isHLSAdaptation = NO;
        self.isLocalCache = NO;
        self.maxCacheTime = 5000;
        self.minBufferTime = 1000;
        self.maxBufferSize = 15;
        self.gifScale = 270;
        self.HLSDefaultBitrate = 0;
        self.cacheVideoCount = 10;
        self.cacheVideoSize = 50;
        
        self.isProxy = NO;
    }
    
    return self;
}
@end
