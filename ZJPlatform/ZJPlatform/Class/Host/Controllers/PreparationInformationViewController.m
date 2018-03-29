//
//  PreparationInformationViewController.m
//  ZJPlatform
//
//  Created by sostag on 2018/3/29.
//  Copyright © 2018年 wzsd. All rights reserved.
//

#import "PreparationInformationViewController.h"
#import "PreparationInformationTableViewCell.h"
#import "HostInformationView.h"

@interface PreparationInformationViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *myTableView;
}

@end

@implementation PreparationInformationViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    [self createBackBtn];
    [self setTitleView:@"备考资料"];
    myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, MainScreenWidth, MainScreenheight - 64 ) style:UITableViewStylePlain];
    myTableView.delegate = self;
    myTableView.dataSource = self;
    [self.view addSubview:myTableView];
    
    
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 88;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 45;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    HostInformationView *view = [[HostInformationView alloc] initWithFrame:CGRectMake(0, 0, MainScreenWidth, 45) WithTitle:@[@"工程经济",@"项目管理",@"工程法规",@"建筑实务",@"建筑实务"]];
    return view;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    PreparationInformationTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PreparationInformationTableViewCell"];
    if (cell == nil) {
        [tableView registerNib:[UINib nibWithNibName:@"PreparationInformationTableViewCell" bundle:nil] forCellReuseIdentifier:@"PreparationInformationTableViewCell"];
        cell = [tableView dequeueReusableCellWithIdentifier:@"PreparationInformationTableViewCell"];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
    
}



@end
