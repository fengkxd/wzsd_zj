//
//  PauseOrPlayView.h
//  SBPlayer
//
//  Created by sycf_ios on 2017/4/11.
//  Copyright © 2017年 shibiao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SBCommonHeader.h"
@class SBPauseOrPlayView;
@protocol SBPauseOrPlayViewDelegate <NSObject>
@required
/**
 暂停和播放视图和状态

 @param pauseOrPlayView 暂停或者播放视图
 @param state 返回状态
 */
-(void)pauseOrPlayView:(SBPauseOrPlayView *)pauseOrPlayView withState:(BOOL)state;
-(void)hanleBackButton;
-(void)hanleMoreButton;

@end
@interface SBPauseOrPlayView : UIView
@property (nonatomic,strong) UIButton *imageBtn;
@property (nonatomic,strong) UIButton *backButton;
@property (nonatomic, strong) UIButton *moreButton;

@property (nonatomic,weak) id<SBPauseOrPlayViewDelegate> delegate;
@property (nonatomic,assign,readonly) BOOL state;

@property (nonatomic,assign)BOOL moreisHidden;
@property (nonatomic,assign)BOOL moreisSelected;

-(void)handleImageTapAction:(UIButton *)button;

-(void)nonClickable;

@end
