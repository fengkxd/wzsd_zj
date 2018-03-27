//
//  HostFreeVideoView.m
//  ZJPlatform
//
//  Created by sostag on 2018/3/26.
//  Copyright © 2018年 wzsd. All rights reserved.
//

#import "HostFreeVideoView.h"

@implementation HostFreeVideoView


-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        imgView = [[UIImageView alloc] initWithFrame:CGRectMake(10,10, frame.size.width - 15, frame.size.height - 50)];
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
        
        
        
        titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, frame.size.height - 40, frame.size.width - 15, 33)];
        titleLabel.textColor = [UIColor colorWithHexString:@"333333"];
        titleLabel.numberOfLines = 0;
        titleLabel.font = Font_14;
        [self addSubview:titleLabel];
        
     
        titleLabel.text = @"冲刺|一级建造师压轴密卷";
        [self addSubview:titleLabel];
        [self bringSubviewToFront:btn];
        
        
        
    }
    return self;
}


-(void)clickPlay:(id)sender{
    
    
    
}


@end
