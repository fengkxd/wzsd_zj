//
//  MyOrderSubVC.h
//  ZJPlatform
//
//  Created by fk on 2018/8/15.
//  Copyright © 2018年 wzsd. All rights reserved.
//

#import "BaseTableViewController.h"

typedef void (^notiBlock)(void);//通知主控制器页面可以滑动了


@interface MyOrderSubVC : BaseTableViewController
{
    UITableView *tableView;
}



@property (nonatomic,assign) NSInteger type;


@property (nonatomic, assign) BOOL canScroll;
@property (nonatomic, copy) notiBlock block;

@property (nonatomic,strong) NSMutableArray *dataSource;

@property (copy) void (^didSelectedCourse)(NSDictionary *dict);

-(void)requestDataSource;

- (void)handlerBlock:(notiBlock)block;


@end
