//
//  PreparationInformationTableViewCell.m
//  ZJPlatform
//
//  Created by sostag on 2018/3/29.
//  Copyright © 2018年 wzsd. All rights reserved.
//

#import "PreparationInformationTableViewCell.h"

@implementation PreparationInformationTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    btn.layer.masksToBounds = YES;
    btn.layer.cornerRadius = 2;
    btn.layer.borderColor = [UIColor colorWithHexString:@"00a9ff"].CGColor;
    btn.layer.borderWidth = 0.5;
    
    if (timeLabel.text.length) {
        [UILabel changeLineSpaceForLabel:timeLabel WithSpace:7];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
