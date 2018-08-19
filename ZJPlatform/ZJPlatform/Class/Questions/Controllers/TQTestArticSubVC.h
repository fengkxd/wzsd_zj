//
//  TQTestArticSubVC.h
//  ZJPlatform
//
//  Created by fengke on 2018/8/19.
//  Copyright © 2018年 wzsd. All rights reserved.
//

#import "BaseTableViewController.h"

@interface TQTestArticSubVC : BaseTableViewController

@property (nonatomic,assign) NSInteger totalCount;
@property (nonatomic,assign) NSInteger curNum;

@property (nonatomic,assign) NSInteger type;
@property (nonatomic,strong) NSDictionary *articleDict;

@property (nonatomic,strong) UITextView *myTextView;
@end
