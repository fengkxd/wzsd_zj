//
//  SelCourseCommentTableViewCell.h
//  ZJPlatform
//
//  Created by sostag on 2018/4/4.
//  Copyright © 2018年 wzsd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SelCourseCommentTableViewCell : UITableViewCell
{
    UIImageView *headerImgView;
    UILabel *nickLabel;
    UILabel *timeLabel;
    
    UILabel *contentLabel;
}

-(void)loadComment:(NSDictionary *)dict;
 
@end
