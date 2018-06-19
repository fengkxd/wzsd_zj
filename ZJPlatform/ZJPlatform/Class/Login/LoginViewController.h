//
//  LoginViewController.h
//  ZJPlatform
//
//  Created by fengke on 2018/3/24.
//  Copyright © 2018年 wzsd. All rights reserved.
//

#import "BaseViewController.h"

@interface LoginViewController : BaseViewController
{
    IBOutlet UIView *view1;
    IBOutlet UIView *view2;
    
    
    IBOutlet UIView *view3;
    IBOutlet UIView *view4;

    
    IBOutlet UIButton *loginBtn;
    IBOutlet UIButton *registerBtn;
    IBOutlet UIButton *codeBtn;

    
    IBOutlet UIButton *leftBtn;
    IBOutlet UIButton *rightBtn;
 
    
    
    IBOutlet UILabel *logLabel;
    
    
    
    IBOutlet UIView *loginView;
    IBOutlet UIView *registerView;
    
    
    IBOutlet UITextField *accountTextField;
    IBOutlet UITextField *pwdtextField;
}



@end
