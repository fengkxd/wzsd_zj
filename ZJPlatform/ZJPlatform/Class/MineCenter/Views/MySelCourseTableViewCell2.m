//
//  MySelCourseTableViewCell2.m
//  ZJPlatform
//
//  Created by fengke on 2018/4/7.
//  Copyright © 2018年 wzsd. All rights reserved.
//

#import "MySelCourseTableViewCell2.h"

@implementation MySelCourseTableViewCell2

- (void)awakeFromNib {
    [super awakeFromNib];


    btn.layer.masksToBounds = YES;
    btn.layer.cornerRadius = 2;


}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
