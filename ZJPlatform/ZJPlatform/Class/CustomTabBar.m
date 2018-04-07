//
//  CustomTabBar.m
//  taiping_poc
//
//  Created by fk on 13-5-15.
//  Copyright (c) 2013年 fk. All rights reserved.
//

#import "CustomTabBar.h"
#import "HostViewController.h"
#import "MineCenterViewController.h"
#import "QuestionsViewController.h"
#import "SelCourseViewController.h"
#import "LiveBroadcastViewController.h"
#import "LoginViewController.h"

@interface CustomTabBar()
{
    
    UIView *shadeView;
}
@end

@implementation CustomTabBar

@synthesize currentSelectedIndex;
@synthesize buttons;
@synthesize currentBtn;

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
 
}

- (void)hideRealTabBar{
    for(UIView *view in self.view.subviews){
        if([view isKindOfClass:[UITabBar class]]){
        //    view.hidden = YES;
            break;
        }
    }
}


-(void)shopCartBadge:(NSNotification *)notification{
 
 
}

//- (BOOL)prefersStatusBarHidden
//{
//    return NO;
//}
//
//- (UIStatusBarStyle)preferredStatusBarStyle
//{
//    return UIStatusBarStyleLightContent;
//}


-(void)viewDidLoad{
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];

    HostViewController *vc1 = [[HostViewController alloc] init];
    MyNavigationController *nav1 = [[MyNavigationController alloc] initWithRootViewController:vc1];
    
    
    
    SelCourseViewController *vc2 = [[SelCourseViewController alloc] init];
    MyNavigationController *nav2 = [[MyNavigationController alloc] initWithRootViewController:vc2];

    LiveBroadcastViewController *vc3 = [[LiveBroadcastViewController alloc] init];
    MyNavigationController *nav3 = [[MyNavigationController alloc] initWithRootViewController:vc3];
    
    
    QuestionsViewController *vc4 = [[QuestionsViewController alloc] init];
    MyNavigationController *nav4 = [[MyNavigationController alloc] initWithRootViewController:vc4];
 
    MineCenterViewController *vc5 = [[MineCenterViewController alloc] initWithStyle:UITableViewStyleGrouped];
    MyNavigationController *nav5 = [[MyNavigationController alloc] initWithRootViewController:vc5];

    self.viewControllers = [NSArray arrayWithObjects:nav1,nav2,nav3,nav4,nav5, nil];
 
    [self hideRealTabBar];
    [self customTabBar];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showlogin) name:kNotification_SHOW_LOGIN object:nil];
    
}


- (void)customTabBar{

    
    UIView *view = [[UIView  alloc] initWithFrame:CGRectMake(0, 0, MainScreenBounds.size.width, Tabbar_Height)];
    view.backgroundColor = [UIColor colorWithHexString:@"f7f7f7"];
    
    [self.tabBar addSubview:view];
    //创建按钮
    NSInteger viewCount = self.viewControllers.count > 5 ? 5 : self.viewControllers.count;
    self.buttons = [NSMutableArray arrayWithCapacity:viewCount];
    double _width = MainScreenBounds.size.width / viewCount;
    double _height = self.tabBar.frame.size.height;
    
    
    for (int i = 0; i < viewCount; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(i*_width,0, _width, _height);
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn setBackgroundColor:[UIColor clearColor]];
         [btn addTarget:self action:@selector(selectedTab:) forControlEvents:UIControlEventTouchDown];

        btn.tag = i;
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 22, btn.frame.size.width, 30)];
        label.font = Font_12;
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor =  [UIColor colorWithHexString:@"8d8d8d"];
        [btn addSubview:label];
        label.tag = 11;
        
        if (i == 0) {
            label.text= @"首页";
        }else if(i == 1){
            label.text= @"选课";
            
            
        }else if(i == 2){
            label.text= @"直播";
        }else if(i == 3){
            label.text= @"题库";
        }else{
            label.text= @"我的";

        }
        UIImage *tempImg = [UIImage imageNamed:[NSString stringWithFormat:@"tabbar_%d.png",i+1]];
        UIImageView *imgView = [[UIImageView alloc] initWithImage:tempImg];
        imgView.center = CGPointMake(label.center.x, btn.center.y - 7);
        [btn addSubview:imgView];
        imgView.tag = 22;
        [btn sendSubviewToBack:imgView];
        [self.buttons addObject:btn];
        [self.tabBar addSubview:btn];
     }
    
    shadeView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 50, 43)];
    shadeView.backgroundColor = MainBlueColor;
    shadeView.alpha = 0.2;
    shadeView.layer.cornerRadius = 4;
    shadeView.layer.masksToBounds = YES;
    [self.tabBar addSubview:shadeView];
    
    [self selectedTab:[self.buttons objectAtIndex:0]];
}

-(void)selectedIndex:(NSInteger)index{
    [self selectedTab:[self.buttons objectAtIndex:index]];
 }



- (void)selectedTab:(UIButton *)button{
   
    
    if (self.currentBtn) {
        UIImageView *imgView = (UIImageView *)[self.currentBtn viewWithTag:22];
        [imgView setImage:[UIImage imageNamed:[NSString stringWithFormat:@"tabbar_%d.png",self.currentSelectedIndex+1]]];
        UILabel *label_ = (UILabel *)[self.currentBtn viewWithTag:11];
        label_.textColor = [UIColor colorWithHexString:@"8d8d8d"];
    }
    
    self.currentSelectedIndex = (int)button.tag;
    self.currentBtn = button;

    shadeView.center = self.currentBtn.center;
    
    UIImageView *imgView_ = (UIImageView *)[self.currentBtn viewWithTag:22];
    [imgView_ setImage:[UIImage imageNamed:[NSString stringWithFormat:@"tabbar_%d_h.png",self.currentSelectedIndex+1]]];

    UILabel *label_ = (UILabel *)[self.currentBtn viewWithTag:11];
    label_.textColor = MainBlueColor;

    
    
    self.selectedIndex = self.currentSelectedIndex;
   
}





-(void)showlogin{
    LoginViewController *vc = [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
    MyNavigationController *nav = [[MyNavigationController alloc] initWithRootViewController:vc];
    UIViewController *curVc = [Utility getCurrentRootViewController];
    if (curVc) {
        [curVc presentViewController:nav animated:YES completion:nil];
    }
}




- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    
    
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

-(BOOL)shouldAutorotate
{
    
    return NO;
}

-(UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
}



@end
