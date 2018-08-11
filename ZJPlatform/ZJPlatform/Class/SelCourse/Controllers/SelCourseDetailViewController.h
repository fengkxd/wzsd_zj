//
//  SelCourseDetailViewController.h
//  ZJPlatform
//
//  Created by sostag on 2018/4/3.
//  Copyright © 2018年 wzsd. All rights reserved.
//

#import "BaseViewController.h"


#ifdef CNC_MediaPlayer_Full
#import <CNCLiveMediaPlayerFramework/CNCMediaPlayerController.h>
#import <CNCLiveMediaPlayerFramework/CNCMediaPlayerFramework.h>
#else
#import <CNCLiveMediaPlayerFramework/CNCMediaPlayerController.h>
#import <CNCLiveMediaPlayerFramework/CNCMediaPlayerFramework.h>
#endif


@interface SelCourseDetailViewController : BaseViewController


@property (nonatomic,strong) NSString *videoId;




 


@end
