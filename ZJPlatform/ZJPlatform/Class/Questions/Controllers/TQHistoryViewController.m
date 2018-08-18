//
//  TQHistoryViewController.m
//  ZJPlatform
//
//  Created by Rongbo Li on 2018/4/1.
//  Copyright © 2018年 wzsd. All rights reserved.
//

#import "TQHistoryViewController.h"
#import "TQTestInfoViewController.h"
#import "MJRefresh.h"
#import "TQHistoryCell.h"
#import "TQTestViewController.h"


@interface TQHistoryViewController () <UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) NSMutableArray *dataArray;

@property (nonatomic,assign) NSInteger page;
@property (nonatomic,assign) NSInteger pageSize;
@end

@implementation TQHistoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitleView:@"历年真题"];
    [self createBackBtn];
    self.dataArray = [NSMutableArray array];
    self.page = 0;
    self.pageSize = 10;

    [self requestDataSource];
}

-(void)requestDataSource{
    NSString *url = [NSString stringWithFormat:@"%@%@",ProxyUrl,kRequest_testPaper_list];
    WS(weakSelf);
    NSDictionary *dict =  @{@"courseClassify.id":self.courseClassifyId,@"pageNo":[NSString stringWithFormat:@"%zi",self.page],@"pageSize":[NSString stringWithFormat:@"%zi",self.pageSize],@"type":[NSString stringWithFormat:@"%zi",self.type]};
    
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[NetworkManager shareNetworkingManager] requestWithMethod:@"GET" headParameter:nil bodyParameter:dict relativePath:url
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
        _myTable.footer.hidden = YES;
    }else{
        _myTable.footer.hidden = NO;
    }
    [self.dataArray addObjectsFromArray:[dict objectForKey:@"list"]];
    [_myTable reloadData];
}


#pragma mark - UITableViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    TQTestViewController *vc = [[TQTestViewController alloc] init];
    vc.testId = [self.dataArray[indexPath.row] objectForKey:@"id"];
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
    
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return [[self dataArray] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellid = @"cell";
    
    TQHistoryCell *cell = (TQHistoryCell *)[tableView dequeueReusableCellWithIdentifier:cellid];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"TQHistoryCell" owner:self options:nil] lastObject];
    }
    
    [cell loadinfo:[self.dataArray objectAtIndex:indexPath.row]];
    
    return cell;
}

@end
