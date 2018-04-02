//
//  TQItem.h
//  ZJPlatform
//
//  Created by Rongbo Li on 2018/4/1.
//  Copyright © 2018年 wzsd. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^TQItemTapCall)(NSString *title);

@interface TQItem : UIView

@property (nonatomic, copy) TQItemTapCall itemCallBack;
@property (nonatomic, copy) NSString *itemtitle;

-(id)initWithTitle:(NSString *)title icon:(NSString *)img frame:(CGRect)rect;

@end
