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



-(instancetype)initWithFrame:(CGRect)frame WithArray:(NSArray *)array;

@property (nonatomic,strong) NSArray *dicts;

@property (copy) void (^selectedBlock)(NSDictionary *dict);
@property (nonatomic,strong) UIButton *selectedBtn;
@end
