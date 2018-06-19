//
//  ExamInformationTableViewCell.h
//  ZJPlatform
//
//  Created by sostag on 2018/3/28.
//  Copyright © 2018年 wzsd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ExamInformationTableViewCell : UITableViewCell
{
    IBOutlet UIImageView *imgView;
    IBOutlet UILabel *titleLabel;
    IBOutlet UIButton *btn;
    
    IBOutlet UILabel *timeLabel;
}

-(void)loadInfo:(NSDictionary *)dict;

@end
