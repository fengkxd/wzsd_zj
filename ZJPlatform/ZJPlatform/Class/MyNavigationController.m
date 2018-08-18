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
    

   [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    [self.navigationBar setTintColor:[UIColor whiteColor]];
    [self.navigationBar setBarTintColor:MainBlueColor];
    [self.navigationBar setTitleTextAttributes: [NSDictionary dictionaryWithObjectsAndKeys:
                                                           [UIColor whiteColor], NSForegroundColorAttributeName, TitleFont, NSFontAttributeName, nil]];

    self.navigationBar.translucent = NO;
    
    self.HiddenBarViewControllers = @[@"MineCenterViewController"];

//    self.HiddenBarViewControllers = @[@"MineCenterViewController",@"SelCourseDetailViewController"];
//    self.AutorotateViewControllers = [NSArray arrayWithObjects:@"BankHomeViewController",nil];

}


- (UIStatusBarStyle)preferredStatusBarStyle

{
//    UIViewController* topVC = self.topViewController;
//    return [topVC preferredStatusBarStyle];
    
      return UIStatusBarStyleDefault;
    
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    if ([self.viewControllers count] == 1) {
        [viewController setHidesBottomBarWhenPushed:YES];
    }
    if ([Utility isBlank:USERNAME] && [Utility isBlank:PASSWORD]) {
        [[NSNotificationCenter defaultCenter] postNotificationName:kNotification_SHOW_LOGIN object:nil];
        return;
    }
    [super pushViewController:viewController animated:animated];

    NSString *vcStr = NSStringFromClass([viewController class]);
    if ([self.HiddenBarViewControllers containsObject:vcStr]) {
        [self setNavigationBarHidden:YES animated:YES];
    }else{
        if (self.navigationBarHidden == YES) {
            [self setNavigationBarHidden:NO animated:YES];
        }
        
    }
    
}


-(UIViewController *)popViewControllerAnimated:(BOOL)animated{
    NSString *vcStr = NSStringFromClass([[self.viewControllers firstObject] class]);
    
    if ([self.viewControllers count] == 2 && [self.HiddenBarViewControllers containsObject:vcStr]) {

        [self setNavigationBarHidden:YES animated:NO];
    }
    if ([self.HiddenBarViewControllers containsObject:NSStringFromClass([[self.viewControllers lastObject] class])]) {
        [self setNavigationBarHidden:NO animated:YES];
    }
    
    
    
    return   [super popViewControllerAnimated:animated];
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
