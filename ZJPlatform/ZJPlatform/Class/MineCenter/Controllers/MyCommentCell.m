//
//  MyCommentCell.m
//  ZJPlatform
//
//  Created by fk on 2018/8/15.
//  Copyright © 2018年 wzsd. All rights reserved.
//

#import "MyCommentCell.h"
#import "UIImageView+WebCache.h"

@implementation MyCommentCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(IBAction)del:(id)sender{
    [self.delegate performSelector:@selector(deleteComment:) withObject:nil];
}


-(void)loadInfo:(NSDictionary *)dict{
    [imgView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",ImgProxyUrl,[[dict objectForKey:@"course"] objectForKey:@"frontCover"]]]];
    nameLabel.text = [[dict objectForKey:@"course"] objectForKey:@"name"];
    timeLabel.text = [NSString stringWithFormat:@"%@", [dict objectForKey:@"createDate"]];
    
}
@end
