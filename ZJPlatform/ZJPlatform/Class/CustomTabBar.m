//
//  CustomTabBar.m
//  taiping_poc
//
//  Created by fk on 13-5-15.
//  Copyright (c) 2013年 fk. All rights reserved.
//

#import "CustomTabBar.h"
#import "HomeViewController.h"
#import "ClassroomViewController.h"
#import "MessageViewController.h"
#import "MyViewController.h"
#import "FindViewController.h"

@interface CustomTabBar()
{
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

    HomeViewController *vc1 = [[HomeViewController alloc] init];
    MyNavigationController *nav1 = [[MyNavigationController alloc] initWithRootViewController:vc1];
    
    
    
    ClassroomViewController *vc2 = [[ClassroomViewController alloc] init];
    MyNavigationController *nav2 = [[MyNavigationController alloc] initWithRootViewController:vc2];

    FindViewController *vc3 = [[FindViewController alloc] init];
    MyNavigationController *nav3 = [[MyNavigationController alloc] initWithRootViewController:vc3];
    
    
    MessageViewController *vc4 = [[MessageViewController alloc] initWithStyle:UITableViewStylePlain];
    MyNavigationController *nav4 = [[MyNavigationController alloc] initWithRootViewController:vc4];
 
    MyViewController *vc5 = [[MyViewController alloc] initWithStyle:UITableViewStyleGrouped];
    MyNavigationController *nav5 = [[MyNavigationController alloc] initWithRootViewController:vc5];

    self.viewControllers = [NSArray arrayWithObjects:nav1,nav2,nav3,nav4,nav5, nil];
 
    [self hideRealTabBar];
    [self customTabBar];
    
}


- (void)customTabBar{

    
    UIView *view = [[UIView  alloc] initWithFrame:CGRectMake(0, 0, MainScreenBounds.size.width, Tabbar_Height)];
    view.backgroundColor = [UIColor whiteColor];
    
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
        label.font = SmallFont;
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor =  [UIColor colorWithHexString:@"000000"];
        [btn addSubview:label];
        label.tag = 11;
        
        if (i == 0) {
            label.text= @"首页";
        }else if(i == 1){
            label.text= @"课堂";
            
            
        }else if(i == 2){
            label.text= @"发现";
        }else if(i == 3){
            label.text= @"消息";
        }else{
            label.text= @"我";

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
    
    [self selectedTab:[self.buttons objectAtIndex:0]];
}

-(void)selectedIndex:(NSInteger)index{
    [self selectedTab:[self.buttons objectAtIndex:index]];
 }



- (void)selectedTab:(UIButton *)button{
    
    
    if (self.currentBtn) {
        if ([self.buttons indexOfObject:button] != 0) {
            CheckLogin;
        }
        UIImageView *imgView = (UIImageView *)[self.currentBtn viewWithTag:22];
        [imgView setImage:[UIImage imageNamed:[NSString stringWithFormat:@"tabbar_%d.png",self.currentSelectedIndex+1]]];

    }
    self.currentSelectedIndex = (int)button.tag;
    self.currentBtn = button;
    

    UIImageView *imgView_ = (UIImageView *)[self.currentBtn viewWithTag:22];
    [imgView_ setImage:[UIImage imageNamed:[NSString stringWithFormat:@"tabbar_%d_Selected.png",self.currentSelectedIndex+1]]];
    

//    UILabel *label_ = (UILabel *)[self.currentBtn viewWithTag:11];
//    label_.textColor = MainColor;

    
    self.selectedIndex = self.currentSelectedIndex;
   
}



//设置标题
-(void)setTitleView:(NSString *)title
{
    if (labelTitle == nil) {
        labelTitle = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 210, 30)];
        [labelTitle  setText:@" "];
        [labelTitle setFont:TitleFont];
        [labelTitle setTextColor:[UIColor whiteColor]];
        [labelTitle setTextAlignment:NSTextAlignmentCenter];
        [labelTitle setBackgroundColor:[UIColor clearColor]];
        self.navigationItem.titleView = labelTitle;
    }
    labelTitle.text = title;


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
