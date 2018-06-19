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
#import "MJRefresh.h"
#import "MyWebViewController.h"

@interface PreparationInformationViewController ()<UITableViewDelegate,UITableViewDataSource>
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

@implementation PreparationInformationViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    [self createBackBtn];
    [self setTitleView:@"备考资料"];

    self.pageNo = 0;
    self.pageSize = 6;

    myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, MainScreenWidth, MainScreenheight - 44 - kStatusBarHeight ) style:UITableViewStylePlain];
    myTableView.delegate = self;
    myTableView.dataSource = self;
    [self.view addSubview:myTableView];
    myTableView.tableFooterView = [[UIView alloc] init];
    self.titleType = @"preparation_information";
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
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
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
    return 88;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 45;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return headerView;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    PreparationInformationTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PreparationInformationTableViewCell"];
    if (cell == nil) {
        [tableView registerNib:[UINib nibWithNibName:@"PreparationInformationTableViewCell" bundle:nil] forCellReuseIdentifier:@"PreparationInformationTableViewCell"];
        cell = [tableView dequeueReusableCellWithIdentifier:@"PreparationInformationTableViewCell"];
    }
    [cell loadInfo:[self.resultArray objectAtIndex:indexPath.row]];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
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
