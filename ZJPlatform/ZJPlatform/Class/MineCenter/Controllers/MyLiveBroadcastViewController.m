//
//  MyLiveBroadcastViewController.m
//  ZJPlatform
//
//  Created by fengke on 2018/4/6.
//  Copyright © 2018年 wzsd. All rights reserved.
//

#import "MyLiveBroadcastViewController.h"
#import "MyLiveBroadcastTableViewCell.h"

@interface MyLiveBroadcastViewController ()

@end

@implementation MyLiveBroadcastViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createBackBtn];
    [self setTitleView:@"我的直播课"];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return nil;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
 
    MyLiveBroadcastTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyLiveBroadcastTableViewCell"];
    if (cell == nil) {
        [tableView registerNib:[UINib nibWithNibName:@"MyLiveBroadcastTableViewCell" bundle:nil] forCellReuseIdentifier:@"MyLiveBroadcastTableViewCell"];
        cell = [tableView dequeueReusableCellWithIdentifier:@"MyLiveBroadcastTableViewCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.line.frame = CGRectMake(10, 105, MainScreenWidth - 20, 0.5);
    }
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 160;
}




@end
