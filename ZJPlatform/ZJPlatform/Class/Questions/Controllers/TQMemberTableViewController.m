//
//  TQMemberTableViewController.m
//  ZJPlatform
//
//  Created by fengke on 2018/8/19.
//  Copyright © 2018年 wzsd. All rights reserved.
//

#import "TQMemberTableViewController.h"
#import "MJRefresh.h"
#import "TQHistoryCell.h"
#import "TQTestInfoViewController.h"
#import "TQTestViewController.h"

@interface TQMemberTableViewController ()
@property (nonatomic,strong) NSMutableArray *dataArray;

@property (nonatomic,assign) NSInteger page;
@property (nonatomic,assign) NSInteger pageSize;

@end

@implementation TQMemberTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataArray = [NSMutableArray array];
    self.page = 0;
    self.pageSize = 10;


    [self requestDataSource];
    [self createBackBtn];
    [self setTitleView:@"做题记录"];

}



-(void)requestDataSource{
    NSString *url = [NSString stringWithFormat:@"%@%@",ProxyUrl,kRequest_testPaper_queryMemberTest];
    WS(weakSelf);
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[NetworkManager shareNetworkingManager] requestWithMethod:@"GET" headParameter:nil bodyParameter:nil relativePath:url
                                                       success:^(id responseObject) {
                                                           [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
                                                           [weakSelf loadDataSource:responseObject];
                                                       } failure:^(NSString *errorMsg) {
                                                           [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
                                                           [Toast showWithText:errorMsg];
                                                           
                                                       }];
    
}


-(void)loadDataSource:(NSDictionary *)dict{
    NSLog(@"%@",dict);
    if ([[dict objectForKey:@"lastPage"] integerValue] == self.page+1) {
        self.tableView.footer.hidden = YES;
    }else{
        self.tableView.footer.hidden = NO;
    }
    [self.dataArray addObjectsFromArray:[dict objectForKey:@"list"]];
    [self.tableView reloadData];
}




#pragma mark - UITableViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    TQTestViewController *vc = [[TQTestViewController alloc] init];
    vc.testId = [self.dataArray[indexPath.row] objectForKey:@"id"];
    [vc setTitleView:[self.dataArray[indexPath.row] objectForKey:@"title"]];
    [self.navigationController pushViewController:vc animated:YES];
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 65.0f;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 10;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 0.1;
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [[self dataArray] count];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellid = @"TQHistoryCell";
    TQHistoryCell *cell = (TQHistoryCell *)[tableView dequeueReusableCellWithIdentifier:cellid];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"TQHistoryCell" owner:self options:nil] lastObject];
    }
    [cell loadinfo:[self.dataArray objectAtIndex:indexPath.row]];
    return cell;
}

@end
