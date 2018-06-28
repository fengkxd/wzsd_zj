//
//  LiveBroadcastTableViewCell.m
//  ZJPlatform
//
//  Created by sostag on 2018/4/4.
//  Copyright © 2018年 wzsd. All rights reserved.
//

#import "LiveBroadcastTableViewCell.h"
#import "UIImageView+WebCache.h"

@implementation LiveBroadcastTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];


    btn.layer.masksToBounds = YES;
    btn.layer.cornerRadius = 2;
    
}


-(void)loadCourseInfo:(NSDictionary *)dict{
    
    namelabel.text = [dict objectForKey:@"name"];
    priceLabel.text = [NSString stringWithFormat:@"¥%.2f",[[dict objectForKey:@"price"] floatValue]];
    teachLabel.text = [NSString stringWithFormat:@"主讲师：%@",[[dict objectForKey:@"famousTeacher"] objectForKey:@"name"]];
    [imgView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",ImgProxyUrl,[dict objectForKey:@"frontCover"]]]];
    
 
    
}





@end
