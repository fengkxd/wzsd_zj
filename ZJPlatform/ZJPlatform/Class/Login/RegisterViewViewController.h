//
//  RegisterViewViewController.h
//  ZJPlatform
//
//  Created by fengke on 2018/3/25.
//  Copyright © 2018年 wzsd. All rights reserved.
//

#import "BaseViewController.h"

@interface RegisterViewViewController : BaseViewController
{
    IBOutlet UIView *view1;
    IBOutlet UIView *view2;
    IBOutlet UIView *view3;

    IBOutlet UIButton *codeBtn;
    IBOutlet UIButton *registerBtn;

    IBOutlet UITextField *phoneTextFeild;
    IBOutlet UITextField *checkCodeTextFeild;
    IBOutlet UITextField *passwordTextFeild;

}
@end
