//
//  ExamGuideViewController.m
//  ZJPlatform
//
//  Created by sostag on 2018/3/29.
//  Copyright © 2018年 wzsd. All rights reserved.
//

#import "ExamGuideViewController.h"
#import "HostInformationView.h"
#import "MJRefresh.h"

#import "MyWebViewController.h"


@interface ExamGuideViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *myTableView;
    
    HostInformationView *headerView;
}

@property (nonatomic,assign) NSInteger pageNo;
@property (nonatomic,assign) NSInteger pageSize;
@property (nonatomic,strong) NSDictionary *selectDict;
@property (nonatomic,strong) NSArray *titles;
@property (nonatomic,strong) NSMutableArray *resultArray;
@property (nonatomic,strong) NSString *titleType;
@end

@implementation ExamGuideViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.pageNo = 0;
    self.pageSize = 6;
    [self createBackBtn];
    [self setTitleView:@"考试指南"];
    myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, MainScreenWidth, MainScreenheight - 44 - kStatusBarHeight ) style:UITableViewStylePlain];
    myTableView.delegate = self;
    myTableView.dataSource = self;
    [self.view addSubview:myTableView];
    myTableView.tableFooterView = [[UIView alloc] init];
    self.titleType = @"test_guide";
    [self requestTesttitle];
    WS(weakSelf);
    [myTableView addLegendFooterWithRefreshingBlock:^{
        weakSelf.pageNo++;
        [weakSelf loadnewsInformationList];
    }];

}

-(void)requestTesttitle{
    NSString *url = [NSString stringWithFormat:@"%@%@",ProxyUrl,kRequest_sysDict_list];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[NetworkManager shareNetworkingManager] requestWithMethod:@"GET" headParameter:nil bodyParameter:@{@"type":self.titleType} relativePath:url
                                                       success:^(id responseObject) {
                                                           NSLog(@"%@",responseObject);
                                                           [self loadGuideTitle:responseObject];
                                                           
                                                       } failure:^(NSString *errorMsg) {
                                                           [MBProgressHUD hideHUDForView:self.view animated:YES];
                                                           if (errorMsg == nil) {
                                                               [Toast showWithText:@"网络错误"];
                                                           }
                                                       }];
}

-(void)loadGuideTitle:(NSDictionary *)dict{
    self.titles = [dict objectForKey:@"list"];
    headerView = [[HostInformationView alloc] initWithFrame:CGRectMake(0, 0, MainScreenWidth, 45) WithArray:self.titles];
    WS(weakSelf);
    self.selectDict = [self.titles objectAtIndex:0];
    [self loadnewsInformationList];
    headerView.selectedBlock = ^(NSDictionary *dict) {
        weakSelf.selectDict = dict;
        [weakSelf loadnewsInformationList];
    };
    [myTableView reloadData];
}

-(void)loadnewsInformationList{
    
    NSDictionary *dict =  @{@"pageNo":[NSNumber numberWithInteger:self.pageNo],@"pageSize":PageSize,@"titleType":self.titleType,@"subjects.id":Subject_Id,@"type":[self.selectDict objectForKey:@"value"]};

    NSString *url = [NSString stringWithFormat:@"%@%@",ProxyUrl,kRequest_newsInformation_list];
    [[NetworkManager shareNetworkingManager] requestWithMethod:@"GET" headParameter:nil bodyParameter:dict relativePath:url
                                                       success:^(id responseObject) {
                                                           NSLog(@"%@",responseObject);
                                                           [self loadResult:responseObject];
                                                       } failure:^(NSString *errorMsg) {
                                                           [self->myTableView.footer endRefreshing];
                                                           [MBProgressHUD hideHUDForView:self.view animated:YES];
                                                           if (errorMsg == nil) {
                                                               [Toast showWithText:@"网络错误"];
                                                           }
                                                           
                                                       }];
}

-(void)loadResult:(NSDictionary *)dict{
    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    [myTableView.footer endRefreshing];
    if ([[dict objectForKey:@"lastPage"] integerValue] < [PageSize integerValue]) {
        myTableView.footer.hidden = YES;
    }else{
        myTableView.footer.hidden = NO;
    }
    if (self.pageNo == 0) {
        self.resultArray = [NSMutableArray arrayWithArray:[dict objectForKey:@"list"]];
    }else{
        [self.resultArray addObjectsFromArray:[dict objectForKey:@"list"]];
        
    }
    [myTableView reloadData];
    
    
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.resultArray count];
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 75;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 45;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return headerView;
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
    NSDictionary *dict = [self.resultArray objectAtIndex:indexPath.row];
    
    label1.text = [dict objectForKey:@"title"];
    label2.text = [dict objectForKey:@"addTime"];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSDictionary *dict = [self.resultArray objectAtIndex:indexPath.row];
    NSString *url =[NSString stringWithFormat:@"%@%@",ProxyUrl,kRequest_newsInformation_get];
    
    WS(weakSelf);
    [[NetworkManager shareNetworkingManager] requestWithMethod:@"GET" headParameter:nil bodyParameter:@{@"id":[dict objectForKey:@"id"]} relativePath:url success:^(id responseObject) {
        NSLog(@"资讯详情：%@",responseObject);
        MyWebViewController *vc = [[MyWebViewController alloc] init];
        [vc loadHtmlStr:[responseObject objectForKey:@"values"]];
        [vc setTitleView:[responseObject objectForKey:@"title"]];
        [weakSelf.navigationController pushViewController:vc animated:YES];

    } failure:^(NSString *errorMsg) {
        if (errorMsg == nil) {
            [Toast showWithText:@"网络错误"];
        }
    }];

}



@end
