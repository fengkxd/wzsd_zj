//
//  TeacherVideoTableViewCell.m
//  ZJPlatform
//
//  Created by fengke on 2018/4/1.
//  Copyright © 2018年 wzsd. All rights reserved.
//

#import "TeacherVideoTableViewCell.h"

@implementation TeacherVideoTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];

    btn.layer.masksToBounds = YES;
    btn.layer.cornerRadius = 2;
    
    NSMutableAttributedString *mutableAttributeStr = [[NSMutableAttributedString alloc] init];
    NSAttributedString *string1 = [[NSAttributedString alloc] initWithString:@"￥998.00   " attributes:@{NSFontAttributeName :Font_12,NSForegroundColorAttributeName:MainBlueColor}];
    NSAttributedString *string2 = [[NSAttributedString alloc] initWithString:@"￥998.00 • " attributes:@{NSStrikethroughStyleAttributeName : @(NSUnderlineStyleThick),NSStrikethroughColorAttributeName : [UIColor colorWithHexString:@"919191"],NSForegroundColorAttributeName : [UIColor  colorWithHexString:@"919191"]}];

    
    [mutableAttributeStr appendAttributedString:string1];
    [mutableAttributeStr appendAttributedString:string2];
    curPriceLabel.attributedText = mutableAttributeStr;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

@end
