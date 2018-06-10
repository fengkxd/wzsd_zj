//
//  ExamGuideViewController.m
//  ZJPlatform
//
//  Created by sostag on 2018/3/29.
//  Copyright © 2018年 wzsd. All rights reserved.
//

#import "ExamGuideViewController.h"
#import "HostInformationView.h"

@interface ExamGuideViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *myTableView;
}
@end

@implementation ExamGuideViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createBackBtn];
    [self setTitleView:@"考试指南"];
    myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, MainScreenWidth, MainScreenheight - 64 ) style:UITableViewStylePlain];
    myTableView.delegate = self;
    myTableView.dataSource = self;
    [self.view addSubview:myTableView];
    
    [self requestTesttitle];
}

-(void)requestTesttitle{
    NSString *url = [NSString stringWithFormat:@"%@%@",ProxyUrl,kRequest_testtitle_findGet];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[NetworkManager shareNetworkingManager] requestWithMethod:@"GET" headParameter:nil bodyParameter:Subject_Dict relativePath:url
                                                       success:^(id responseObject) {
                                                           NSLog(@"%@",responseObject);
                                                           
                                                           
                                                       } failure:^(NSString *errorMsg) {
                                                           [MBProgressHUD hideHUDForView:self.view animated:YES];
                                                           [Toast showWithText:@"网络错误"];

                                                       }];
    
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 75;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 45;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    HostInformationView *view = [[HostInformationView alloc] initWithFrame:CGRectMake(0, 0, MainScreenWidth, 45) WithTitle:@[@"工程经济",@"项目管理",@"工程法规",@"建筑实务",@"建筑实务"]];
    return view;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellId = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellId];
        
        UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, MainScreenWidth - 20, 28)];
        label1.textColor = [UIColor colorWithHexString:@"444444"];
        label1.font = Font_14;
        label1.tag = 11;
        [cell.contentView addSubview:label1];
        
        UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(10, 40, MainScreenWidth - 20, 28)];
        label2.textColor = [UIColor colorWithHexString:@"9a9a9a"];
        label2.font = Font_12;
        label2.tag = 22;
        [cell.contentView addSubview:label2];
        
        
    }
    
    UILabel *label1 = (UILabel *)[cell.contentView viewWithTag:11];
    UILabel *label2 = (UILabel *)[cell.contentView viewWithTag:22];

    label1.text = @"违法记录看为了减肥危机份文件发了就完了额克己复礼我看见俄方垃圾";
    label2.text = @"一级建造师   2345   阅读";
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}



@end
