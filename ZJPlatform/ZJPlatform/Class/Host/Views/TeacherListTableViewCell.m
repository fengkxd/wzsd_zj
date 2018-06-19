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
    
    NSMutableAttributedString * attrStr = [[NSMutableAttributedString alloc] initWithData:[string dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes: nil error:nil];
    
    [attrStr addAttribute:NSFontAttributeName value:nameLabel.font range:NSMakeRange(0, attrStr.length)];

 
    detailLabel.attributedText = attrStr;
    [UILabel changeLineSpaceForLabel:detailLabel WithSpace:7];

}

@end


