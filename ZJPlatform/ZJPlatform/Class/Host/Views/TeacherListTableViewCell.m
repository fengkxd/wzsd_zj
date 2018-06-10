//
//  TeacherListTableViewCell.m
//  ZJPlatform
//
//  Created by sostag on 2018/3/30.
//  Copyright © 2018年 wzsd. All rights reserved.
//

#import "TeacherListTableViewCell.h"
#import "UIImageView+WebCache.h"

@implementation TeacherListTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [UILabel changeLineSpaceForLabel:detailLabel WithSpace:7];

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)loadDict:(NSDictionary *)dict{
    
    [imgView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",ImgProxyUrl,[dict objectForKey:@"photograph"]]]];
    nameLabel.text = [dict objectForKey:@"name"];
    NSString *string = [Utility htmlEntityDecode:[dict objectForKey:@"description"]];
    
    string = [string stringByReplacingOccurrencesOfString:@"<p>" withString:@""];
    string = [string stringByReplacingOccurrencesOfString:@"</p>" withString:@""];
    string = [string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]; //去除掉首尾的空白字符和换行字符
    detailLabel.text = string;
    [UILabel changeLineSpaceForLabel:detailLabel WithSpace:7];

}

@end


