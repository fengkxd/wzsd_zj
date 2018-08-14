//
//  learningTimeTableViewCell.h
//  ZJPlatform
//
//  Created by fengke on 2018/8/14.
//  Copyright © 2018年 wzsd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface learningTimeTableViewCell : UITableViewCell
{
    IBOutlet UILabel *label1;
    IBOutlet UILabel *label2;
    IBOutlet UILabel *label3;
}

-(void)loadInfo:(NSDictionary *)dict;

@end
