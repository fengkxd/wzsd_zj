//
//  TQHistoryCell.m
//  ZJPlatform
//
//  Created by Rongbo Li on 2018/4/1.
//  Copyright © 2018年 wzsd. All rights reserved.
//

#import "TQHistoryCell.h"

@implementation TQHistoryCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)loadinfo:(NSDictionary *)dict{
    label1.text = [dict objectForKey:@"title"];
    
    NSString *createDate = [dict objectForKey:@"createDate"];
    if ([Utility isBlank:createDate]) {
        if ([[dict objectForKey:@"testPay"] integerValue] == 0) {
            label2.text = @"价格：免费";
        }else{
            label2.text = [NSString stringWithFormat:@"价格：%zi",[[dict objectForKey:@"testPay"] integerValue]];
        }
    }else{
        if ([[dict objectForKey:@"testPay"] integerValue] == 0) {
            label2.text = [NSString stringWithFormat:@"价格：免费  最近考试时间：%@",createDate];
        }else{
            label2.text = [NSString stringWithFormat:@"价格：%zi  最近考试时间：%@",[[dict objectForKey:@"testPay"] integerValue],createDate];
        }
        
    }
   
    
    
}



@end
