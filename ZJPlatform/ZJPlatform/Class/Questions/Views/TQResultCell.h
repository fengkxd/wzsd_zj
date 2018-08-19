//
//  TQResultCell.h
//  ZJPlatform
//
//  Created by fengke on 2018/8/19.
//  Copyright © 2018年 wzsd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TQResultCell : UITableViewCell
{
    UIButton *checkBtn;
    UILabel *resultInro;
    
    
}
-(void)loadInfo:(NSDictionary *)dict;

-(void)setAnswer:(BOOL)flag;
@end
