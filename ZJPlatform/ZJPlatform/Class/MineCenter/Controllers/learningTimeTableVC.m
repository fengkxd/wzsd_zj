//
//  learningTimeTableVC.m
//  ZJPlatform
//
//  Created by fengke on 2018/8/14.
//  Copyright © 2018年 wzsd. All rights reserved.
//

#import "learningTimeTableVC.h"
#import "MJRefresh.h"
#import "learningTimeTableViewCell.h"

@interface learningTimeTableVC ()
{
    
}
@property (nonatomic,assign) NSInteger page;
@property (nonatomic,assign) NSInteger pageSize;


@end

@implementation learningTimeTableVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.canScroll = NO;
    self.pageSize = 10;
    self.page = 0;
    self.dataSource = [NSMutableArray array];
    [self requestDataSource];
    WS(weakSelf);
    [self.tableView addLegendFooterWithRefreshingBlock:^{
        weakSelf.page ++;
        [weakSelf requestDataSource];
    }];
}

-(void)requestDataSource{
    
    NSString *url = [NSString stringWithFormat:@"%@%@",ProxyUrl,kRequest_studyduration_list];
    NSDictionary *dict =  @{@"pageNo":[NSString stringWithFormat:@"%zi",self.page],@"pageSize":[NSString stringWithFormat:@"%zi",self.pageSize],@"type":[NSString stringWithFormat:@"%zi",self.type]};
    WS(weakSelf);
    [[NetworkManager shareNetworkingManager] requestWithMethod:@"GET" headParameter:nil bodyParameter:dict relativePath:url success:^(id responseObject) {
        [weakSelf loadDict:responseObject];
        [weakSelf endRefreshing];
    } failure:^(NSString *errorMsg) {
        [weakSelf endRefreshing];
        [Toast showWithText:errorMsg];
    }];

}

-(void)loadDict:(NSDictionary *)dict{
    if ([[dict objectForKey:@"lastPage"] integerValue] == self.page+1) {
        self.tableView.footer.hidden = YES;
    }else{
        self.tableView.footer.hidden = NO;
    }
    [self.dataSource addObjectsFromArray:[dict objectForKey:@"list"]];
    [self.tableView reloadData];
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    learningTimeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"learningTimeTableViewCell"];
    if (cell == nil) {
        [tableView registerNib:[UINib nibWithNibName:@"learningTimeTableViewCell" bundle:nil] forCellReuseIdentifier:@"learningTimeTableViewCell"];
        cell = [tableView dequeueReusableCellWithIdentifier:@"learningTimeTableViewCell"];
    }
    [cell loadInfo:[self.dataSource objectAtIndex:indexPath.row]];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.dataSource count];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    if (self.canScroll == NO) {
        scrollView.contentOffset = CGPointZero;
    }
    
    if (scrollView.contentOffset.y < 0 ) {
        self.canScroll = NO;
        scrollView.contentOffset = CGPointZero;
        self.block();
    }
}

- (void)handlerBlock:(notiBlock)block {
    self.block = block;
}

@end
