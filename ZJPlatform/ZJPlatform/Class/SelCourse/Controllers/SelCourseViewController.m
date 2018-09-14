//
//  SelCourseViewController.m
//  ZJPlatform
//
//  Created by fengke on 2018/3/22.
//  Copyright © 2018年 wzsd. All rights reserved.
//

#import "SelCourseViewController.h"
#import "SelCourseTableViewCell.h"
#import "SelCourseDetailViewController.h"
#import "MJRefresh.h"
#import "MenuAlert.h"

@interface SelCourseViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    
    UITableView *myTableView;
    
    
    MenuAlert  *menuAlert1;
    MenuAlert  *menuAlert2;
    MenuAlert  *menuAlert3;
}

@property (nonatomic,strong) NSDictionary *selectedDict1;
@property (nonatomic,strong) NSDictionary *selectedDict2;

@property (nonatomic,assign) NSInteger orderStr;

@property (nonatomic,strong) NSMutableArray *videoList;
@property (nonatomic,assign) NSInteger pageNo;
@property (nonatomic,assign) NSInteger pageSize;


@end

@implementation SelCourseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initHeaderView];
    self.pageNo = 0;
    self.pageSize = 6;
    self.orderStr = 2;
    if ([self.navigationController.viewControllers count] == 1) {
        self.questionType = @"1";
        myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 45, MainScreenWidth, MainScreenheight - 44 - kStatusBarHeight - 45 - kTabbarHeight) style:UITableViewStylePlain];
        [self setTitleView:@"在线选课"];
    }else{
        self.questionType = @"2";
        myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 45, MainScreenWidth, MainScreenheight - 44 - kStatusBarHeight - 45 ) style:UITableViewStylePlain];
        [self setTitleView:@"免费选课"];
        [self createBackBtn];

    }
    
    if (self.type == 1) {
        [self setTitleView:@"推荐课程"];
    }
    
    myTableView.delegate = self;
    myTableView.dataSource = self;
    [self.view addSubview:myTableView];
    myTableView.tableFooterView = [[UIView alloc] init];
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
    
    
    NSMutableDictionary *dict =  [NSMutableDictionary dictionaryWithDictionary:@{@"pageNo":[NSNumber numberWithInteger:self.pageNo],@"pageSize":PageSize,@"subjects.id":Subject_Id,@"questionType":self.questionType,@"hotRecommend":@"1"}];
    
    if (self.type == 1) {
        dict =  [NSMutableDictionary dictionaryWithDictionary:@{@"pageNo":@(self.pageNo),@"pageSize":@(self.pageSize),@"subjects.id":Subject_Id,@"questionType":@"1",@"hotRecommend":@"1"}];
    }
    [dict setObject:@(self.orderStr) forKey:@"orderStr"];
    [dict setObject:[self.selectedDict1 objectForKey:@"id"] forKey:@"subjects.id"];
    if (self.selectedDict2) {
        [dict setObject:[self.selectedDict2 objectForKey:@"id"] forKey:@"famousTeacher.id"];
    }
 
    WS(weakSelf);
    [[NetworkManager shareNetworkingManager] requestWithMethod:@"GET" headParameter:nil bodyParameter:dict relativePath:url success:^(id responseObject) {
        NSLog(@"选课：%@",responseObject);
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
        [btn setTitleColor:[UIColor colorWithHexString:@"444444"] forState:UIControlStateNormal];
        
        [btn setImage:[UIImage imageNamed:@"arrow_up3.png"] forState:UIControlStateSelected];
        [btn setTitleColor:MainBlueColor forState:UIControlStateSelected];

        [btn setBackgroundColor:[UIColor whiteColor]];

        if (i == 0) {
             self.selectedDict1 = [Utility objectForKey:Sel_Subject];
            [btn setTitle:[self.selectedDict1 objectForKey:@"name"] forState:UIControlStateNormal];
        }else if(i == 1){
            [btn setTitle:@"主讲老师" forState:UIControlStateNormal];
        }else {
            [btn setTitle:@"时间排序" forState:UIControlStateNormal];

        }
        [Utility changeImageTitleForBtn:btn];
        btn.tag = i +1;
        [btn addTarget:self action:@selector(showMenuAlert:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn];
        
    }
}

-(void)showMenuAlert:(UIButton *)btn{
    btn.selected = YES;
    if (btn.tag == 1 ) {
        if (menuAlert1 == nil) {
            NSArray *array = [Utility objectForKey:Subject_List];
            menuAlert1 =  [[MenuAlert alloc] initWithFrame:CGRectMake(0, 44, MainScreenWidth, [array count] * 44)];
            NSMutableArray *titles = [NSMutableArray array];
            for (NSInteger i = 0; i < [array count]; i ++) {
                NSDictionary *dict = array[i];
                [titles addObject:[dict objectForKey:@"name"]];
                if ([[self.selectedDict1 objectForKey:@"name"] isEqualToString:[dict objectForKey:@"name"]]) {
                    menuAlert1.defRow = i;
                }
            }
            menuAlert1.arrMDataSource = [NSArray arrayWithArray:titles];
            menuAlert1.tabColor =[UIColor whiteColor];
            menuAlert1.cusFont = Font(13);
            menuAlert1.txtColor = [UIColor colorWithHexString:@"1c252a"];
            WS(weakSelf);
            [menuAlert1 setDidSelectedCallback:^(NSInteger index, NSString *content) {
                weakSelf.selectedDict1 = [NSDictionary dictionaryWithDictionary:array[index]];
                [btn setTitle:content forState:UIControlStateNormal];
                [Utility changeImageTitleForBtn:btn];
                
                
                UIButton *btn2 = [weakSelf.view viewWithTag:2];
                [btn2 setTitle:@"主讲老师" forState:UIControlStateNormal];
                weakSelf.selectedDict2 = nil;
                
                [weakSelf requestCourseList];
            }];
            [menuAlert1 setDismissCallback:^{
                btn.selected = NO;
            }];
            
        }
        [menuAlert1 show];
        
    }else if(btn.tag == 2){
       
        SHOW_HUD;
        NSString *url = [NSString stringWithFormat:@"%@%@",ProxyUrl,kRequest_famousTeacher_queryList];
        NSDictionary *dict =  @{@"pageNo":@"0",@"pageSize":@"20",@"subjects.id":[self.selectedDict1 objectForKey:@"id"]};
        WS(weakSelf);
        [[NetworkManager shareNetworkingManager] requestWithMethod:@"GET" headParameter:nil bodyParameter:dict relativePath:url success:^(id responseObject) {
            HIDDEN_HUD;
            NSArray *array = [responseObject objectForKey:@"list"];
            [weakSelf showMenuAlert2:array withBtn:btn];
        } failure:^(NSString *errorMsg) {
            HIDDEN_HUD;
            
        }];
    }else{
        if (menuAlert3 == nil) {
            NSArray *titles = @[@"浏览量排序",@"时间排序"];
            menuAlert3 =  [[MenuAlert alloc] initWithFrame:CGRectMake(0, 44, MainScreenWidth, [titles count] * 44)];
            menuAlert3.arrMDataSource = [NSArray arrayWithArray:titles];
            menuAlert3.tabColor =[UIColor whiteColor];
            menuAlert3.cusFont = Font(13);
            menuAlert3.txtColor = [UIColor colorWithHexString:@"1c252a"];
            WS(weakSelf);
            menuAlert3.defRow = 1;

            [menuAlert3 setDidSelectedCallback:^(NSInteger index, NSString *content) {
                [btn setTitle:content forState:UIControlStateNormal];
                [Utility changeImageTitleForBtn:btn];
                if (index == 0) {
                    weakSelf.orderStr = 1;
                }else{
                    weakSelf.orderStr = 2;
                }
                [weakSelf requestCourseList];

            }];
            [menuAlert3 setDismissCallback:^{
                btn.selected = NO;
            }];
        }
        [menuAlert3 show];
    }
}


-(void)showMenuAlert2:(NSArray *)array withBtn:(UIButton *)btn{
    if (menuAlert2 == nil) {
        menuAlert2 =  [[MenuAlert alloc] initWithFrame:CGRectMake(0, 44, MainScreenWidth, MainScreenheight - kStatusBarHeight - 44 - 44)];
        NSMutableArray *titles = [NSMutableArray array];
        for (NSDictionary *dict in array) {
            [titles addObject:[dict objectForKey:@"name"]];
        }
        menuAlert2.arrMDataSource = [NSArray arrayWithArray:titles];
        menuAlert2.tabColor =[UIColor whiteColor];
        menuAlert2.cusFont = Font(13);
        menuAlert2.txtColor = [UIColor colorWithHexString:@"1c252a"];
        WS(weakSelf);
        [menuAlert2 setDidSelectedCallback:^(NSInteger index, NSString *content) {
            weakSelf.selectedDict2 = [NSDictionary dictionaryWithDictionary:array[index]];
            [btn setTitle:content forState:UIControlStateNormal];
            [Utility changeImageTitleForBtn:btn];
            [weakSelf requestCourseList];

        }];
        [menuAlert2 setDismissCallback:^{
            btn.selected = NO;
        }];
        
    }
    [menuAlert2 show];
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    SelCourseDetailViewController *vc = [[SelCourseDetailViewController alloc] initWithNibName:@"SelCourseDetailViewController" bundle:nil];
    vc.videoId = [[self.videoList objectAtIndex:indexPath.row] objectForKey:@"id"];
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
    return [self.videoList count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SelCourseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SelCourseTableViewCell"];
    if (cell == nil) {
        [tableView registerNib:[UINib nibWithNibName:@"SelCourseTableViewCell" bundle:nil] forCellReuseIdentifier:@"SelCourseTableViewCell"];
        cell = [tableView dequeueReusableCellWithIdentifier:@"SelCourseTableViewCell"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell loadCourseInfo:[self.videoList objectAtIndex:indexPath.row]];
    return cell;
    
    
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
@end
