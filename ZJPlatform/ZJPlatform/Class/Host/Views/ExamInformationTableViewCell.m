//
//  ExamInformationTableViewCell.m
//  ZJPlatform
//
//  Created by sostag on 2018/3/28.
//  Copyright © 2018年 wzsd. All rights reserved.
//

#import "ExamInformationTableViewCell.h"
#import "UIImageView+WebCache.h"


@implementation ExamInformationTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];

    if (timeLabel.text.length) {
        [UILabel changeLineSpaceForLabel:titleLabel WithSpace:7];
    }
    
}

-(void)loadInfo:(NSDictionary *)dict{
    
    NSString *string = [Utility htmlEntityDecode:[dict objectForKey:@"title"]];
    
    NSMutableAttributedString * attrStr = [[NSMutableAttributedString alloc] initWithData:[string dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes: nil error:nil];
    
    [attrStr addAttribute:NSFontAttributeName value:titleLabel.font range:NSMakeRange(0, attrStr.length)];
    [attrStr addAttribute:NSForegroundColorAttributeName
                          value:titleLabel.textColor
                          range:NSMakeRange(0, attrStr.length)];
    
    titleLabel.attributedText = attrStr;

    
    timeLabel.text = [dict objectForKey:@"addTime"];
    [imgView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",ImgProxyUrl,[dict objectForKey:@"cover"]]]];
}




@end
