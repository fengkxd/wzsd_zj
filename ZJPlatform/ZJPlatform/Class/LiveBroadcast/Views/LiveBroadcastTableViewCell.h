//
//  LiveBroadcastTableViewCell.h
//  ZJPlatform
//
//  Created by sostag on 2018/4/4.
//  Copyright © 2018年 wzsd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LiveBroadcastTableViewCell : UITableViewCell
{
    
    
  IBOutlet  UIButton *btn;
  IBOutlet  UIImageView *imgView;
  IBOutlet  UILabel *namelabel;
  IBOutlet UILabel *teachLabel;
  IBOutlet UILabel *priceLabel;
    
}


-(void)loadCourseInfo:(NSDictionary *)dict;


@end
