//
//  HostInformationView.m
//  ZJPlatform
//
//  Created by sostag on 2018/3/28.
//  Copyright © 2018年 wzsd. All rights reserved.
//




#import "HostInformationView.h"

@implementation HostInformationView



-(instancetype)initWithFrame:(CGRect)frame WithTitle:(NSArray *)array{

    self = [super initWithFrame:frame];
    if (self) {
        UIView *bgView = [[UIView alloc] initWithFrame:frame];
        bgView.backgroundColor = [UIColor whiteColor];
        [self addSubview:bgView];
        
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 44, MainScreenWidth, 0.5)];
        line.backgroundColor = [UIColor colorWithHexString:@"cccccc"];
        [self addSubview:line];
        
        
        
        UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:frame];
        scrollView.backgroundColor = [UIColor clearColor];
        CGFloat x = 10;
        for (int i = 0; i < [array count] ; i++) {
            
            NSString *name = [array objectAtIndex:i];
            CGSize size =[name sizeWithAttributes:@{NSFontAttributeName:Font_13}];
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame = CGRectMake(x, 0, size.width + 10, frame.size.height);
            [btn setTitle:name forState:UIControlStateNormal];
            btn.titleLabel.font = Font_13;
            [btn setTitleColor:[UIColor colorWithHexString:@"444444"] forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor colorWithHexString:@"04a7fd"] forState:UIControlStateSelected];
            [scrollView addSubview:btn];
            x = x + size.width + 35;
            if (i == 0) {
                self.selectedBtn = btn;
                btn.selected = YES;
            }
            [btn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
            btn.tag = i;
        }
        scrollView.showsVerticalScrollIndicator = NO;
        scrollView.showsHorizontalScrollIndicator = NO;
        scrollView.contentSize = CGSizeMake(x, frame.size.height);
        [self addSubview:scrollView];
        
      
    
        markView = [[UIView alloc] initWithFrame:CGRectZero];
        markView.backgroundColor = [UIColor colorWithHexString:@"00a9ff"];
        markView.tag = 11;
        markView.frame = CGRectMake(self.selectedBtn.frame.origin.x + self.selectedBtn.frame.size.width/2.0 - 14, 43.5, 28, 1.5);
        [scrollView addSubview:markView];
        
    }
    return self;
}

-(void)clickBtn:(UIButton *)btn{
    self.selectedBtn.selected = NO;
    self.selectedBtn = btn;
    self.selectedBtn.selected = YES;

    markView.frame = CGRectMake(self.selectedBtn.frame.origin.x + self.selectedBtn.frame.size.width/2.0 - 14, 43.5, 28, 1.5);


}
@end
