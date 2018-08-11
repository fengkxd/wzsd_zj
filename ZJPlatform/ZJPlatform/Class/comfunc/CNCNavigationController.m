//
//  CNCNavigationController.m
//  CNCMediaPlayerDemo
//
//  Created by Hjf on 16/10/28.
//  Copyright © 2016年 CNC. All rights reserved.
//

#import "CNCNavigationController.h"

@interface CNCNavigationController ()

@end

@implementation CNCNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)shouldAutorotate {
    return self.topViewController.shouldAutorotate;
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
