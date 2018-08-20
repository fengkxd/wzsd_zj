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

@property (nonatomic,assign)BOOL isSel;

-(void)loadInfo:(NSDictionary *)dict;
-(void)loadEveryDayStudy:(NSDictionary *)dict;
-(void)setAnswer:(BOOL)flag;


-(void)loadReuslt:(NSDictionary *)dict;

@end
