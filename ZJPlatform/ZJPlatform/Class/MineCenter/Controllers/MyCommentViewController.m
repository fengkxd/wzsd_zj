//
//  MyCommentViewController.m
//  ZJPlatform
//
//  Created by fk on 2018/8/15.
//  Copyright © 2018年 wzsd. All rights reserved.
//

#import "MyCommentViewController.h"
#import "MyCommentCell.h"

@interface MyCommentViewController ()
@property (nonatomic,assign) NSInteger page;
@property (nonatomic,assign) NSInteger pageSize;

@end

@implementation MyCommentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createBackBtn];
    [self setTitleView:@"我的评价"];
    self.dataSource = [NSMutableArray array];
    self.page = 0;
    self.pageSize = 10;
    SHOW_HUD;

    [self requestDataSource];
    WS(weakSelf);
    [self.tableView addLegendFooterWithRefreshingBlock:^{
        weakSelf.page ++;
        [weakSelf requestDataSource];
    }];
    
}




-(void)requestDataSource{
    
    NSString *url = [NSString stringWithFormat:@"%@%@",ProxyUrl,kRequest_comment_findSelf];
    NSDictionary *dict =  @{@"questionType":@"2",@"pageNo":[NSString stringWithFormat:@"%zi",self.page],@"pageSize":[NSString stringWithFormat:@"%zi",self.pageSize]};
    WS(weakSelf);
    NSLog(@"%@",dict);
    [[NetworkManager shareNetworkingManager] requestWithMethod:@"GET" headParameter:nil bodyParameter:dict relativePath:url success:^(id responseObject) {
        [weakSelf loadDict:responseObject];
        [weakSelf endRefreshing];
        HIDDEN_HUD;
    } failure:^(NSString *errorMsg) {
        [weakSelf endRefreshing];
        HIDDEN_HUD;
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


-(void)deleteComment:(UITableViewCell *)cell{
    NSInteger section = [self.tableView indexPathForCell:cell].section;
    NSDictionary *dict =  @{@"id":[self.dataSource[section] objectForKey:@"id"]};
    NSString *url = [NSString stringWithFormat:@"%@%@",ProxyUrl,kRequest_comment_delete];
    [[NetworkManager shareNetworkingManager] requestWithMethod:@"POST" headParameter:nil bodyParameter:dict relativePath:url success:^(id responseObject) {
    } failure:^(NSString *errorMsg) {
    }];
    [self.dataSource removeObjectAtIndex:section];
    [self.tableView deleteSections:[NSIndexSet indexSetWithIndex:section] withRowAnimation:UITableViewRowAnimationAutomatic];
    
    
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 1) {
        NSString *cellId = @"cell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellId];
            
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(8, 0, MainScreenWidth - 16, 44)];
            label.font = Font_13;
            label.textColor = [UIColor lightGrayColor];
            label.tag = 1;
            [cell.contentView addSubview:label];
        }
        UILabel *label = [cell.contentView viewWithTag:1];
        label.numberOfLines = 0;
        
        NSString *str = [[self.dataSource objectAtIndex:indexPath.section] objectForKey:@"commentValues"];
        CGSize size = CGSizeMake(MainScreenWidth - 16,2000); //设置一个行高上限
        NSDictionary *attribute = @{NSFontAttributeName: Font_13};
        CGFloat height = [str boundingRectWithSize:size options: NSStringDrawingTruncatesLastVisibleLine |NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attribute context:nil].size.height;
      label.text = str;
        label.frame = CGRectMake(8, 0, MainScreenWidth - 16, height + 10);
        
        return cell;
        
    }
    MyCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyCommentCell"];
    if (cell == nil) {
        [tableView registerNib:[UINib nibWithNibName:@"MyCommentCell" bundle:nil] forCellReuseIdentifier:@"MyCommentCell"];
        cell = [tableView dequeueReusableCellWithIdentifier:@"MyCommentCell"];
    }
    cell.delegate = self;
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
    
    if (indexPath.row == 1) {
        NSString *str = [[self.dataSource objectAtIndex:indexPath.section] objectForKey:@"commentValues"];
        CGSize size = CGSizeMake(MainScreenWidth - 16,2000); //设置一个行高上限
        NSDictionary *attribute = @{NSFontAttributeName: Font_13};
        CGFloat height = [str boundingRectWithSize:size options: NSStringDrawingTruncatesLastVisibleLine |NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attribute context:nil].size.height;
        
        return height + 10;
    }
    return 90;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return [self.dataSource count];
}



@end
