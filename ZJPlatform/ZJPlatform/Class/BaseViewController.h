//
//  BaseViewController.h
//  shop
//  Created by fengke on 16/3/22.
//  Copyright © 2016年 com.ugo.shop. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "Utility.h"
#import "Toast.h"
#import "MBProgressHUD+Add.h"
#import "MyNavigationController.h"
//#import "FeildView.h"

@interface BaseViewController : UIViewController
{
 //   FeildView *feildView;

}


-(void)setTitleView:(NSString *)title;
- (void)createBackBtn;
-(void)goBack:(id)sender;

-(void)createLeftWithTitle:(NSString *)title;
-(void)createRightWithTitle:(NSString *)title;
-(void)clickRightBtn;
-(void)clickLeftBtn;

-(void)showAlert:(NSString *)text;

@end
