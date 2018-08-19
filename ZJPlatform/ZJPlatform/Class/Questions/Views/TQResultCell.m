//
//  TQResultCell.m
//  ZJPlatform
//
//  Created by fengke on 2018/8/19.
//  Copyright © 2018年 wzsd. All rights reserved.
//

#import "TQResultCell.h"

@implementation TQResultCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        checkBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        checkBtn.titleLabel.font = Font(13);
        [checkBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        checkBtn.frame = CGRectMake(0, 0, 21, 21);
        checkBtn.layer.masksToBounds = YES;
        checkBtn.layer.cornerRadius = 10.5;
        [self.contentView addSubview:checkBtn];
        
        resultInro = [[UILabel alloc] initWithFrame:CGRectZero];
        resultInro.font = Font(15);
        [self.contentView addSubview:resultInro];
        
    }
    return self;
}


-(void)loadInfo:(NSDictionary *)dict{
    NSString *content = [dict objectForKey:@"resultInro"];
    
    CGSize size = CGSizeMake(MainScreenWidth - 8 - 21 - 8 - 8,2000); //设置一个行高上限
    NSDictionary *attribute = @{NSFontAttributeName: Font(15)};
    CGFloat height = [content boundingRectWithSize:size options: NSStringDrawingTruncatesLastVisibleLine |NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attribute context:nil].size.height;

    height = height + 20;
    NSInteger rightAnswers = 0;
    if ([dict objectForKey:@"rightAnswers"]) {
        rightAnswers = [[dict objectForKey:@"rightAnswers"] integerValue];
    }
    checkBtn.frame = CGRectMake(8, (height - 21)/2.0, 21, 21);
    
    resultInro.frame = CGRectMake(8 + 21 + 8, 0, MainScreenWidth - 8 - 21 - 8 - 8, height);
    resultInro.text = [dict objectForKey:@"resultInro"];

    if (rightAnswers == 1) {
        [checkBtn setImage:[UIImage imageNamed:@"TQ_R1"] forState:UIControlStateNormal];
        [checkBtn setTitle:nil forState:UIControlStateNormal];
        resultInro.textColor = MainBlueColor;

    }else{
        [checkBtn setImage:nil forState:UIControlStateNormal];
        [checkBtn setTitle:[dict objectForKey:@"checkValue"] forState:UIControlStateNormal];
        checkBtn.layer.borderWidth = 0.5;
        checkBtn.layer.borderColor = [UIColor lightGrayColor].CGColor;
        resultInro.textColor = [UIColor blackColor];
    }

    
}

-(void)setAnswer:(BOOL)flag{
    if (flag) {
        resultInro.textColor = MainBlueColor;
        checkBtn.layer.borderColor = MainBlueColor.CGColor;
        [checkBtn setTitleColor:MainBlueColor forState:UIControlStateNormal];
    }else{
        checkBtn.layer.borderColor = [UIColor lightGrayColor].CGColor;
        [checkBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        resultInro.textColor = [UIColor blackColor];

    }
    
    
}


@end
