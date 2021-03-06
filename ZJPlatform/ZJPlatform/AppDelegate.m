//
//  AppDelegate.m
//  ZJPlatform
//
//  Created by sostag on 2018/3/21.
//  Copyright © 2018年 wzsd. All rights reserved.
//

#import "AppDelegate.h"
#import "HostSelectedTypeViewController.h"
#import <CNCLiveMediaPlayerFramework/CNCMediaPlayerFramework.h>

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    NSString *app_id = @"szzj";
    NSString *auth_key = @"63254606F0E548AE858B06542B4BD014";
    CNC_MediaPlayer_ret_Code ret = [CNCMediaPlayerSDK regist_app:app_id auth_key:auth_key];
    if (ret == CNC_MediaPlayer_RCode_Success) {
        
        
    }else{
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"notice" message:[NSString stringWithFormat:@"SDK鉴权失败 业务接口不可用 ret = %@", @(ret)] delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:nil, nil];
        [alert show];
        
    }
 
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    NSDictionary *sel_subject = [Utility objectForKey:Sel_Subject];
    
    if (sel_subject == nil) {
        [self loadSelectTypeVc];
    }else{
        
        [self loadTabbarVc];
    }
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:NO];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:NO];

    return YES;
}




-(void)loadTabbarVc{
    self.customTabBar = [[CustomTabBar alloc] init];
    self.window.rootViewController = self.customTabBar;
    [self.window makeKeyAndVisible];

}




-(void)loadSelectTypeVc{
    HostSelectedTypeViewController *vc = [[HostSelectedTypeViewController alloc] init];
    [vc setHidesBottomBarWhenPushed:YES];
    MyNavigationController *nav = [[MyNavigationController alloc] initWithRootViewController:vc];
    WS(weakSelf);
    vc.selectedBlock = ^{
        [weakSelf loadTabbarVc];
    };
    self.window.rootViewController = nav;
    [self.window makeKeyAndVisible];
}




- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
