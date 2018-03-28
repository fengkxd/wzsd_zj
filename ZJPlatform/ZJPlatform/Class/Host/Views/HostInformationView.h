//
//  HostInformationView.h
//  ZJPlatform
//
//  Created by sostag on 2018/3/28.
//  Copyright © 2018年 wzsd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HostInformationView : UIView
{
    UIView *markView;
}



-(instancetype)initWithFrame:(CGRect)frame WithTitle:(NSArray *)array;


@property (copy) void (^selectedBlock)(NSInteger row);
@property (nonatomic,strong) UIButton *selectedBtn;
@end
