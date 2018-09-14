//
//  HomeSearchViewController.m
//  ZJPlatform
//
//  Created by fk on 2018/8/29.
//  Copyright © 2018年 wzsd. All rights reserved.
//

#import "HomeSearchViewController.h"
#import "SelCourseTableViewCell.h"
#import "SelCourseDetailViewController.h"

@interface HomeSearchViewController ()<UITextFieldDelegate>
{
    UITextField *textField;
}

@property (nonatomic,strong) NSString *searchStr;
@property (nonatomic,strong) NSMutableArray *dataSource;

@property (nonatomic,assign) NSInteger pageNo;
@property (nonatomic,assign) NSInteger pageSize;

@end

@implementation HomeSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initTitleView];
}



-(void)initTitleView{
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 5, MainScreenWidth - 40 - 40, 32)];
    titleView.backgroundColor = [UIColor whiteColor];
    titleView.layer.masksToBounds = YES;
    titleView.layer.cornerRadius = 4;
    
    textField = [[UITextField alloc] initWithFrame:CGRectMake(15, 0, MainScreenWidth - 40 - 40 - 30, 32)];
    textField.delegate = self;
    textField.placeholder = @"请输入关键字";
    textField.font = Font(14);
    [textField becomeFirstResponder];
    [titleView addSubview:textField];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 40, 40);
    btn.titleLabel.font = Font(14);
    [btn setTitle:@"取消" forState:UIControlStateNormal];
    
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(goBack:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    self.navigationItem.titleView = titleView;
    

    self.pageNo = 0;
    self.pageSize = 10;
    
    textField.returnKeyType = UIReturnKeySearch;
    
    WS(weakSelf);
    [self.tableView addLegendFooterWithRefreshingBlock:^{
        weakSelf.pageNo ++;
        [weakSelf requestCourseList];

    }];
    self.tableView.footer.hidden = YES;
}



-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    self.searchStr = textField.text;
    [self requestCourseList];
    return YES;
}

-(void)requestCourseList{
    if ([Utility isBlank:self.searchStr]) {
        return;
    }
    
    
    NSString *url = [NSString stringWithFormat:@"%@%@",ProxyUrl,kRequest_video_list];
    NSDictionary *dict =  @{@"name":self.searchStr,@"pageNo":@(self.pageNo),@"pageSize":@(self.pageSize),@"subjects.id":Subject_Id};
    WS(weakSelf);
    [[NetworkManager shareNetworkingManager] requestWithMethod:@"GET" headParameter:nil bodyParameter:dict relativePath:url success:^(id responseObject) {
        NSLog(@"搜索：%@",responseObject);
        [weakSelf loadCourseList:responseObject];
    } failure:^(NSString *errorMsg) {
        [Toast showWithText:errorMsg];
    }];
}

-(void)loadCourseList:(NSDictionary *)dict{
    [self.tableView.footer endRefreshing];
 
    if ([[dict objectForKey:@"lastPage"] integerValue] < [PageSize integerValue]) {
        self.tableView.footer.hidden = YES;
    }else{
        self.tableView.footer.hidden = NO;
    }
    
    if (self.pageNo == 0) {
        self.dataSource = [NSMutableArray arrayWithArray:[dict objectForKey:@"list"]];
    }else{
        [self.dataSource addObjectsFromArray:[dict objectForKey:@"list"]];
        
    }
    [self.tableView reloadData];
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    SelCourseDetailViewController *vc = [[SelCourseDetailViewController alloc] initWithNibName:@"SelCourseDetailViewController" bundle:nil];
    vc.videoId = [[self.dataSource objectAtIndex:indexPath.row] objectForKey:@"id"];
    [self.navigationController presentViewController:vc animated:YES completion:nil];
    
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, MainScreenWidth, 100)];
    view.backgroundColor = self.view.backgroundColor;
    return view;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.5;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 88;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.dataSource count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SelCourseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SelCourseTableViewCell"];
    if (cell == nil) {
        [tableView registerNib:[UINib nibWithNibName:@"SelCourseTableViewCell" bundle:nil] forCellReuseIdentifier:@"SelCourseTableViewCell"];
        cell = [tableView dequeueReusableCellWithIdentifier:@"SelCourseTableViewCell"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell loadCourseInfo:[self.dataSource objectAtIndex:indexPath.row]];
    return cell;
    
    
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

@end
