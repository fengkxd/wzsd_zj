//
//  MyLiveBroadcastTableViewCell.m
//  ZJPlatform
//
//  Created by fengke on 2018/4/6.
//  Copyright © 2018年 wzsd. All rights reserved.
//

#import "MyLiveBroadcastTableViewCell.h"

@implementation MyLiveBroadcastTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];

    btn.layer.masksToBounds = YES;
    btn.layer.cornerRadius = 2;

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
