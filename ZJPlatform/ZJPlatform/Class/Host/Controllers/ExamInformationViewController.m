//
//  ExamInformationViewController.m
//  ZJPlatform
//
//  Created by sostag on 2018/3/28.
//  Copyright © 2018年 wzsd. All rights reserved.
//

#import "ExamInformationViewController.h"
#import "HostInformationView.h"
#import "ExamInformationTableViewCell.h"

@interface ExamInformationViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *myTableView;
}

@end

@implementation ExamInformationViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    [self createBackBtn];
    [self setTitleView:@"考试资讯"];
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
//    HostInformationView *view = [[HostInformationView alloc] initWithFrame:CGRectMake(0, 0, MainScreenWidth, 45) WithTitle:@[@"工程经济",@"项目管理",@"工程法规",@"建筑实务",@"建筑实务"]];
    return nil;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    ExamInformationTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ExamInformationTableViewCell"];
    if (cell == nil) {
        [tableView registerNib:[UINib nibWithNibName:@"ExamInformationTableViewCell" bundle:nil] forCellReuseIdentifier:@"ExamInformationTableViewCell"];
        cell = [tableView dequeueReusableCellWithIdentifier:@"ExamInformationTableViewCell"];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;

}



@end
