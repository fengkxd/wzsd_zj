//
//  SetPwdViewController.m
//  ZJPlatform
//
//  Created by fengke on 2018/3/25.
//  Copyright © 2018年 wzsd. All rights reserved.
//

#import "SetPwdViewController.h"

@interface SetPwdViewController ()

@end

@implementation SetPwdViewController




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
    [self setTitleView:@"绑定手机"];
    [self createBackBtn];
    
    
    view1.layer.masksToBounds = YES;
    view1.layer.cornerRadius = 2;
    view1.layer.borderColor = [UIColor colorWithHexString:@"dedede"].CGColor;
    view1.layer.borderWidth = 0.5;
    
    view2.layer.masksToBounds = YES;
    view2.layer.cornerRadius = 2;
    view2.layer.borderColor = [UIColor colorWithHexString:@"dedede"].CGColor;
    view2.layer.borderWidth = 0.5;
    
    codeBtn.layer.masksToBounds = YES;
    codeBtn.layer.cornerRadius = 2;
    commitBtn.layer.masksToBounds = YES;
    commitBtn.layer.cornerRadius = 2;
    



}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
