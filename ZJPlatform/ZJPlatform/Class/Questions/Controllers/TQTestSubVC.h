//
//  TQTestSubVC.h
//  ZJPlatform
//
//  Created by fk on 2018/8/21.
//  Copyright © 2018年 wzsd. All rights reserved.
//

#import "BaseTableViewController.h"

@interface TQTestSubVC : BaseTableViewController

@property (nonatomic,assign) BOOL isAnswers;


@property (nonatomic,assign) NSInteger totalCount;
@property (nonatomic,assign) NSInteger curNum;

@property (nonatomic,assign) NSInteger type;
@property (nonatomic,strong) NSDictionary *question;

@property (nonatomic,strong) NSMutableArray *selIndexPaths;
@end
