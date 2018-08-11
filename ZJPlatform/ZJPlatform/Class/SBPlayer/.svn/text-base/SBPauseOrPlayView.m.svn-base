//
//  PauseOrPlayView.m
//  SBPlayer
//
//  Created by sycf_ios on 2017/4/11.
//  Copyright © 2017年 shibiao. All rights reserved.
//

#import "SBPauseOrPlayView.h"
@interface SBPauseOrPlayView ()

@end
@implementation SBPauseOrPlayView

- (void)drawRect:(CGRect)rect {
    self.imageBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.imageBtn setImage:[UIImage imageNamed:@"play"] forState:UIControlStateNormal];
    [self.imageBtn setShowsTouchWhenHighlighted:YES];
    [self.imageBtn setImage:[UIImage imageNamed:@"pause"] forState:UIControlStateSelected];
    [self.imageBtn addTarget:self action:@selector(handleImageTapAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.imageBtn];
    [self.imageBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(50, 50));
    }];
    
    _backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _backButton.contentMode = UIViewContentModeScaleToFill;
    [_backButton setImage:[UIImage imageNamed:@"Navigation bar_Arrow_normal.png"] forState:UIControlStateNormal];
    [_backButton addTarget:self action:@selector(hanleBackBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_backButton];
    _backButton.frame = CGRectMake(10, 10, 40, 40);
    
    if (!self.moreisHidden) {
        _moreButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _moreButton.contentMode = UIViewContentModeScaleToFill;
        [_moreButton setImage:[UIImage imageNamed:@"xin_normal.png"] forState:UIControlStateNormal];
        [_moreButton setImage:[UIImage imageNamed:@"xin_slected.png"] forState:UIControlStateSelected];
        [_moreButton addTarget:self action:@selector(hanleMoreBtn:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_moreButton];
        
        [self.moreButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(10);
            make.right.mas_equalTo(-10);
            make.size.mas_equalTo(CGSizeMake(40, 40));
        }];
     
        _moreButton.selected = self.moreisSelected;
        
    }
   
    
}
-(void)handleImageTapAction:(UIButton *)button{
    button.selected = !button.selected;
    _state = button.isSelected ? YES : NO;
    if ([self.delegate respondsToSelector:@selector(pauseOrPlayView:withState:)]) {
        [self.delegate pauseOrPlayView:self withState:_state];
    }
}


-(void)hanleMoreBtn:(UIButton *)button{
    if ([self.delegate respondsToSelector:@selector(hanleMoreButton)]) {
        [self.delegate hanleMoreButton];
    }
}

-(void)hanleBackBtn:(UIButton *)button{
    if ([self.delegate respondsToSelector:@selector(hanleBackButton)]) {
        [self.delegate hanleBackButton];
    }
}

@end
