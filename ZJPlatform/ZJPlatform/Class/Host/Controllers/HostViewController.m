//
//  HostViewController.m
//  ZJPlatform
//
//  Created by fengke on 2018/3/22.
//  Copyright © 2018年 wzsd. All rights reserved.
//

#import "HostViewController.h"
#import "HostBannerView.h"
#import "HostVideoView.h"
#import "HostCommendVideoView.h"
#import "HostFreeVideoView.h"
#import "HostInformationTableViewCell.h"
#import "HostSelectedTypeViewController.h"
#import "AppDelegate.h"
#import "ExamGuideViewController.h"
#import "MyWebViewController.h"
#import "PreparationInformationTableViewCell.h"
#import "TestRelevantViewController.h"

@interface HostViewController ()<UITextFieldDelegate>
{
    
    IBOutlet UITableViewCell *newscell;
    UITextField *mytextField;
    UIButton *typeBtn;
    
}
@property (nonatomic,strong) NSArray *videoList1;

@property (nonatomic,strong) NSArray *videoList2;
@property (nonatomic,strong) NSDictionary *subjectDict;
@property (nonatomic,strong) NSArray *examNewsList;

@end

@implementation HostViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initTitleView];
    [self autoLogin];
    [self requestBanner1];
    [self requestNotice];
    [self requestBanner2];
    [self requestCourseList1];
    [self requestCourseList2];
    [self requestExamNews];

    WS(weakSelf);
    [self.tableView addLegendHeaderWithRefreshingBlock:^{
        [weakSelf requestBanner1];
        [weakSelf requestNotice];
        [weakSelf requestBanner2];
        [weakSelf requestCourseList1];
        [weakSelf requestCourseList2];
        [weakSelf requestExamNews];
    }];
    
    
}

-(void)autoLogin{
    NSString *url = [NSString stringWithFormat:@"%@%@",ProxyUrl,kRequest_signin];
    NSDictionary *dict = @{@"account":[Utility objectForKey:USERNAME],@"password":[[Utility md5:[Utility objectForKey:PASSWORD]] lowercaseString]};
    [[NetworkManager shareNetworkingManager] requestWithMethod:@"POST" headParameter:nil bodyParameter:dict relativePath:url success:^(id responseObject) {
    } failure:^(NSString *errorMsg) {
    }];
    
}


-(void)requestCourseList1{
    NSString *url = [NSString stringWithFormat:@"%@%@",ProxyUrl,kRequest_video_list];
    NSDictionary *dict =  @{@"pageNo":@"0",@"pageSize":@"4",@"subjects.id":Subject_Id,@"questionType":@"1",@"hotRecommend":@"1"};
    WS(weakSelf);
    [[NetworkManager shareNetworkingManager] requestWithMethod:@"GET" headParameter:nil bodyParameter:dict relativePath:url success:^(id responseObject) {
        NSLog(@"限时免费：%@",responseObject);
        [weakSelf loadCourseList1:responseObject];
    } failure:^(NSString *errorMsg) {
        [Toast showWithText:errorMsg];
    }];
}





-(void)requestCourseList2{
    NSString *url = [NSString stringWithFormat:@"%@%@",ProxyUrl,kRequest_video_list];
    NSDictionary *dict =  @{@"pageNo":@"0",@"pageSize":@"4",@"subjects.id":Subject_Id,@"questionType":@"1",@"hotRecommend":@"1"};
    WS(weakSelf);
    [[NetworkManager shareNetworkingManager] requestWithMethod:@"GET" headParameter:nil bodyParameter:dict relativePath:url success:^(id responseObject) {
        NSLog(@"推荐课程：%@",responseObject);
        [weakSelf loadCourseList2:responseObject];
    } failure:^(NSString *errorMsg) {
        [Toast showWithText:errorMsg];
    }];
}



-(void)requestNotice{
    NSDictionary *dict =  @{@"pageNo":@"0",@"pageSize":@"1",@"type":@"recent_announcement",@"subjects.id":Subject_Id};
    NSString *url = [NSString stringWithFormat:@"%@%@",ProxyUrl,kRequest_newsInformation_list];
    [[NetworkManager shareNetworkingManager] requestWithMethod:@"GET" headParameter:nil bodyParameter:dict relativePath:url success:^(id responseObject) {
        NSLog(@"中教头条：%@",responseObject);


    } failure:^(NSString *errorMsg) {
        
    }];
    
    
}

-(void)requestBanner1{
    NSString *url = [NSString stringWithFormat:@"%@%@",ProxyUrl,kRequest_adv_list];
    NSDictionary *dict = @{@"type":@"1",@"position":@"homeBanner"};
     [[NetworkManager shareNetworkingManager] requestWithMethod:@"GET" headParameter:nil bodyParameter:dict relativePath:url success:^(id responseObject) {
        NSLog(@"banner：%@",responseObject);
        [self initBanner:responseObject];
    } failure:^(NSString *errorMsg) {
        
    }];
}

-(void)requestBanner2{
    NSString *url = [NSString stringWithFormat:@"%@%@",ProxyUrl,kRequest_adv_list];
    NSDictionary *dict = @{@"type":@"1",@"position":@"appHome"};
     [[NetworkManager shareNetworkingManager] requestWithMethod:@"GET" headParameter:nil bodyParameter:dict relativePath:url success:^(id responseObject) {
        NSLog(@"banner2：%@",responseObject);
        //[weakSelf initBanner:responseObject];
    } failure:^(NSString *errorMsg) {
        
    }];
}

-(void)requestExamNews{
    
    NSDictionary *dict =  @{@"pageNo":@"0",@"pageSize":@"6",@"type":@"Industry_dynamics",@"subjects.id":Subject_Id};
    NSString *url = [NSString stringWithFormat:@"%@%@",ProxyUrl,kRequest_newsInformation_list];
    [[NetworkManager shareNetworkingManager] requestWithMethod:@"GET" headParameter:nil bodyParameter:dict relativePath:url success:^(id responseObject) {
        NSLog(@"requestExamNews：%@",responseObject);
        [self loadExamNews:responseObject];
        [self.tableView.header endRefreshing];
    } failure:^(NSString *errorMsg) {
        [self.tableView.header endRefreshing];
    }];
}

-(void)loadExamNews:(NSDictionary *)dict{
    
    self.examNewsList = [NSArray arrayWithArray:[dict objectForKey:@"list"]];
    [self.tableView reloadData];
    
}

-(void)loadCourseList1:(NSDictionary *)dict{
    self.videoList1 = [NSArray arrayWithArray:[dict objectForKey:@"list"]];
    [self.tableView reloadData];
}


-(void)loadCourseList2:(NSDictionary *)dict{
    self.videoList2 = [NSArray arrayWithArray:[dict objectForKey:@"list"]];
    [self.tableView reloadData];
}



-(void)initBanner:(NSArray *)array{
    
    CGFloat bannerHeitght = 310 /750.0 * MainScreenWidth;
    HostBannerView *bannerView = [[HostBannerView alloc] initWithFrame:CGRectMake(0, 0, MainScreenWidth, bannerHeitght) withArray:array];
    
    bannerView.clickBanner = ^(NSDictionary *dict) {
        NSString *goHref = [dict objectForKey:@"goHref"];
        MyWebViewController *vc = [[MyWebViewController alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        [vc loadUrlStr:goHref];
        [self.navigationController pushViewController:vc animated:YES];
    };
    self.tableView.tableHeaderView = bannerView;
}


-(void)selectedType:(UIButton *) btn{

    HostSelectedTypeViewController *vc = [[HostSelectedTypeViewController alloc] init];
    [vc setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:vc animated:YES];
    __weak HostSelectedTypeViewController *blockVC = vc;

    vc.selectedBlock = ^(void) {
        [self initTitleView];
        [self.tableView.header beginRefreshing];
        [blockVC goBack:nil];
    };
}

-(void)initTitleView{
    self.subjectDict = [Utility objectForKey:Sel_Subject];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:kNotification_LOGIN_SUCCESS object:nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:kNotification_UPDATE_SUBJECT object:nil];
    
    NSString *title = [self.subjectDict objectForKey:@"name"];
    
    CGSize size = CGSizeMake(320,2000); //设置一个行高上限
    NSDictionary *attribute = @{NSFontAttributeName: Font_14};
    CGFloat width = [title boundingRectWithSize:size options: NSStringDrawingTruncatesLastVisibleLine |NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attribute context:nil].size.width;


    
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, MainScreenWidth , 44)];
    titleView.backgroundColor = [UIColor clearColor];
    typeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    typeBtn.frame = CGRectMake(0, 6, width + 30, 32);
    typeBtn.titleLabel.font = Font_14;
    [typeBtn setImage:[UIImage imageNamed:@"arrow_up.png"] forState:UIControlStateNormal];
    [titleView addSubview:typeBtn];
    [typeBtn setBackgroundColor:[UIColor colorWithHexString:@"008ade"]];
    [typeBtn setTitle:[self.subjectDict objectForKey:@"name"] forState:UIControlStateNormal];
    [typeBtn addTarget:self action:@selector(selectedType:) forControlEvents:UIControlEventTouchUpInside];
    
    [Utility changeImageTitleForBtn:typeBtn];
    
    UIView *mytextFieldBgView = [[UIView alloc] initWithFrame:CGRectMake(typeBtn.frame.size.width + 15, 5, MainScreenWidth - typeBtn.frame.size.width - 40, 32)];
    mytextFieldBgView.backgroundColor = [UIColor whiteColor];
    mytextFieldBgView.layer.masksToBounds = YES;
    mytextFieldBgView.layer.cornerRadius = 4;
    [titleView addSubview:mytextFieldBgView];
    
    UIImageView *imgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"search.png"]];
    imgView.frame = CGRectMake(5, 7, 20, 20);
    [mytextFieldBgView addSubview:imgView];
    
    mytextField = [[UITextField alloc] initWithFrame:CGRectMake(34, 0, mytextFieldBgView.frame.size.width - 34, 32)];
    mytextField.placeholder = @"请输入关键字";
    mytextField.font = Font_14;
    mytextField.returnKeyType = UIReturnKeySearch;
    mytextField.delegate = self;
    mytextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    
    [mytextFieldBgView addSubview:mytextField];
    
    self.navigationItem.titleView = titleView;
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0 || section == 1) {
        return 5;
    }
    
    return 10;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}



-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 6;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 3) {
        return ceilf([self.videoList1 count] /2) + 1 ;
    }else if(section == 4){
        return [self.videoList2 count] + 1;
    }else if(section == 5){
        return [self.examNewsList count] + 1;
    }
    return 1;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger section = indexPath.section;
    NSInteger row = indexPath.row;
    if (section == 0) {
        return 35;
    }else if(section == 1){
        return 190;
    }else if(section == 2){
        return 160.0 /750.0 * MainScreenWidth;
    }else if(section > 2 && row == 0){
        return 42;
    }else if(section == 3){
       return  230.0/346.0 * ( MainScreenWidth/2.0 - 15) + 87;
    }else if(section == 4){
        return 88;
    }
    
    
    return 90;
}

-(void)clickIcon:(UIButton *)btn{
    
    NSArray *vcs =@[@"SelCourseViewController",
                    @"2",
                    @"1",
                    @"TeacherListViewController",
                    @"3",
                    @"NewsZJTableViewController",
                    @"ExamGuideViewController",
                    @"PreparationInformationViewController"];
    
    
    NSString *str = [vcs objectAtIndex:btn.tag];
    if([str isEqualToString:@"1"]){
        AppDelegate *appdelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        [appdelegate.customTabBar selectedIndex:1];
    }else if([str isEqualToString:@"2"]){
        AppDelegate *appdelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        
        [appdelegate.customTabBar selectedIndex:2];
        
    }else if([str isEqualToString:@"3"]){
        AppDelegate *appdelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        [appdelegate.customTabBar selectedIndex:3];
    }else{
  
            BaseViewController *vc = [[NSClassFromString([vcs objectAtIndex:btn.tag]) alloc] init];
            [vc setHidesBottomBarWhenPushed:YES];
            [self.navigationController pushViewController:vc animated:YES];
                    
    }
    
}



-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger section = indexPath.section;
    NSInteger row = indexPath.row;
    if (section == 0) {
        return newscell;
    }else if(section == 1){
        static NSString *cellid = @"cell1";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellid];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            CGFloat width =  MainScreenWidth /4.0;
            CGFloat h = 85;
            for (NSInteger i = 0; i < 8; i ++ ) {
                NSInteger row  = i / 4;
                NSInteger column = i % 4;
                UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
                btn.frame = CGRectMake(column * width, row * h, width, h);
                btn.tag = i;
                [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                switch (i) {
                    case 0:
                        [btn setTitle:@"免费课程" forState:UIControlStateNormal];
                        break;
                    case 1:
                        [btn setTitle:@"直播课程" forState:UIControlStateNormal];
                        break;
                    case 2:
                        [btn setTitle:@"在线课程" forState:UIControlStateNormal];
                        break;
                    case 3:
                        [btn setTitle:@"名师团队" forState:UIControlStateNormal];
                        break;
                    case 4:
                        [btn setTitle:@"在线题库" forState:UIControlStateNormal];
                        break;
                    case 5:
                        [btn setTitle:@"中教新闻" forState:UIControlStateNormal];
                        break;
                    case 6:
                        [btn setTitle:@"考试指南" forState:UIControlStateNormal];
                        break;

                    case 7:
                        [btn setTitle:@"备考资料" forState:UIControlStateNormal];
                        break;
                    default:
                        break;
                }
                
                [btn addTarget:self action:@selector(clickIcon:) forControlEvents:UIControlEventTouchUpInside];
                [btn setImage:[UIImage imageNamed:[NSString stringWithFormat:@"HostIcon%zi.png",i+1]] forState:UIControlStateNormal];
                [cell.contentView addSubview:btn];
                [self verticalImageAndTitle:5 withBtn:btn];
                
            }
        }
        return cell;
    }else if(section == 2){
    
        static NSString *cellid = @"cell2";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellid];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, MainScreenWidth, 160.0 /750.0 * MainScreenWidth)];
            imgView.image = [UIImage imageNamed:@"centerBanner.png"];
            [cell.contentView addSubview:imgView];
            
        }
        return cell;
    }else if(row == 0 && section > 2){
        NSString *cellId = @"cell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellId];
            
            UIView *view = [[UIView alloc] initWithFrame:CGRectMake(10, 9.5, 0.5, 23)];
            view.backgroundColor = [UIColor colorWithHexString:@"11a2ec"];
            [cell.contentView addSubview:view];
            
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(17, 0, 150, 42)];
            label.font = TitleFont;
            label.textColor = [UIColor colorWithHexString:@"333333"];
            [cell.contentView addSubview:label];
            label.tag =  11;
            
            cell.detailTextLabel.text = @"更多";
            [cell.detailTextLabel setTextColor:[UIColor colorWithHexString:@"8e8e8e"]];
            cell.detailTextLabel.font = Font_15;
            cell.accessoryType = UITableViewCellAccessoryNone;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        UILabel *label = (UILabel *)[cell.contentView viewWithTag:11];
        if (section == 3) {
            label.text = @"限时免费";
        }else if(section == 4){
            label.text = @"推荐课程";
        }else{
            label.text = @"考试资讯";
        }
        return cell;
    }else if(section == 3){
        static NSString *cellId = @"cell3";
        
        CGFloat videoWidth = MainScreenWidth/2.0;
        CGFloat videoHeight =  230.0/346.0 * (MainScreenWidth/2.0 - 15)  + 87;
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];

        [cell.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];

        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellId];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        
        NSArray *array = [self.videoList1 objectsAtIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange((row-1) * 2, 2)]];
        for (NSInteger i = 0; i < [array count] ; i++) {
            NSInteger column = i % 2;
            HostVideoView *videoView = [[HostVideoView alloc] initWithFrame:CGRectMake( videoWidth * column , 0, videoWidth, videoHeight)];
            [cell.contentView addSubview:videoView];
            [videoView loadVideo:[array objectAtIndex:i]];
            videoView.delegate = self;
        }
        return cell;
  

    }else if(section == 4){
       
        HostCommendVideoView *cell = [tableView dequeueReusableCellWithIdentifier:@"HostCommendVideoView"];
        if (cell == nil) {
            [tableView registerNib:[UINib nibWithNibName:@"HostCommendVideoView" bundle:nil] forCellReuseIdentifier:@"HostCommendVideoView"];
            cell = [tableView dequeueReusableCellWithIdentifier:@"HostCommendVideoView"];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell loadCourse:[self.videoList2 objectAtIndex:indexPath.row - 1]];
        return cell;
    }

    
    PreparationInformationTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PreparationInformationTableViewCell"];
    if (cell == nil) {
        [tableView registerNib:[UINib nibWithNibName:@"PreparationInformationTableViewCell" bundle:nil] forCellReuseIdentifier:@"PreparationInformationTableViewCell"];
        cell = [tableView dequeueReusableCellWithIdentifier:@"PreparationInformationTableViewCell"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    [cell loadInfo:[self.examNewsList objectAtIndex:indexPath.row - 1]];
    
    return cell;

}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    NSInteger section = indexPath.section;
    NSInteger row = indexPath.row;
    if (section == 5) {
        if (row == 0) {
            TestRelevantViewController *vc = [[TestRelevantViewController alloc] init];
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }else{
            
            NSDictionary *dict = [self.examNewsList objectAtIndex:row -1];
            NSString *url =[NSString stringWithFormat:@"%@%@",ProxyUrl,kRequest_newsInformation_get];            
            [[NetworkManager shareNetworkingManager] requestWithMethod:@"GET" headParameter:nil bodyParameter:@{@"id":[dict objectForKey:@"id"]} relativePath:url success:^(id responseObject) {
                NSLog(@"资讯详情：%@",responseObject);
                MyWebViewController *vc = [[MyWebViewController alloc] init];
                [vc loadHtmlStr:[responseObject objectForKey:@"values"]];
                [vc setTitleView:[responseObject objectForKey:@"title"]];
                vc.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:vc animated:YES];
            } failure:^(NSString *errorMsg) {
                [Toast showWithText:errorMsg];
            }];
            
        }
    }
    
    
    
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




@end
