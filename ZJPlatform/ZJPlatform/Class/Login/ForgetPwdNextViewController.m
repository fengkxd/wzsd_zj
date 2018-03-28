//
//  ForgetPwdNextViewController.m
//  ZJPlatform
//
//  Created by sostag on 2018/3/28.
//  Copyright © 2018年 wzsd. All rights reserved.
//

#import "ForgetPwdNextViewController.h"

@interface ForgetPwdNextViewController ()

@end

@implementation ForgetPwdNextViewController



//设置标题
-(void)setTitleView:(NSString *)title
{
    UILabel *labelTitle = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 210, 44)];
    labelTitle.text = title;
    [labelTitle setFont:TitleFont];
    [labelTitle setTextColor:[UIColor colorWithHexString:@"333333"]];
    [labelTitle setTextAlignment:NSTextAlignmentCenter];
    [labelTitle setBackgroundColor:[UIColor clearColor]];
    self.navigationItem.titleView = labelTitle;
}


//设置返回按钮
- (void)createBackBtn{
    UIImage *imgBack = [UIImage imageNamed:@"back_black.png"];
    UIButton *_backBtnView =[UIButton buttonWithType:UIButtonTypeCustom];
    
    _backBtnView.frame = CGRectMake(0, 0, 40, 40);
    
    [_backBtnView setImage:imgBack
                  forState:UIControlStateNormal];
    
    [_backBtnView addTarget:self action:@selector(goBack:) forControlEvents:UIControlEventTouchUpInside];
    
    _backBtnView.imageEdgeInsets = UIEdgeInsetsMake(0, -20, 0, 0);
    UIBarButtonItem *_backBtn = [[UIBarButtonItem alloc] initWithCustomView:_backBtnView];
    self.navigationItem.leftBarButtonItem = _backBtn;
}


- (void)viewDidLoad {
    [super viewDidLoad];

    [self setTitleView:@"密码找回"];
    [self createBackBtn];
    
    view1.layer.masksToBounds = YES;
    view1.layer.cornerRadius = 2;
    view1.layer.borderColor = [UIColor colorWithHexString:@"dedede"].CGColor;
    view1.layer.borderWidth = 0.5;
    
    view2.layer.masksToBounds = YES;
    view2.layer.cornerRadius = 2;
    view2.layer.borderColor = [UIColor colorWithHexString:@"dedede"].CGColor;
    view2.layer.borderWidth = 0.5;
    
    view3.layer.masksToBounds = YES;
    view3.layer.cornerRadius = 2;
    view3.layer.borderColor = [UIColor colorWithHexString:@"dedede"].CGColor;
    view3.layer.borderWidth = 0.5;
    
    commitBtn.layer.masksToBounds = YES;
    commitBtn.layer.cornerRadius = 2;


}





@end
