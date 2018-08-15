//
//  MyOrderSubVC.m
//  ZJPlatform
//
//  Created by fk on 2018/8/15.
//  Copyright © 2018年 wzsd. All rights reserved.
//

#import "MyOrderSubVC.h"
#import "MJRefresh.h"
#import "OrderTableViewCell.h"


@interface MyOrderSubVC ()

@property (nonatomic,assign) NSInteger page;
@property (nonatomic,assign) NSInteger pageSize;

@end

@implementation MyOrderSubVC

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
    
    NSString *url = [NSString stringWithFormat:@"%@%@",ProxyUrl,kRequest_orders_list];
    NSDictionary *dict =  @{@"orderType":@"2",@"pageNo":[NSString stringWithFormat:@"%zi",self.page],@"pageSize":[NSString stringWithFormat:@"%zi",self.pageSize],@"status":[NSString stringWithFormat:@"%zi",self.type]};
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
    NSLog(@"---%@",dict);
    if ([[dict objectForKey:@"lastPage"] integerValue] == self.page+1) {
        self.tableView.footer.hidden = YES;
    }else{
        self.tableView.footer.hidden = NO;
    }
    [self.dataSource addObjectsFromArray:[dict objectForKey:@"list"]];
    [self.tableView reloadData];
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 1) {
        NSString *cellId = @"cell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellId];
        
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame = CGRectMake(MainScreenWidth - 15 - 70, 7, 70, 30);
            [btn setBackgroundColor:MainBlueColor];
            btn.titleLabel.font = Font_13;
            [btn setTitle:@"开始学习" forState:UIControlStateNormal];
            [cell.contentView addSubview:btn];
       
            cell.textLabel.font = Font_13;
            cell.textLabel.textColor = [UIColor lightGrayColor];
        }
        
        cell.textLabel.text = [NSString stringWithFormat:@"有效期至：%@",[[[[self.dataSource objectAtIndex:indexPath.section] objectForKey:@"orderDetailList"] firstObject] objectForKey:@"validityDate"]];
        return cell;
        
    }
    OrderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"OrderTableViewCell"];
    if (cell == nil) {
        [tableView registerNib:[UINib nibWithNibName:@"OrderTableViewCell" bundle:nil] forCellReuseIdentifier:@"OrderTableViewCell"];
        cell = [tableView dequeueReusableCellWithIdentifier:@"OrderTableViewCell"];
    }
    [cell loadInfo:[self.dataSource objectAtIndex:indexPath.section]];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
    
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return nil;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.type == 3) {
        if (indexPath.row == 1) {
            return 44;
        }
    }
    return 120;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (self.type == 3) {
        return 2;
    }
    return 1;
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return [self.dataSource count];
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
