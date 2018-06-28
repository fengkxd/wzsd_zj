//
//  HostInformationTableViewCell.m
//  ZJPlatform
//
//  Created by sostag on 2018/3/26.
//  Copyright © 2018年 wzsd. All rights reserved.
//

#import "HostInformationTableViewCell.h"
#import "UIImageView+WebCache.h"

@implementation HostInformationTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [UILabel changeLineSpaceForLabel:detailLabel WithSpace:5.0];

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

-(void)loadInfo:(NSDictionary *)dict{
 
   
    titleLabel.text = [dict objectForKey:@"title"];
    detailLabel.text = [dict objectForKey:@"intro"];
    [UILabel changeLineSpaceForLabel:detailLabel WithSpace:5.0];

    [imgView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",ImgProxyUrl,[dict objectForKey:@"cover"]]]];
}
    


@end
