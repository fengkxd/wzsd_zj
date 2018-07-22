//
//  LiveBroadcastViewController.m
//  ZJPlatform
//
//  Created by fengke on 2018/3/22.
//  Copyright © 2018年 wzsd. All rights reserved.
//

#import "LiveBroadcastViewController.h"
#import "LiveBroadcastTableViewCell.h"
#import "MJRefresh.h"
#import "SelCourseDetailViewController.h"

@interface LiveBroadcastViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    
    UITableView *myTableView;
}
@property (nonatomic,assign) NSInteger pageNo;
@property (nonatomic,assign) NSInteger pageSize;
@property (nonatomic,strong) NSMutableArray *videoList;


@end


@implementation LiveBroadcastViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitleView:@"直播课程"];
    
    [self initHeaderView];
    
    
    myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 45, MainScreenWidth, MainScreenheight - 44 - kStatusBarHeight - 45 - kTabbarHeight) style:UITableViewStylePlain];
    myTableView.delegate = self;
    myTableView.dataSource = self;
    [self.view addSubview:myTableView];
    myTableView.tableFooterView = [[UIView alloc] init];
    
    self.pageNo = 0;
    self.pageSize = 6;

    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [self requestCourseList];
    
    WS(weakSelf);
    [myTableView addLegendFooterWithRefreshingBlock:^{
        weakSelf.pageNo++;
        [weakSelf requestCourseList];
    }];
    [myTableView addLegendHeaderWithRefreshingBlock:^{
        weakSelf.pageNo = 0;
        [weakSelf requestCourseList];
    }];
    
}



-(void)requestCourseList{
    NSString *url = [NSString stringWithFormat:@"%@%@",ProxyUrl,kRequest_video_list];
    
    NSDictionary *dict =  @{@"pageNo":[NSNumber numberWithInteger:self.pageNo],@"pageSize":PageSize,@"subjects.id":Subject_Id,@"questionType":@"3",@"hotRecommend":@"1"};
    
    WS(weakSelf);
    
    [[NetworkManager shareNetworkingManager] requestWithMethod:@"GET" headParameter:nil bodyParameter:dict relativePath:url success:^(id responseObject) {
        NSLog(@"直播：%@",responseObject);
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        [weakSelf loadCourseList:responseObject];
    } failure:^(NSString *errorMsg) {
        [self->myTableView.footer endRefreshing];
        [self->myTableView.header endRefreshing];
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        [Toast showWithText:errorMsg];
        
    }];
}

-(void)loadCourseList:(NSDictionary *)dict{
    [myTableView.footer endRefreshing];
    [myTableView.header endRefreshing];
    
    if ([[dict objectForKey:@"lastPage"] integerValue] < [PageSize integerValue]) {
        myTableView.footer.hidden = YES;
    }else{
        myTableView.footer.hidden = NO;
    }
    
    if (self.pageNo == 0) {
        self.videoList = [NSMutableArray arrayWithArray:[dict objectForKey:@"list"]];
    }else{
        [self.videoList addObjectsFromArray:[dict objectForKey:@"list"]];
        
    }
    [myTableView reloadData];
    
    
    
}




-(void)initHeaderView{
    CGFloat width = MainScreenWidth / 3.0;
    
    for (NSInteger i = 0; i < 3; i++) {
        UIButton *btn = [UIButton  buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(i * width, 0, width, 45);
        
        btn.titleLabel.font = Font_13;
        [btn setImage:[UIImage imageNamed:@"arrow_up2.png"] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"arrow_up3.png"] forState:UIControlStateSelected];
        [btn setBackgroundColor:[UIColor whiteColor]];
        [btn setTitleColor:[UIColor colorWithHexString:@"444444"] forState:UIControlStateNormal];
        
        if (i == 0) {
            [btn setTitle:@"科目" forState:UIControlStateNormal];
            btn.selected = YES;
        }else if(i == 1){
            [btn setTitle:@"主讲老师" forState:UIControlStateNormal];
        }else {
            [btn setTitle:@"直播时间" forState:UIControlStateNormal];
        }
        [Utility changeImageTitleForBtn:btn];
                
        [self.view addSubview:btn];
        
    }
}




-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    SelCourseDetailViewController *vc = [[SelCourseDetailViewController alloc] initWithNibName:@"SelCourseDetailViewController" bundle:nil];
    vc.videoId = [[self.videoList objectAtIndex:indexPath.row] objectForKey:@"id"];
    [vc setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:vc animated:YES];

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
    return [self.videoList count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    LiveBroadcastTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LiveBroadcastTableViewCell"];
    if (cell == nil) {
        [tableView registerNib:[UINib nibWithNibName:@"LiveBroadcastTableViewCell" bundle:nil] forCellReuseIdentifier:@"LiveBroadcastTableViewCell"];
        cell = [tableView dequeueReusableCellWithIdentifier:@"LiveBroadcastTableViewCell"];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell loadCourseInfo:[self.videoList objectAtIndex:indexPath.row]];

    
    return cell;
    
    
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}


@end
