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
 
    btn.layer.masksToBounds = YES;
    btn.layer.cornerRadius = 2;
    btn.layer.borderColor = [UIColor colorWithHexString:@"00a9ff"].CGColor;
    btn.layer.borderWidth = 0.5;
    
    if (timeLabel.text.length) {
        [UILabel changeLineSpaceForLabel:timeLabel WithSpace:7];
    }
    
}






@end
