//
//  SelCourseTableViewCell.h
//  ZJPlatform
//
//  Created by sostag on 2018/4/3.
//  Copyright © 2018年 wzsd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SelCourseTableViewCell : UITableViewCell
{
    
    IBOutlet UILabel *nameLabel;
    IBOutlet UILabel *teachLabel;
    IBOutlet UILabel *priceLabel;
    IBOutlet UIImageView *imgView;
    IBOutlet UILabel *browsingNumberLabel;

    IBOutlet UILabel *label;

}

-(void)loadCourseInfo:(NSDictionary *)dict;
-(void)loadCourseWithDetail:(NSDictionary *)dict;


@end
