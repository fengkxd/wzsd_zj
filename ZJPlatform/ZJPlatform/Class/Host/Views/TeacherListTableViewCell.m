//
//  TeacherListTableViewCell.m
//  ZJPlatform
//
//  Created by sostag on 2018/3/30.
//  Copyright © 2018年 wzsd. All rights reserved.
//

#import "TeacherListTableViewCell.h"

@implementation TeacherListTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    if (detailLabel.text.length) {
        [UILabel changeLineSpaceForLabel:detailLabel WithSpace:7];
    }}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
