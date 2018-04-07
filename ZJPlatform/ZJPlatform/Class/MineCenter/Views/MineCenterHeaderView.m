//
//  MineCenterHeaderView.m
//  ZJPlatform
//
//  Created by sostag on 2018/3/26.
//  Copyright © 2018年 wzsd. All rights reserved.
//

#import "MineCenterHeaderView.h"

@implementation MineCenterHeaderView




-(IBAction)showLogin:(id)sender{
    SHOW_LOGIN
}


-(IBAction)showSetting:(id)sender{
    self.clickSetting();
}

-(IBAction)showMsg:(id)sender{
    self.clickMsg();
}

-(IBAction)showScan:(id)sender{
    self.clickScan();
}


@end
