//
//  LiveBroadcastTableViewCell.m
//  ZJPlatform
//
//  Created by sostag on 2018/4/4.
//  Copyright © 2018年 wzsd. All rights reserved.
//

#import "LiveBroadcastTableViewCell.h"

@implementation LiveBroadcastTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];


    btn.layer.masksToBounds = YES;
    btn.layer.cornerRadius = 2;
    
    NSMutableAttributedString *mutableAttributeStr = [[NSMutableAttributedString alloc] init];
    NSAttributedString *string1 = [[NSAttributedString alloc] initWithString:@"￥998.00   " attributes:@{NSFontAttributeName :Font_12,NSForegroundColorAttributeName:[UIColor colorWithHexString:@"E72725"]}];
    NSAttributedString *string2 = [[NSAttributedString alloc] initWithString:@"￥998.00 • " attributes:@{NSStrikethroughStyleAttributeName : @(NSUnderlineStyleThick),NSStrikethroughColorAttributeName : [UIColor colorWithHexString:@"919191"],NSForegroundColorAttributeName : [UIColor  colorWithHexString:@"919191"]}];
    
    [mutableAttributeStr appendAttributedString:string1];
    [mutableAttributeStr appendAttributedString:string2];
    priceLabel.attributedText = mutableAttributeStr;
    


}





@end
