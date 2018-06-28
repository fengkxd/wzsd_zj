//
//  SelCourseTableViewCell.m
//  ZJPlatform
//
//  Created by sostag on 2018/4/3.
//  Copyright © 2018年 wzsd. All rights reserved.
//

#import "SelCourseTableViewCell.h"
#import "UIImageView+WebCache.h"

@implementation SelCourseTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)loadCourseInfo:(NSDictionary *)dict{
    
    nameLabel.text = [dict objectForKey:@"name"];
    priceLabel.text = [NSString stringWithFormat:@"¥%.2f",[[dict objectForKey:@"price"] floatValue]];
    teachLabel.text = [NSString stringWithFormat:@"主讲师：%@",[[dict objectForKey:@"famousTeacher"] objectForKey:@"name"]];
    [imgView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",ImgProxyUrl,[dict objectForKey:@"frontCover"]]]];
    
    browsingNumberLabel.text = [dict objectForKey:@""];
}

-(void)loadCourseWithDetail:(NSDictionary *)dict{
    
    nameLabel.text = [dict objectForKey:@"name"];
    priceLabel.text = [NSString stringWithFormat:@"¥%.2f",[[dict objectForKey:@"price"] floatValue]];
    teachLabel.text = [NSString stringWithFormat:@"主讲师：%@",[[dict objectForKey:@"famousTeacher"] objectForKey:@"name"]];
    [imgView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",ImgProxyUrl,[dict objectForKey:@"frontCover"]]]];
    browsingNumberLabel.text = [dict objectForKey:@""];
}


@end
