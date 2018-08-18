//
//  TQHistoryViewController.h
//  ZJPlatform
//
//  Created by Rongbo Li on 2018/4/1.
//  Copyright © 2018年 wzsd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TQHistoryViewController : BaseViewController

@property (nonatomic, weak) IBOutlet UITableView *myTable;

@property (nonatomic,assign) NSInteger type;

@property (nonatomic,strong) NSString *courseClassifyId;

//1.巩固练习 2.全真模拟 3.历年真题

@end
