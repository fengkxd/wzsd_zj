//
//  TQItem1.m
//  ZJPlatform
//
//  Created by Rongbo Li on 2018/4/1.
//  Copyright © 2018年 wzsd. All rights reserved.
//

#import "TQItem1.h"

@implementation TQItem1

-(id)initWithTitle:(NSString *)title icon:(NSString *)img frame:(CGRect)rect{
    
    if (self = [super initWithFrame:rect]) {
        
        self.itemtitle = title;
        
        UIImageView *imv = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 40,40)];
        imv.image = [UIImage imageNamed:img];
        imv.center = CGPointMake(rect.size.width/2,45);
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, rect.size.width, 30)];
        label.backgroundColor = [UIColor clearColor];
        label.font = [UIFont systemFontOfSize:16.0f];
        label.text = title;
        label.textAlignment = NSTextAlignmentCenter;
        label.center = CGPointMake(rect.size.width/2, CGRectGetMaxY(imv.frame) + 20);
        
        [self addSubview:imv];
        [self addSubview:label];
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(0, 0, rect.size.width, rect.size.height);
        [button addTarget:self action:@selector(itemTaped) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:button];
    }
    
    return self;
}

- (void)itemTaped{
    
    if (self.itemCallBack) {
        self.itemCallBack(self.itemtitle);
    }
}

@end
