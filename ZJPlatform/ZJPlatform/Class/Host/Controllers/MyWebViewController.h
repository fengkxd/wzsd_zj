//
//  MyWebViewController.h
//  dragonlion
//
//  Created by sostag on 2017/6/8.
//  Copyright © 2017年 sostag. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@interface MyWebViewController : BaseViewController


-(void)loadHtmlStr:(NSString *)str;
-(void)loadUrlStr:(NSString *)urlStr;
@end
