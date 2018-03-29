//
//  HostVideoView.h
//  ZJPlatform
//
//  Created by sostag on 2018/3/26.
//  Copyright © 2018年 wzsd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Course.h"


//免费课程
@interface HostVideoView : UIView
{
    UIImageView *imgView;
    UIButton *btn;
    UILabel *titleLabel;
    UILabel *numlabel;
}


@property (nonatomic,strong) Course *curCourse;
@property (nonatomic,assign) id delegate;


@end
