//
//  LiveBroadcastViewController.m
//  ZJPlatform
//
//  Created by fengke on 2018/3/22.
//  Copyright © 2018年 wzsd. All rights reserved.
//

#import "LiveBroadcastViewController.h"
#import "LiveBroadcastTableViewCell.h"

@interface LiveBroadcastViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    
    UITableView *myTbaleView;
}
@end


@implementation LiveBroadcastViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitleView:@"直播课程"];
    
    [self initHeaderView];
    
    
    myTbaleView = [[UITableView alloc] initWithFrame:CGRectMake(0, 45, MainScreenWidth, MainScreenheight - 44 - kStatusBarHeight - 45 - kTabbarHeight) style:UITableViewStylePlain];
    myTbaleView.delegate = self;
    myTbaleView.dataSource = self;
    [self.view addSubview:myTbaleView];
    myTbaleView.tableFooterView = [[UIView alloc] init];
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
    
//    SelCourseDetailViewController *vc = [[SelCourseDetailViewController alloc] initWithNibName:@"SelCourseDetailViewController" bundle:nil];
//    [vc setHidesBottomBarWhenPushed:YES];
//    [self.navigationController pushViewController:vc animated:YES];
    
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
    return 10;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    LiveBroadcastTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LiveBroadcastTableViewCell"];
    if (cell == nil) {
        [tableView registerNib:[UINib nibWithNibName:@"LiveBroadcastTableViewCell" bundle:nil] forCellReuseIdentifier:@"LiveBroadcastTableViewCell"];
        cell = [tableView dequeueReusableCellWithIdentifier:@"LiveBroadcastTableViewCell"];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    
    return cell;
    
    
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}


@end
