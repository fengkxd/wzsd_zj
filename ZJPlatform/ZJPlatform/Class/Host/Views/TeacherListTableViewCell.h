//
//  TeacherListTableViewCell.h
//  ZJPlatform
//
//  Created by sostag on 2018/3/30.
//  Copyright © 2018年 wzsd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TeacherListTableViewCell : UITableViewCell
{
    
  IBOutlet  UILabel *nameLabel;
  IBOutlet  UILabel *detailLabel;
  IBOutlet  UIImageView *imgView;
}

-(void)loadDict:(NSDictionary *)dict;
@end
