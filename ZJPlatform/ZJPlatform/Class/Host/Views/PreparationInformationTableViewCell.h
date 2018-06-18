//
//  PreparationInformationTableViewCell.h
//  ZJPlatform
//
//  Created by sostag on 2018/3/29.
//  Copyright © 2018年 wzsd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PreparationInformationTableViewCell : UITableViewCell
{
    
    IBOutlet UIImageView *imgView;
    IBOutlet UILabel *titleLabel;

    
    IBOutlet UILabel *timeLabel;
    
}

-(void)loadInfo:(NSDictionary *)dict;

@end
