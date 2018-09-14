//
//  MenuAlert.h
//  dragonlion
//
//  Created by fengke on 2018/8/12.
//  Copyright © 2018年 sostag. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface MenuAlert : UIView

// 显示字体设置
@property(nonatomic,assign)UIFont * cusFont;

/**
 点击回调,返回所点的角标以及点击的内容
 */
@property(nonatomic, copy) void(^didSelectedCallback)(NSInteger index, NSString * content);

@property(nonatomic, copy) void(^dismissCallback)(void);

/// 数据源 数据, 下拉列表的内容数组.
@property(nonatomic, strong) NSArray * arrMDataSource;
// tableview以及cell的背景色, 如果不设置默认白色
@property(nonatomic, strong) UIColor * tabColor;
// 文字的颜色, 默认黑色
@property(nonatomic, strong) UIColor * txtColor;
@property(nonatomic, assign) NSInteger defRow;

-(void)show;
-(void)hidden;

@end
