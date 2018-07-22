//
//  SelCourseCommentTableViewCell.m
//  ZJPlatform
//
//  Created by sostag on 2018/4/4.
//  Copyright © 2018年 wzsd. All rights reserved.
//

#import "SelCourseCommentTableViewCell.h"

@implementation SelCourseCommentTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
    
        headerImgView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 17, 50, 50)];
        headerImgView.layer.masksToBounds = YES;
        headerImgView.layer.cornerRadius = headerImgView.frame.size.width/2.0;
        [self.contentView addSubview:headerImgView];
        headerImgView.image = [UIImage imageNamed:@"head_default.png"];

        nickLabel = [[UILabel alloc] initWithFrame:CGRectMake(75,  8, 100, 28)];
        nickLabel.font = Font_14;
        nickLabel.textColor = [UIColor colorWithHexString:@"333333"];
        [self.contentView addSubview:nickLabel];

        
        contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(75, 38 , MainScreenWidth - 85, 30)];
        contentLabel.textColor = [Utility colorWithHexString:@"7e7e7e"];
        contentLabel.font = Font_13;
        contentLabel.numberOfLines = 0;
        [self.contentView addSubview:contentLabel];
        
        
        timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(75, 38 , MainScreenWidth - 60, 30)];
        timeLabel.textColor = [Utility colorWithHexString:@"a3a3a3"];
        timeLabel.font = Font_12;
        [self.contentView addSubview:timeLabel];
   
        
        
        
        nickLabel.text = @"至尊宝";

    }
    
    return self;
}

-(void)loadComment:(NSDictionary *)dict{
    NSString *content = [dict objectForKey:@"commentValues"];
    NSString *time = [dict objectForKey:@"createDate"];
    CGFloat height = [Utility getSpaceLabelHeight:content withFont:Font_13 withWidth:MainScreenWidth - 85];
    [Utility setLabelSpace:contentLabel withValue:content withFont:Font_13];
    contentLabel.frame = CGRectMake(75, contentLabel.frame.origin.y , MainScreenWidth - 85, height + 5);
    
    
    timeLabel.frame = CGRectMake(75, contentLabel.frame.origin.y + contentLabel.frame.size.height + 5, MainScreenWidth - 85, 15);
    timeLabel.text = time;
    
    nickLabel.text = [[dict objectForKey:@"member"] objectForKey:@"nickname"];

}





@end
