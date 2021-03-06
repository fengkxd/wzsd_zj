//
//  MineCenterViewController.m
//  ZJPlatform
//
//  Created by fengke on 2018/3/22.
//  Copyright © 2018年 wzsd. All rights reserved.
//

#import "MineCenterViewController.h"
#import "MineCenterHeaderView.h"
#import "SettingTableViewController.h"
#import "MyDetailViewController.h"


@interface MineCenterViewController ()
{
    BOOL firstLoad;
    
    MineCenterHeaderView *headerView;
}
@property (nonatomic,strong) NSDictionary *memberInfoDict;

@end


@implementation MineCenterViewController

-(void)showSetting{
    SettingTableViewController *vc = [[SettingTableViewController alloc] init];
    [vc setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)showScan{
    
    
}


-(void)showMsg{
    
    
}



- (void)viewDidLoad {
    [super viewDidLoad];
 
    if (@available(iOS 11.0, *)) {
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }

    firstLoad = NO;
    self.tableView.contentOffset = CGPointMake(0, -20);
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginSuccess) name:kNotification_LOGIN_SUCCESS object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadData) name:kNotification_UPDATE_SUBJECT object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginSuccess) name:kNotification_Refresh_UserInfo object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(logout) name:kNotification_LOGIN_OUT object:nil];

    
    
    headerView = [[[NSBundle mainBundle] loadNibNamed:@"MineCenterHeaderView" owner:self options:nil] lastObject];
    self.tableView.tableHeaderView = headerView;
    headerView.sourceView.hidden = YES;
    headerView.nameLabel.hidden = YES;
    headerView.loginBtn.hidden = NO;
    
    WS(weakSelf);
    headerView.clickScan = ^{
        [weakSelf showScan];
    };
    headerView.clickMsg = ^{
        [weakSelf showMsg];

    };
    headerView.clickSetting = ^{
        [weakSelf showSetting];
    };
    
    UITapGestureRecognizer * ges = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(click:)];
     [headerView addGestureRecognizer:ges];
    
    [self loginSuccess];
}




-(void)click:(UIGestureRecognizer *)ges{
    if (self.memberInfoDict == nil) {
        return;
    }
    MyDetailViewController *vc = [[MyDetailViewController alloc] init];
    vc.userDict = [self.memberInfoDict objectForKey:@"member"];
    [vc setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:vc animated:YES];
}







-(void)reloadData{
    [self.tableView reloadData];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    if (firstLoad == NO) {
        firstLoad = YES;
        self.tableView.contentOffset = CGPointMake(0, 0);
    }
}

-(void)loginSuccess{
    NSString *url = [NSString stringWithFormat:@"%@%@",ProxyUrl,kRequest_member_getMemberMessage];
    WS(weakSelf);
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[NetworkManager shareNetworkingManager] requestWithMethod:@"GET" headParameter:nil bodyParameter:nil relativePath:url
                                                       success:^(id responseObject) {
                                                           NSLog(@"%@",responseObject);
                                                           [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
                                                           [weakSelf loadMemberInfo:responseObject];
                                                       } failure:^(NSString *errorMsg) {

                                                           [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
                                                         //  [Toast showWithText:errorMsg];

                                                       }];
    
}


-(void)loadMemberInfo:(NSDictionary *)dict{
    self.memberInfoDict = [NSDictionary dictionaryWithDictionary:dict];
    [headerView loadInfo:self.memberInfoDict];
    [self.tableView reloadData];
    
}

-(void)logout{
    self.memberInfoDict =  nil;
    [headerView loadInfo:self.memberInfoDict];
    [self.tableView reloadData];
}

-(void)clickItem:(UIButton *)btn{
    NSArray *vcs =@[@"ExamInformationViewController",@"MyCourseTableViewController",@"CouponTableViewController"];
    
    BaseViewController *vc = [[NSClassFromString([vcs objectAtIndex:btn.tag]) alloc] init];
    [vc setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:vc animated:YES];
}




- (void)verticalImageAndTitle:(CGFloat)spacing withBtn:(UIButton *)btn
{
    btn.titleLabel.font = Font_15;
    CGSize imageSize = btn.imageView.frame.size;
    CGSize titleSize = btn.titleLabel.frame.size;
    CGSize size = CGSizeMake(320,2000); //设置一个行高上限
    NSDictionary *attribute = @{NSFontAttributeName: btn.titleLabel.font};
    CGSize textSize = [btn.titleLabel.text boundingRectWithSize:size options: NSStringDrawingTruncatesLastVisibleLine |NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attribute context:nil].size;
    
    CGSize frameSize = CGSizeMake(ceilf(textSize.width), ceilf(textSize.height));
    if (titleSize.width + 0.5 < frameSize.width) {
        titleSize.width = frameSize.width;
    }
    [btn setTitleColor:[Utility colorWithHexString:@"333333"] forState:UIControlStateNormal];
    CGFloat totalHeight = (imageSize.height + titleSize.height + spacing);
    btn.imageEdgeInsets = UIEdgeInsetsMake(- (totalHeight - imageSize.height), 0.0, 0.0, - titleSize.width);
    btn.titleEdgeInsets = UIEdgeInsetsMake(0, - imageSize.width, - (totalHeight - titleSize.height) - 10, 0);
    [btn setBackgroundColor:[UIColor whiteColor]];
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSInteger row = indexPath.row;
    
    NSArray *vcs = @[@"ExamInformationViewController",@"learningTimeViewController",@"MyOrderViewController"
                     ,@"MyCommentViewController",@"CouponTableViewController",@"MyTQTableViewController",@"CouponTableViewController"];
    
    BaseViewController *vc = [[NSClassFromString([vcs objectAtIndex:row]) alloc] init];
    [vc setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:vc animated:YES];
    
    
    
}



-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
  //  NSInteger section = indexPath.section;
    NSInteger row = indexPath.row;
    
    static NSString *cellid = @"cell2";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellid];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        cell.textLabel.font = Font_14;
        cell.textLabel.textColor = [UIColor colorWithHexString:@"333333"];
    }
    cell.detailTextLabel.attributedText = nil;
    if (row == 0) {
        cell.textLabel.text =  [NSString stringWithFormat:@"当前考试：%@",[[Utility objectForKey:Sel_Subject] objectForKey:@"name"]];
        if (self.memberInfoDict) {
            NSString *str = [NSString stringWithFormat:@"您在网校的%zi天",[[self.memberInfoDict objectForKey:@"loginNum"] integerValue]];
            NSMutableAttributedString *mutableAttributeStr = [[NSMutableAttributedString alloc] initWithString:str];
            [mutableAttributeStr addAttribute:NSFontAttributeName
                                        value:Font_13
                                        range:NSMakeRange(0, str.length)];
            [mutableAttributeStr addAttribute:NSForegroundColorAttributeName
                                        value:[UIColor colorWithHexString:@"01a9fc"]
                                        range:[str rangeOfString:[NSString stringWithFormat:@"%zi",[[self.memberInfoDict objectForKey:@"loginNum"] integerValue]]]];
            cell.detailTextLabel.attributedText = mutableAttributeStr;
        }
        
    }else if(row == 1){
        cell.textLabel.text = @"学习时间统计";
    }else if(row == 2){
        cell.textLabel.text = @"我的课程";
    }else if(row == 3){
        cell.textLabel.text = @"我的评价";
    }else if(row == 4){
        cell.textLabel.text = @"我的优惠券";
    }else if(row == 5){
        cell.textLabel.text = @"我的题库";
    }else if(row == 6){
        cell.textLabel.text = @"意见反馈";
    }
    return cell;
    
}



-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return nil;
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 0.1;
    }
    return 10;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    return nil;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    if (indexPath.section == 0) {
//        return 80;
//    }
    return 50;
}



-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
//    if (section == 0) {
//        return 1;
//    }
    return 7;
 }



-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}







@end
