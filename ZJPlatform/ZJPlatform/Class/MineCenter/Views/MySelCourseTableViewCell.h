//
//  MySelCourseTableViewCell.h
//  ZJPlatform
//
//  Created by fengke on 2018/4/7.
//  Copyright © 2018年 wzsd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MySelCourseTableViewCell : UITableViewCell
{
    IBOutlet UIButton *btn1;
    IBOutlet UIButton *btn2;

    IBOutlet UILabel *titlelabel;
    IBOutlet UILabel *pricelabel;
    
    IBOutlet UIButton *btn;

}
@property (nonatomic,strong) IBOutlet UIView *line;


-(void)loadDetail:(NSDictionary *)dict;


@end
