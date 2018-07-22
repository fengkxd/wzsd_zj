//
//  CommentTableViewCell.h
//  ZJPlatform
//
//  Created by fengke on 2018/7/22.
//  Copyright © 2018年 wzsd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CommentTableViewCell : UITableViewCell
{
    UIImageView *headerImgView;
    UILabel *nickLabel;
    UILabel *timeLabel;
}
@property (nonatomic,strong) UILabel *contentLabel;
@property (nonatomic,strong) NSDictionary *curDict;

-(void)loadDetail:(NSDictionary *)comment;

@end
