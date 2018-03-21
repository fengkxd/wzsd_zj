//
//  BaseTableViewController.h
//  shop
//
//  Created by fengke on 16/2/21.
//  Copyright © 2016年 com.xhhc. All rights reserved.
//



#import <UIKit/UIKit.h>
#import "Utility.h"
#import "MJRefresh.h"
#import "Toast.h"
#import "MBProgressHUD+Add.h"
#import "MyNavigationController.h"


@interface BaseTableViewController : UITableViewController

{
    FeildView *feildView;

}

-(void)setTitleView:(NSString *)title;
- (void)createBackBtn;
-(void)goBack:(id)sender;

-(void)createRightWithTitle:(NSString *)title;


-(void)createLeftWithTitle:(NSString *)title;
-(void)clickRightBtn;

-(void)reload;

-(void)endRefreshing;
-(void)beginRefreshing;

-(void)showAlert:(NSString *)text;

@end
