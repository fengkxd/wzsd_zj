//
//  MySelCourseTableViewCell.m
//  ZJPlatform
//
//  Created by fengke on 2018/4/7.
//  Copyright © 2018年 wzsd. All rights reserved.
//

#import "MySelCourseTableViewCell.h"

@implementation MySelCourseTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


-(void)loadDetail:(NSDictionary *)dict{
    
    btn1.layer.masksToBounds = YES;
    btn1.layer.cornerRadius = 2;
    btn1.layer.borderColor =[UIColor colorWithHexString:@"cccccc"].CGColor;
    btn1.layer.borderWidth = 0.5;
    btn2.layer.masksToBounds = YES;
    btn2.layer.cornerRadius = 2;

    
    NSMutableAttributedString *mutableAttributeStr = [[NSMutableAttributedString alloc] init];
    NSAttributedString *string1 = [[NSAttributedString alloc] initWithString:@"￥应付金额" attributes:@{NSFontAttributeName :Font_12,NSForegroundColorAttributeName:[UIColor colorWithHexString:@"999999"]}];
    
    NSAttributedString *string2 = [[NSAttributedString alloc] initWithString:@"￥998.00 • " attributes:@{NSFontAttributeName :Font_13,NSForegroundColorAttributeName:[UIColor colorWithHexString:@"f53331"]}];
    
    [mutableAttributeStr appendAttributedString:string1];
    [mutableAttributeStr appendAttributedString:string2];
    pricelabel.attributedText = mutableAttributeStr;


}

@end
