//
//  learningTimeTableViewCell.m
//  ZJPlatform
//
//  Created by fengke on 2018/8/14.
//  Copyright © 2018年 wzsd. All rights reserved.
//

#import "learningTimeTableViewCell.h"

@implementation learningTimeTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)loadInfo:(NSDictionary *)dict{
    label1.text = [NSString stringWithFormat:@"科目:%@",[[dict objectForKey:@"course"] objectForKey:@"name"]];
    label2.text = [NSString stringWithFormat:@"在线学习时长:%zi分钟",[[dict objectForKey:@"watchTime"] integerValue]];
    
    label3.text = [dict objectForKey:@"createDate"];

}



@end
