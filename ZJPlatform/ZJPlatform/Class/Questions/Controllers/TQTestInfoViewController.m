//
//  TQTestInfoViewController.m
//  ZJPlatform
//
//  Created by Rongbo Li on 2018/7/22.
//  Copyright © 2018年 wzsd. All rights reserved.
//

#import "TQTestInfoViewController.h"

@interface TQTestInfoViewController ()

@end

@implementation TQTestInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self createBackBtn];
    self.navigationController.title = self.titleStr;
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
