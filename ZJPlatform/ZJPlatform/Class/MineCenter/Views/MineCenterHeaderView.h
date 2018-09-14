//
//  MineCenterHeaderView.h
//  ZJPlatform
//
//  Created by sostag on 2018/3/26.
//  Copyright © 2018年 wzsd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MineCenterHeaderView : UIView

@property (nonatomic,strong) IBOutlet UIImageView *imgView;

@property (nonatomic,strong) IBOutlet UILabel *nameLabel;
@property (nonatomic,strong) IBOutlet UILabel *sourceLabel;

@property (nonatomic,strong) IBOutlet UIView *sourceView;
@property (nonatomic,strong) IBOutlet UIButton *loginBtn;


@property (copy) void (^clickSetting)(void);
@property (copy) void (^clickScan)(void);
@property (copy) void (^clickMsg)(void);


-(void)loadInfo:(NSDictionary *)dict;

@end
