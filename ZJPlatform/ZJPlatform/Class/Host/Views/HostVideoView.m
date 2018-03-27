//
//  HostVideoView.m
//  ZJPlatform
//
//  Created by sostag on 2018/3/26.
//  Copyright © 2018年 wzsd. All rights reserved.
//

#import "HostVideoView.h"

@implementation HostVideoView



-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        imgView = [[UIImageView alloc] initWithFrame:CGRectMake(10,10, frame.size.width - 15, frame.size.height - 87)];
        imgView.backgroundColor = [UIColor blackColor];
        imgView.image = [UIImage imageNamed:@"videoDefault.png"];
        [self addSubview:imgView];
        
        
        
        btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = imgView.frame;
        [btn setImage:[UIImage imageNamed:@"play.png"] forState:UIControlStateNormal];
        btn.userInteractionEnabled = YES;
        [btn addTarget:self action:@selector(clickPlay:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
        [btn setBackgroundColor:[UIColor clearColor]];
        
        
        
        titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, frame.size.height - 74, frame.size.width - 20, 44)];
        titleLabel.textColor = [UIColor colorWithHexString:@"333333"];
        titleLabel.numberOfLines = 2;
        titleLabel.font = Font_14;
        [self addSubview:titleLabel];
        
        numlabel = [[UILabel alloc] initWithFrame:CGRectMake(15, frame.size.height - 32, frame.size.width - 30, 24)];
        numlabel.textColor = [UIColor colorWithHexString:@"8c8c8c"];
        numlabel.font = Font_12;
        [self addSubview:numlabel];
        titleLabel.text = @"【第一节】一级建造师一次过全程通关";
        numlabel.text = @"已学习：1500人";
        [self addSubview:titleLabel];
        [self bringSubviewToFront:btn];
        
        
        [UILabel changeLineSpaceForLabel:titleLabel WithSpace:7.0];

    }
    return self;
}


-(void)clickPlay:(id)sender{



}




@end
