//
//  TQProjectTableViewController.m
//  ZJPlatform
//
//  Created by fk on 2018/8/17.
//  Copyright © 2018年 wzsd. All rights reserved.
//

#import "TQProjectTableViewController.h"
#import "TQHistoryViewController.h"

@interface TQProjectTableViewController ()
@property (nonatomic,strong) NSMutableArray *dataSource;
@end

@implementation TQProjectTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataSource = [NSMutableArray array];
    [self requestDataSource];
    [self setTitleView:@"选择考试项目"];
    [self createBackBtn];
    
}


-(void)requestDataSource{
    NSString *url = [NSString stringWithFormat:@"%@%@",ProxyUrl,kRequest_subjects_eProject];
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

-(void)loadDataSource:(NSArray *)array{
    NSLog(@"考试的项目：%@",array);

    for (NSDictionary *dict in array) {
        if ([[dict objectForKey:@"courseClassifyList"] count] != 0 && [dict objectForKey:@"name"]) {
            [self.dataSource addObject:dict];
        }
    }

    [self.tableView reloadData];
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger section = indexPath.section;
    NSInteger row = indexPath.row;
    TQHistoryViewController *vc = [[TQHistoryViewController alloc] init];
    vc.courseClassifyId = [[[self.dataSource[section] objectForKey:@"courseClassifyList"] objectAtIndex:row] objectForKey:@"id"];
    vc.type = self.type;
    [self.navigationController pushViewController:vc animated:YES];
}



-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return nil;
}


#pragma mark - Table view data source


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger section = indexPath.section;
    NSInteger row = indexPath.row;
    
    NSString *cellId = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellId];
        cell.textLabel.font = Font(15);
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    NSArray *array = [self.dataSource[section] objectForKey:@"courseClassifyList"];
    NSDictionary *dict = array[row];
    cell.textLabel.text = [dict objectForKey:@"name"];
    return cell;
}



-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, MainScreenWidth, 40)];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, 200, 40)];
    label.textColor = MainBlueColor;
    label.font = Font(13);
    label.text = [self.dataSource[section] objectForKey:@"name"];
    [view addSubview:label];
    return view;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [self.dataSource count];
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[self.dataSource[section] objectForKey:@"courseClassifyList"] count];
}



@end
