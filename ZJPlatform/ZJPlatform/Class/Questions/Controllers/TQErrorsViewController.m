//
//  TQErrorsViewController.m
//  ZJPlatform
//
//  Created by Rongbo Li on 2018/4/3.
//  Copyright © 2018年 wzsd. All rights reserved.
//

#import "TQErrorsViewController.h"

@interface TQErrorsViewController ()

@end

@implementation TQErrorsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self setTitleView:@"我的错题集"];
    [self createBackBtn];
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
