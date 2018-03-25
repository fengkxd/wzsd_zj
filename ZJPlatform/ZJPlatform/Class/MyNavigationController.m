//
//  MyNavigationController.m
//  shop
//  Created by fengke on 16/3/22.
//  Copyright © 2016年 com.ugo.shop. All rights reserved.
//

#import "MyNavigationController.h"


@interface MyNavigationController ()
@property (nonatomic,strong) NSArray *AutorotateViewControllers;

@property (nonatomic,strong) NSArray *HiddenBarViewControllers;
@end

@implementation MyNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
//    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    [self.navigationBar setTintColor:[UIColor whiteColor]];
    [self.navigationBar setBarTintColor:MainBlueColor];
    [self.navigationBar setTitleTextAttributes: [NSDictionary dictionaryWithObjectsAndKeys:
                                                           [UIColor whiteColor], NSForegroundColorAttributeName, TitleFont, NSFontAttributeName, nil]];

    self.navigationBar.translucent = NO;
    
    
    self.HiddenBarViewControllers = @[@"MineCenterViewController"];
//    self.AutorotateViewControllers = [NSArray arrayWithObjects:@"BankHomeViewController",nil];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    [super pushViewController:viewController animated:animated];

    NSString *vcStr = NSStringFromClass([viewController class]);
    if ([self.HiddenBarViewControllers containsObject:vcStr]) {
        [[UIApplication sharedApplication] setStatusBarHidden:YES];
        [self setNavigationBarHidden:YES animated:NO];

    }
    
}


-(UIViewController *)popViewControllerAnimated:(BOOL)animated{
    NSString *vcStr = NSStringFromClass([[self.viewControllers lastObject] class]);
    if ([self.HiddenBarViewControllers containsObject:vcStr]) {
        [self setNavigationBarHidden:NO animated:NO];
        [[UIApplication sharedApplication] setStatusBarHidden:NO];
        
    }    return   [super popViewControllerAnimated:animated];
}




- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    
    
//    if ([self.AutorotateViewControllers containsObject:NSStringFromClass([self.topViewController class])]) {
//        return [self.topViewController shouldAutorotateToInterfaceOrientation:interfaceOrientation];
//    }
//    
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

-(BOOL)shouldAutorotate
{
    
//      if ([self.AutorotateViewControllers containsObject:NSStringFromClass([self.topViewController class])]) {
//        return [self.topViewController shouldAutorotate];
//    }
//    
    
    return NO;
}

-(UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    
//    if ([self.AutorotateViewControllers containsObject:NSStringFromClass([self.topViewController class])]) {
//        return [self.topViewController supportedInterfaceOrientations];
//    }
    
    return UIInterfaceOrientationMaskPortrait;
}


@end
