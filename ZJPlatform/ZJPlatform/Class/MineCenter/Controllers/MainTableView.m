//
//  MainTableView.m
//  ZJPlatform
//
//  Created by fengke on 2018/8/14.
//  Copyright © 2018年 wzsd. All rights reserved.
//


#import "MainTableView.h"

@implementation MainTableView

//允许接受多个手势
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer{
    
    return YES;
}

@end
