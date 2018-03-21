//
//  CustomTabBar.h
//  taiping_poc
//
//  Created by fk on 13-5-15.
//  Copyright (c) 2013年 fk. All rights reserved.
//

#import <UIKit/UIKit.h>


#import "MyNavigationController.h"

#define  Tabbar_Height  49

@interface CustomTabBar : UITabBarController {
    NSMutableArray *buttons;
    int currentSelectedIndex;
    UILabel *labelTitle;

    
}

@property (nonatomic,assign) int currentSelectedIndex;
@property (nonatomic,strong) NSMutableArray *buttons;
@property (nonatomic,strong) UIButton *currentBtn;


- (void)hideRealTabBar;
- (void)customTabBar;
- (void)selectedTab:(UIButton *)button;

-(void)selectedIndex:(NSInteger)index;

@end
