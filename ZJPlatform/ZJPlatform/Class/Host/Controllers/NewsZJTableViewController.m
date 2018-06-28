//
//  NewsZJTableViewController.m
//  ZJPlatform
//
//  Created by fk on 2018/6/19.
//  Copyright © 2018年 wzsd. All rights reserved.
//

#import "NewsZJTableViewController.h"
#import "MJRefresh.h"
#import "ExamInformationTableViewCell.h"
#import "MyWebViewController.h"

@interface NewsZJTableViewController ()



@property (nonatomic,assign) NSInteger pageNo;
@property (nonatomic,assign) NSInteger pageSize;
@property (nonatomic,strong) NSMutableArray *resultArray;

@end

@implementation NewsZJTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createBackBtn];
    [self setTitleView:@"中教新闻"];
    [self requestNews];

    self.pageNo = 0;
    self.pageSize = 6;
    WS(weakSelf);
    [self.tableView addLegendFooterWithRefreshingBlock:^{
        weakSelf.pageNo++;
        [weakSelf requestNews];
    }];
    
}


-(void)requestNews{
    
    NSString *url = [NSString stringWithFormat:@"%@%@",ProxyUrl,kRequest_newsbulletin_findList];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    NSDictionary *dict = @{@"sysType":@"news_zjNews",@"pageNo":[NSNumber numberWithInteger:self.pageNo],@"pageSize":[NSNumber numberWithInteger:self.pageSize]};
    WS(weakSelf);
    [[NetworkManager shareNetworkingManager] requestWithMethod:@"GET" headParameter:nil bodyParameter:dict relativePath:url
                                                       success:^(id responseObject) {
                                                           NSLog(@"%@",responseObject);
                                                           [MBProgressHUD hideHUDForView:self.view animated:YES];
                                                           [weakSelf loadResult:responseObject];
                                                           
                                                       } failure:^(NSString *errorMsg) {
                                                           [MBProgressHUD hideHUDForView:self.view animated:YES];
                                                           [Toast showWithText:errorMsg];

                                                           [weakSelf.tableView.footer endRefreshing];

                                                       }];
    
    
}

-(void)loadResult:(NSDictionary *)dict{
    
    [self.tableView.footer endRefreshing];
    if ([[dict objectForKey:@"lastPage"] integerValue] < [PageSize integerValue]) {
        self.tableView.footer.hidden = YES;
    }else{
        self.tableView.footer.hidden = NO;
    }
    
    if (self.pageNo == 0) {
        self.resultArray = [NSMutableArray arrayWithArray:[dict objectForKey:@"list"]];
    }else{
        [self.resultArray addObjectsFromArray:[dict objectForKey:@"list"]];
        
    }
    [self.tableView reloadData];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ExamInformationTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ExamInformationTableViewCell"];
    if (cell == nil) {
        [tableView registerNib:[UINib nibWithNibName:@"ExamInformationTableViewCell" bundle:nil] forCellReuseIdentifier:@"ExamInformationTableViewCell"];
        cell = [tableView dequeueReusableCellWithIdentifier:@"ExamInformationTableViewCell"];
    }
    [cell loadInfo:[self.resultArray objectAtIndex:indexPath.row]];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
    
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

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *dict = [self.resultArray objectAtIndex:indexPath.row];
    MyWebViewController *vc = [[MyWebViewController alloc] init];
    [vc loadHtmlStr:[dict objectForKey:@"intro"]];
    [self.navigationController pushViewController:vc animated:YES];
    
    
}



@end
