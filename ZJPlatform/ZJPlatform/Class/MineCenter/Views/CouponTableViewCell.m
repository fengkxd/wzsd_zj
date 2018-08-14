//
//  CouponTableViewCell.m
//  ZJPlatform
//
//  Created by sostag on 2018/4/2.
//  Copyright © 2018年 wzsd. All rights reserved.
//

#import "CouponTableViewCell.h"

@implementation CouponTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)loadDetail:(NSDictionary *)dict{
    priceLabel.text = [NSString stringWithFormat:@"¥%zi",[[dict objectForKey:@"price"] integerValue]];
    label1.text = [dict objectForKey:@"name"];
    label2.text = [NSString stringWithFormat:@"截止日期:%@",[dict objectForKey:@"endTime"]];
    NSInteger status =[[dict objectForKey:@"status"] integerValue];
    if (status == 0) {
        imgView.image = [UIImage imageNamed:@"Coupon_bg2.png"];
    }else if(status == 1){
        imgView.image = [UIImage imageNamed:@"Coupon_bg3.png"];
    }else{
        imgView.image = [UIImage imageNamed:@"Coupon_bg4.png"];

    }
}

@end
