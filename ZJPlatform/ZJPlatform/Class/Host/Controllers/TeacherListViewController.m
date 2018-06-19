//
//  TeacherListViewController.m
//  ZJPlatform
//
//  Created by sostag on 2018/3/30.
//  Copyright © 2018年 wzsd. All rights reserved.
//

#import "TeacherListViewController.h"
#import "TeacherListTableViewCell.h"
#import "TeacherDetailViewController.h"

#import "MJRefresh.h"


@interface TeacherListViewController ()
{
    
    
}

@property (nonatomic,strong) NSMutableArray *teachList;
@property (nonatomic,assign) NSInteger pageNo;
@end

@implementation TeacherListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitleView:@"中教名师"];
    [self createBackBtn];
    self.pageNo = 0;
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [self queryList];

    WS(weakSelf);
    [self.tableView addLegendFooterWithRefreshingBlock:^{
        weakSelf.pageNo++;
        [weakSelf queryList];
    }];
    [self.tableView addLegendHeaderWithRefreshingBlock:^{
        weakSelf.pageNo = 0;
        [weakSelf queryList];
    }];

    
}

-(void)queryList{
    NSString *url = [NSString stringWithFormat:@"%@%@",ProxyUrl,kRequest_famousTeacher_queryList];
    
    NSDictionary *dict =  @{@"pageNo":[NSNumber numberWithInteger:self.pageNo],@"pageSize":PageSize,@"subjects.id":Subject_Id,@"isRecommend":@"0"};
    WS(weakSelf);
    [[NetworkManager shareNetworkingManager] requestWithMethod:@"GET" headParameter:nil bodyParameter:dict relativePath:url success:^(id responseObject) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [weakSelf loadTeachResult:responseObject];
    } failure:^(NSString *errorMsg) {
        [weakSelf.tableView.footer endRefreshing];
        [weakSelf.tableView.header endRefreshing];
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        if (errorMsg == nil) {
            [Toast showWithText:@"网络错误"];

        }
    }];
}

-(void)loadTeachResult:(NSDictionary *)dict{
    [self.tableView.footer endRefreshing];
    [self.tableView.header endRefreshing];
    if ([[dict objectForKey:@"lastPage"] integerValue] < [PageSize integerValue]) {
        self.tableView.footer.hidden = YES;
    }else{
        self.tableView.footer.hidden = NO;
    }
    
    if (self.pageNo == 0) {
        self.teachList = [NSMutableArray arrayWithArray:[dict objectForKey:@"list"]];
    }else{
        [self.teachList addObjectsFromArray:[dict objectForKey:@"list"]];

    }
    
    [self.tableView reloadData];
}



-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    TeacherDetailViewController *vc = [[TeacherDetailViewController alloc] init];
    vc.teachDict = [self.teachList objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:vc animated:YES];
}




-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.teachList count];
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 121;
}




-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TeacherListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TeacherListTableViewCell"];
    if (cell == nil) {
        [tableView registerNib:[UINib nibWithNibName:@"TeacherListTableViewCell" bundle:nil] forCellReuseIdentifier:@"TeacherListTableViewCell"];
        cell = [tableView dequeueReusableCellWithIdentifier:@"TeacherListTableViewCell"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    NSInteger row = indexPath.row;
    [cell loadDict:[self.teachList objectAtIndex:row]];
    return cell;
}










@end
