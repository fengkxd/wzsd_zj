//
//  PreparationInformationTableViewCell.m
//  ZJPlatform
//
//  Created by sostag on 2018/3/29.
//  Copyright © 2018年 wzsd. All rights reserved.
//

#import "PreparationInformationTableViewCell.h"
#import "UIImageView+WebCache.h"

@implementation PreparationInformationTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];


}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)loadInfo:(NSDictionary *)dict{
    titleLabel.text = [dict objectForKey:@"title"];
    timeLabel.text = [dict objectForKey:@"addTime"];
    [imgView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",ImgProxyUrl,[dict objectForKey:@"cover"]]]];
    [UILabel changeLineSpaceForLabel:titleLabel WithSpace:7];

}


@end
