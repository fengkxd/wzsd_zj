//
//  OrderTableViewCell.m
//  ZJPlatform
//
//  Created by fk on 2018/8/15.
//  Copyright © 2018年 wzsd. All rights reserved.
//

#import "OrderTableViewCell.h"
#import "UIImageView+WebCache.h"

@implementation OrderTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)loadInfo:(NSDictionary *)dict{
    orderLabel.text = [NSString stringWithFormat:@"订单编号:%@",[dict objectForKey:@"orderNo"]];
    [imgView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",ImgProxyUrl,[[[[dict objectForKey:@"orderDetailList"] firstObject] objectForKey:@"course"] objectForKey:@"frontCover"]]]];
    
    nameLabel.text = [[[[dict objectForKey:@"orderDetailList"] firstObject] objectForKey:@"course"] objectForKey:@"name"];
    priceLabel.text = [NSString stringWithFormat:@"%.2f", [[dict objectForKey:@"allPrice"] floatValue]];
    
}



@end
