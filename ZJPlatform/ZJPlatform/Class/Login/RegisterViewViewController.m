//
//  RegisterViewViewController.m
//  ZJPlatform
//
//  Created by fengke on 2018/3/25.
//  Copyright © 2018年 wzsd. All rights reserved.
//

#import "RegisterViewViewController.h"
#import "CJLabel.h"

@interface RegisterViewViewController ()
{
    
    NSTimer *timer;
    NSInteger countDown;

}

@property (nonatomic,strong) NSTimer *timer;

@end

@implementation RegisterViewViewController


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
    [self setTitleView:@"注册中教账号"];
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
    
    codeBtn.layer.masksToBounds = YES;
    codeBtn.layer.cornerRadius = 2;
    registerBtn.layer.masksToBounds = YES;
    registerBtn.layer.cornerRadius = 2;


    
    CJLabel *label = [[CJLabel alloc] initWithFrame:CGRectMake(0, 250, MainScreenWidth , 25)];
    label.text = @"注册代表您已阅读并同意《中教文化服务条款》";
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


-(IBAction)sendMsg:(id)sender{
    WS(weakSelf);
    NSString *url = [NSString stringWithFormat:@"%@%@",ProxyUrl,kRequest_Scaptcha_New];
    NSDictionary *dict ;
   
    countDown = 60;
    [self clickBtn];

    return;
    SHOW_HUD;
    [[NetworkManager shareNetworkingManager] requestWithMethod:@"POST"
                                                 headParameter:nil
                                                 bodyParameter:dict
                                                  relativePath:url
                                                       success:^(id responseObject) {
                                                           HIDDEN_HUD;
                                                           NSLog(@"验证码发送：%@",responseObject);
                                                           countDown = 60;
                                                           [weakSelf clickBtn];
                                                       } failure:^(NSString *errorMsg) {
                                                           
                                                           
                                                       }];
    
}





-(void)clickBtn{
    [codeBtn setEnabled:NO];
    [codeBtn setBackgroundColor:[UIColor colorWithHexString:@"dbdbdb"]];
    [codeBtn setTitle:[NSString stringWithFormat:@"%zi秒重新获取", countDown] forState:UIControlStateDisabled];
    countDown--;
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(onTimer) userInfo:nil repeats:YES];
}

- (void)onTimer {
    if (countDown > 0) {
        [codeBtn setBackgroundColor:[UIColor colorWithHexString:@"dbdbdb"]];
        [codeBtn setTitle:[NSString stringWithFormat:@"%zi秒重新获取", countDown] forState:UIControlStateDisabled];
        countDown--;
    } else {
        countDown = 60;
        [self.timer invalidate];
        self.timer = nil;
        [codeBtn setTitle:@"60秒重新获取" forState:UIControlStateDisabled];
        [codeBtn setTitle:@"重发验证码" forState:UIControlStateNormal];
        [codeBtn setEnabled:YES];
        [codeBtn setBackgroundColor:MainBlueColor];
    }
}










@end
