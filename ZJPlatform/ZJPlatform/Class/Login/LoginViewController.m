//
//  LoginViewController.m
//  ZJPlatform
//
//  Created by fengke on 2018/3/24.
//  Copyright © 2018年 wzsd. All rights reserved.
//

#import "LoginViewController.h"
#import "CJLabel.h"
#import "RegisterViewViewController.h"
#import "SetPwdViewController.h"
#import "ForgetPwdViewController.h"


@interface LoginViewController ()
{

    UIView *makeView;

}
@end

@implementation LoginViewController

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


-(void)createRightWithTitle:(NSString *)title{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 40, 40);
    btn.titleLabel.font = TitleFont;
    if ([title hasSuffix:@".png"]) {
        [btn setImage:[UIImage imageNamed:title] forState:UIControlStateNormal];
        btn.imageEdgeInsets = UIEdgeInsetsMake(0, 20, 0, 0);
    }else{
        [btn setTitle:title forState:UIControlStateNormal];
    }
    [btn setTitleColor:MainBlueColor forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(clickRightBtn) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
}

-(void)clickRightBtn{
    RegisterViewViewController *vc = [[RegisterViewViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithHexString:@"f7f7f7"]];
    
    view1.layer.masksToBounds = YES;
    view1.layer.cornerRadius = 2;
    view1.layer.borderColor = [UIColor colorWithHexString:@"dedede"].CGColor;
    view1.layer.borderWidth = 0.5;

    view2.layer.masksToBounds = YES;
    view2.layer.cornerRadius = 2;
    view2.layer.borderColor = [UIColor colorWithHexString:@"dedede"].CGColor;
    view2.layer.borderWidth = 0.5;

    loginBtn.layer.masksToBounds = YES;
    loginBtn.layer.cornerRadius = 2;

    view3.layer.masksToBounds = YES;
    view3.layer.cornerRadius = 2;
    view3.layer.borderColor = [UIColor colorWithHexString:@"dedede"].CGColor;
    view3.layer.borderWidth = 0.5;
    
    view4.layer.masksToBounds = YES;
    view4.layer.cornerRadius = 2;
    view4.layer.borderColor = [UIColor colorWithHexString:@"dedede"].CGColor;
    view4.layer.borderWidth = 0.5;
    
    registerBtn.layer.masksToBounds = YES;
    registerBtn.layer.cornerRadius = 2;
    codeBtn.layer.masksToBounds = YES;
    codeBtn.layer.cornerRadius = 2;
    

    
    
    CGFloat width = [self widthWithString:leftBtn.titleLabel.text font:Font_13];
    makeView = [[UIView alloc] initWithFrame:CGRectMake((leftBtn.frame.size.width - width) / 2, 39, width, 1)];
    makeView.backgroundColor = MainBlueColor;
    [leftBtn addSubview:makeView];
    
    [self setTitleView:@"登录中教"];
    [self createBackBtn];
    [self createRightWithTitle:@"注册"];
    
    UIView *leftline = [[UIView alloc] initWithFrame:CGRectMake(10, 0, (MainScreenWidth - 105 - 20)/2, 0.5)];
    leftline.backgroundColor = [UIColor colorWithHexString:@"dddddd"];
    leftline.center = CGPointMake(leftline.center.x, logLabel.center.y + 4);
    [self.view addSubview:leftline];
    
    
    UIView *rightLine = [[UIView alloc] initWithFrame:CGRectMake( (MainScreenWidth + 105 )/2  , 0, (MainScreenWidth - 105 - 20)/2, 0.5)];
    rightLine.backgroundColor = [UIColor colorWithHexString:@"dddddd"];
    rightLine.center = CGPointMake(rightLine.center.x, logLabel.center.y+ 4);
    [self.view addSubview:rightLine];

    
    CJLabel *label = [[CJLabel alloc] initWithFrame:CGRectMake(0, MainScreenheight - 64 - 40, MainScreenWidth , 25)];
    label.text = @"未注册用户将自动注册并同意《中教文化服务条款》";
    label.textColor = [UIColor colorWithHexString:@"999999"];
    label.font = Font_12;
    label.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:label];
    WS(weakSelf);
    [label addLinkString:@"《中教文化服务条款》" linkAddAttribute:@{NSForegroundColorAttributeName:[UIColor blueColor]} linkParameter:@{@"id":@"1",@"type":@"text"} block:^(CJLinkLabelModel *linkModel) {
        NSLog(@"11111111");
//        MyWebViewController *vc = [[MyWebViewController alloc] init];
//        [vc setTitleView:@"裁判年审"];
//        [vc loadUrlWithStr:[NSString stringWithFormat:@"%@%@",ProxyUrl,kURL_ExaminedHtml]];
//        vc.hidesBottomBarWhenPushed = YES;
//        [weakSelf.navigationController pushViewController:vc animated:YES];
    }];
}


-(IBAction)forgetPwd:(id)sender
{

    ForgetPwdViewController *vc = [[ForgetPwdViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}


// 定义成方法方便多个label调用 增加代码的复用性
- (CGFloat)widthWithString:(NSString *)string font:(UIFont *)font
{
    CGRect rect = [string boundingRectWithSize:CGSizeMake(200, MAXFLOAT)//限制最大的宽度和高度
                                       options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesFontLeading  |NSStringDrawingUsesLineFragmentOrigin//采用换行模式
                                    attributes:@{NSFontAttributeName: font}//传人的字体字典
                                       context:nil];
    
    return rect.size.width;
}


-(IBAction)login{
    accountTextField.text = @"13071418125";
    pwdtextField.text = @"123456";
    
    if ([Utility isBlank:accountTextField.text] || [Utility isBlank:pwdtextField.text]) {
        [Toast showWithText:@"请输入正确信息"];
        return;
    }
    
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSString *url = [NSString stringWithFormat:@"%@%@",ProxyUrl,kRequest_signin];
    WS(weakSelf);
    NSDictionary *dict = @{@"account":accountTextField.text,@"password":[[Utility md5:pwdtextField.text] lowercaseString]};
    [[NetworkManager shareNetworkingManager] requestWithMethod:@"POST" headParameter:nil bodyParameter:dict relativePath:url success:^(id responseObject) {
        [MBProgressHUD hideAllHUDsForView:weakSelf.view animated:YES];

        [[NSNotificationCenter defaultCenter] postNotificationName:kNotification_LOGIN_SUCCESS object:nil];
        [weakSelf goBack:nil];
    } failure:^(NSString *errorMsg) {
        [MBProgressHUD hideAllHUDsForView:weakSelf.view animated:YES];
        [Toast showWithText:errorMsg];
    }];
    
}


-(IBAction)clickBtn:(id)sender{
     CGFloat width = [self widthWithString:[sender titleLabel].text font:Font_13];
    makeView.frame = CGRectMake(([sender frame].size.width - width) / 2, 39, width, 1);
    [sender addSubview:makeView];
    
    NSInteger tag = [sender tag];
    if (tag == 0) {
        loginView.hidden = NO;
        registerView.hidden = YES;
    }else{
        loginView.hidden = YES;
        registerView.hidden = NO;
    }
}


-(IBAction)otherLogin:(id)sender
{
    SetPwdViewController *vc = [[SetPwdViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];



}






@end
