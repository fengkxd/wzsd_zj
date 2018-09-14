//
//  SetPwdViewController.m
//  dragonlion
//
//  Created by sostag on 2017/6/10.
//  Copyright © 2017年 sostag. All rights reserved.
//

#import "ChangePwdViewController.h"

@interface ChangePwdViewController ()
{
    IBOutlet UITextField *pwd1;
    IBOutlet UITextField *pwd2;
    IBOutlet UITextField *pwd3;
    IBOutlet UIView *bgView1;
    IBOutlet UIView *bgView2;
    IBOutlet UIView *bgView3;

}
@end

@implementation ChangePwdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    bgView1.layer.borderWidth = 0.5;
    bgView1.layer.borderColor = [UIColor colorWithHexString:@"dbdbdb"].CGColor;
    bgView1.layer.masksToBounds = YES;
    bgView1.layer.cornerRadius = 4;
    
    bgView2.layer.borderWidth = 0.5;
    bgView2.layer.borderColor = [UIColor colorWithHexString:@"dbdbdb"].CGColor;
    bgView2.layer.masksToBounds = YES;
    bgView2.layer.cornerRadius = 4;
    
    
    bgView3.layer.borderWidth = 0.5;
    bgView3.layer.borderColor = [UIColor colorWithHexString:@"dbdbdb"].CGColor;
    bgView3.layer.masksToBounds = YES;
    bgView3.layer.cornerRadius = 4;
    [self createBackBtn];
    [self setTitleView:@"修改密码"];
    [self createRightWithTitle:@"保存"];
    
    [pwd1 becomeFirstResponder];
    
}


-(void)clickRightBtn{
    if ([Utility isBlank:pwd1.text] ||
        [Utility isBlank:pwd2.text] ||
        [Utility isBlank:pwd3.text] ) {
        [Toast showWithText:@"请输入密码"];
        return;
    }
    if (![pwd3.text isEqualToString:pwd2.text]) {
        [Toast showWithText:@"两次密码不一致"];
        return;
    }
    
    if (pwd2.text.length < 6||
        pwd3.text.length < 6 ) {
        [Toast showWithText:@"密码长度必须为6-20字符"];
        return;
    }

    if (pwd2.text.length >20||
        pwd3.text.length >20 ) {
        [Toast showWithText:@"密码长度必须为6-20字符"];
        return;
    }
    

       NSDictionary *dict = @{@"password":[[Utility md5:pwd1.text] lowercaseString],@"newPassword":[[Utility md5:pwd2.text] lowercaseString]};

 
        NSString *url = [NSString stringWithFormat:@"%@%@",ProxyUrl,kRequest_member_updatePassword];
        WS(weakSelf);
        [[NetworkManager shareNetworkingManager] requestWithMethod:@"POST"
                                                     headParameter:nil
                                                     bodyParameter:dict
                                                      relativePath:url
                                                           success:^(id responseObject) {
                                                               NSLog(@"修改密码：%@",responseObject);
                                                               [Toast showWithText:@"修改成功"];
                                                               [weakSelf.navigationController popViewControllerAnimated:YES];
                                                               
                                                           } failure:^(NSString *errorMsg) {
                                                               [Toast showWithText:errorMsg];
                                                               
                                                           }];

    
}


@end
