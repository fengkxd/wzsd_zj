//
//  MyCommentCell.h
//  ZJPlatform
//
//  Created by fk on 2018/8/15.
//  Copyright © 2018年 wzsd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyCommentCell : UITableViewCell
{
    IBOutlet UIImageView *imgView;
    IBOutlet UILabel *nameLabel;
    IBOutlet UILabel *timeLabel;

}

@property (nonatomic,strong) id delegate;
-(void)loadInfo:(NSDictionary *)dict;

@end
