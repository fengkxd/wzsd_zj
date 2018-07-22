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
    label.hidden = YES;
    browsingNumberLabel.text = [dict objectForKey:@""];
}

-(void)loadCourseWithDetail:(NSDictionary *)dict{
    nameLabel.hidden = YES;
    priceLabel.hidden = YES;
    teachLabel.hidden = YES;
    browsingNumberLabel.hidden = YES;
    
    [imgView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",ImgProxyUrl,[[[dict objectForKey:@"videoList"] lastObject]objectForKey:@"imgUrl"]]]];
    label.text = [dict objectForKey:@"name"];
    label.numberOfLines = 0;
}


@end
