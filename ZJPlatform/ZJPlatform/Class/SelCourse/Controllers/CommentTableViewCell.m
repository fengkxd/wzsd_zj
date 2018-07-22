//
//  CommentTableViewCell.m
//  ZJPlatform
//
//  Created by fengke on 2018/7/22.
//  Copyright © 2018年 wzsd. All rights reserved.
//

#import "CommentTableViewCell.h"

@implementation CommentTableViewCell
@synthesize contentLabel;

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;

        headerImgView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 15, 50, 50)];
        headerImgView.layer.masksToBounds = YES;
        headerImgView.layer.cornerRadius = 4;
        [self.contentView addSubview:headerImgView];

        nickLabel = [[UILabel alloc] initWithFrame:CGRectMake(75, 8, 100, 30)];
        nickLabel.font = Font_15;
        nickLabel.textColor = [UIColor colorWithHexString:@"4d4d4d"];
        [self.contentView addSubview:nickLabel];
        
        timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(150, 100, MainScreenWidth - 150 - 15, 30)];
        timeLabel.textAlignment = NSTextAlignmentRight;
        timeLabel.font = Font_12;
        timeLabel.textColor = [UIColor colorWithHexString:@"ababab"];
        [self.contentView addSubview:timeLabel];
        
        contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(75, 32 , MainScreenWidth - 90, 30)];
        contentLabel.textColor = [Utility colorWithHexString:@"878787"];
        contentLabel.font = Font_13;
        contentLabel.numberOfLines = 0;
        [self.contentView addSubview:contentLabel];

    }
    return self;
}


-(void)loadDetail:(NSDictionary *)comment{
    CGFloat space = 5;
    self.curDict = comment;
    [headerImgView setImage:[UIImage imageNamed:@"head_default"]];
    
    
    nickLabel.text = [[comment objectForKey:@"member"] objectForKey:@"nickname"];

    
    timeLabel.text = [comment objectForKey:@"createDate"];
    
    NSString *content = [comment objectForKey:@"commentValues"];
  
    
    CGSize size3 = [self sizeWithString:content font:contentLabel.font];
    CGRect rect3 = contentLabel.frame;
    rect3.size.height = size3.height;
    contentLabel.backgroundColor = [UIColor clearColor];
    contentLabel.frame = rect3;
    contentLabel.text = content;
        
}



// 定义成方法方便多个label调用 增加代码的复用性
- (CGSize)sizeWithString:(NSString *)string font:(UIFont *)font
{
    CGRect rect = [string boundingRectWithSize:CGSizeMake(MainScreenWidth - 90, MAXFLOAT)//限制最大的宽度和高度
                                       options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesFontLeading  |NSStringDrawingUsesLineFragmentOrigin//采用换行模式
                                    attributes:@{NSFontAttributeName: font}//传人的字体字典
                                       context:nil];
    
    return rect.size;
}





    
@end
