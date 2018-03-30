//
//  ExamInformationTableViewCell.m
//  ZJPlatform
//
//  Created by sostag on 2018/3/28.
//  Copyright © 2018年 wzsd. All rights reserved.
//

#import "ExamInformationTableViewCell.h"

@implementation ExamInformationTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];

    if (timeLabel.text.length) {
        [UILabel changeLineSpaceForLabel:titleLabel WithSpace:7];
    }
    
}






@end
