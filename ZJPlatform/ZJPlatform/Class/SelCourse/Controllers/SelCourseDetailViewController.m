//
//  SelCourseDetailViewController.m
//  ZJPlatform
//
//  Created by sostag on 2018/4/3.
//  Copyright © 2018年 wzsd. All rights reserved.
//

#import "SelCourseDetailViewController.h"
#import "SelCourseCommentTableViewCell.h"
#import <WebKit/WebKit.h>
#import "SelCourseTableViewCell.h"

@interface SelCourseDetailViewController ()<UITableViewDelegate,UITableViewDataSource,WKNavigationDelegate>
{
//    MRVLCPlayer *player;
    CGFloat videoHeight;
    UITableView *myTableView;
    IBOutlet UITableViewCell *cell1;
    UIView *markView;

    IBOutlet UILabel *titleLabel;
    IBOutlet UILabel *teachLabel;
    IBOutlet UILabel *subjectLabel;
    IBOutlet UILabel *priceLabel;
    IBOutlet UILabel *browsingNumberLabel;
    
}

@property (nonatomic,assign) NSInteger pageNo;
@property (nonatomic,assign) NSInteger pageSize;

@property (nonatomic,strong) UIButton *selectedBtn;
@property (nonatomic,strong) WKWebView *webView;
@property (nonatomic,assign) double webViewCellHeight;
@property (nonatomic,strong) NSDictionary *videoDict;

@property (nonatomic,strong) NSArray *courseList;

@end

@implementation SelCourseDetailViewController


- (BOOL)prefersStatusBarHidden{
    return YES;
}



-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear: animated];
    [[UIApplication sharedApplication] setStatusBarHidden:YES];
}


-(void)initPlayer{
  
//    videoHeight = 520 /750.0 * MainScreenWidth;
//
//    if (player) {
//        [player stopPlay];
//        [player removeFromSuperview];
//        player =  nil;
//    }
//    player = [[MRVLCPlayer alloc] initWithFrame:CGRectMake(0, 0, MainScreenWidth, videoHeight)];
//    player.controlView.moreButton.selected = YES;
//
//
//
//    player.mediaURL =  [NSURL URLWithString:@""];
//    player.tag = 22;
//    [player showInView:self.view];
//    WS(weakSelf);
//    player.dismissBlock = ^{
//        [weakSelf stopPlayer];
//        [[UIApplication sharedApplication] setStatusBarHidden:NO];
//        [weakSelf.navigationController popViewControllerAnimated:YES];
//    };
//
//    player.moreBlock = ^{
//        [weakSelf showActionSheet];
//    };
//
//    player.updateWatchNumBlock = ^{
//        [weakSelf updateWatchNum];
//    };
    
    
}




-(void)showActionSheet{
    
//    MRVLCPlayer *VLCPlayer = (MRVLCPlayer *)[self.view viewWithTag:22];
//
//    if (self.curCourse.isCollect == 0) {
//        self.curCourse.isCollect = 1;
//        VLCPlayer.controlView.moreButton.selected = YES;
//
//    }else{
//        self.curCourse.isCollect = 0;
//        VLCPlayer.controlView.moreButton.selected = NO;
//
//    }
//    NSString *url = [NSString stringWithFormat:@"%@%@",ProxyUrl,kRequest_Related];
//    NetworkManager *networkManager = [NetworkManager shareNetworkingManager];
//    [networkManager cancelTask:url];
//    NSMutableDictionary *dict =[NSMutableDictionary dictionaryWithDictionary:@{@"data":@{@"classes":@"course",@"isRelated":[NSString stringWithFormat:@"%zi",self.curCourse.isCollect],@"id":self.curCourse.courseId,@"type":@"collect"}}];
//    WS(weakSelf);
//    [networkManager requestWithMethod:@"POST" headParameter:nil
//                        bodyParameter:dict
//                         relativePath:url success:^(id responseObject) {
//                             //  [weakSelf performSelector:@selector(showToast) withObject:nil afterDelay:0.5];
//                             if (weakSelf.curCourse.isCollect == 0) {
//                                 [Toast showWithText:@"取消收藏成功"];
//                             }else{
//                                 [Toast showWithText:@"收藏成功"];
//                             }
//                         } failure:^(NSString *errorMsg) {
//                         }];
    
    
}



-(void)updateWatchNum{
//    if (!isUpdate) {
//        isUpdate = YES;
//        NSString *url = [NSString stringWithFormat:@"%@%@",ProxyUrl,kURL_WatchNum];
//        [[NetworkManager shareNetworkingManager] requestWithMethod:@"POST"
//                                                     headParameter:nil
//                                                     bodyParameter:@{@"data":@{@"courseId":self.curCourse.courseId}}
//                                                      relativePath:url
//                                                           success:^(id responseObject) {
//                                                           } failure:^(NSString *errorMsg) {
//                                                           }];
//    }
}






-(void)stopPlayer{
   // [player stopPlay];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.backBarButtonItem = nil;
    self.navigationItem.leftBarButtonItem = nil;
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    }
    [self initPlayer];
    
    myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, videoHeight, MainScreenWidth, MainScreenheight - videoHeight) style:UITableViewStylePlain];
    myTableView.delegate = self;
    myTableView.dataSource = self;
    [self.view addSubview:myTableView];
    myTableView.tableFooterView = [UIView new];
    [self requestVideoDetails];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
}

-(void)requestVideoDetails{
    
    NSString *url = [NSString stringWithFormat:@"%@%@",ProxyUrl,kRequest_video_details];
    NSDictionary *dict =  @{@"id":self.videoId};
    WS(weakSelf);
    
    [[NetworkManager shareNetworkingManager] requestWithMethod:@"GET" headParameter:nil bodyParameter:dict relativePath:url success:^(id responseObject) {
        NSLog(@"视频详情%@",responseObject);
        [weakSelf loadVideoInfo:responseObject];
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
    } failure:^(NSString *errorMsg) {
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        [Toast showWithText:errorMsg];

    }];

}

-(void)loadVideoInfo:(NSDictionary *)dict{
    self.videoDict = [NSDictionary  dictionaryWithDictionary:dict];
    titleLabel.text = [dict objectForKey:@"name"];
    priceLabel.text = [NSString stringWithFormat:@"¥%.2f",[[dict objectForKey:@"price"] floatValue]];
    teachLabel.text = [NSString stringWithFormat:@"名师：%@",[[dict objectForKey:@"famousTeacher"] objectForKey:@"name"]];
    subjectLabel.text = [NSString stringWithFormat:@"科目：%@",[[dict objectForKey:@"subjects"] objectForKey:@"name"]];
    browsingNumberLabel.text = [NSString stringWithFormat:@"%zi人观看",[[dict objectForKey:@"browsingNumber"] integerValue]];
    [myTableView reloadData];
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 0.1;
    }
    return 10;
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }
    
    NSInteger type = self.selectedBtn.tag ;
    
    if (type == 0) {
        return 2;
    }else if(type ==1){
        return [self.courseList count] + 1;
        
    }
    
    return 5;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    NSInteger section = indexPath.section;
    NSInteger row = indexPath.row;

    if (section == 0) {
        return 110;
    }else if(section == 1 && row == 0){
        return 45;
 
    }
    NSInteger type = self.selectedBtn.tag ;

    if (type == 0) {
        return self.webViewCellHeight;
    }else if(type == 1){
        return 88;
    }
   
    
    NSDictionary *dict = @{@"content":@"去几千几万了阿胶了7⃣️文件7⃣️文件额请我看了饥饿离开家去玩了句我起来看饥饿精力看见；离开家离开家了句了"};
    NSString *content = [dict objectForKey:@"content"];
    
    CGFloat height = [Utility getSpaceLabelHeight:content withFont:Font_13 withWidth:MainScreenWidth - 85];

    return 38 + height + 10 + 15 + 10;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    return nil;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger section = indexPath.section;
    NSInteger row = indexPath.row;
    if (section == 0) {
        return cell1;
    }else{
        if (row == 0) {
            static NSString *cellId = @"cellId";
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
            if (cell == nil) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellId];
                
                for (int i = 0; i < 3 ; i++) {
                    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
                    btn.frame = CGRectMake(i * MainScreenWidth/3.0, 0, MainScreenWidth/3.0, 44);
                    if (i == 0) {
                        [btn setTitle:@"课程详情" forState:UIControlStateNormal];
                        self.selectedBtn = btn;
                    }else if (i == 1) {
                        [btn setTitle:@"课程目录" forState:UIControlStateNormal];
                    }else{
                        [btn setTitle:@"课程评论" forState:UIControlStateNormal];
                    }
                    btn.tag = i;
                    btn.titleLabel.font = Font_13;
                    [btn setTitleColor:[UIColor colorWithHexString:@"444444"] forState:UIControlStateNormal];
                    [btn setTitleColor:[UIColor colorWithHexString:@"04a7fd"] forState:UIControlStateSelected];
                    [btn addTarget:self action:@selector(clickItem:) forControlEvents:UIControlEventTouchUpInside];
                    [cell.contentView addSubview:btn];
                }
                
                markView = [[UIView alloc] initWithFrame:CGRectZero];
                markView.backgroundColor = [UIColor colorWithHexString:@"00a9ff"];
                markView.tag = 11;
                markView.frame = CGRectMake(self.selectedBtn.frame.origin.x + self.selectedBtn.frame.size.width/2.0 - 14, 43.5, 28, 1.5);
                [cell.contentView addSubview:markView];
                
            }
            cell.separatorInset = UIEdgeInsetsMake(0, -50, 0, 0);
            return cell;
        }else{
            NSInteger type = self.selectedBtn.tag ;
            if (type == 0) {
                NSString *cellId = @"cell0";
                UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
                if (cell == nil) {
                    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellId];
                   
                }
                if (self.videoDict  && self.webView == nil) {
                    NSString *jScript = @"var meta = document.createElement('meta'); meta.setAttribute('name', 'viewport'); meta.setAttribute('content', 'width=device-width'); document.getElementsByTagName('head')[0].appendChild(meta);";
                    WKUserScript *wkUScript = [[WKUserScript alloc] initWithSource:jScript injectionTime:WKUserScriptInjectionTimeAtDocumentEnd forMainFrameOnly:YES];
                    WKUserContentController *wkUController = [[WKUserContentController alloc] init];
                    [wkUController addUserScript:wkUScript];
                    
                    WKWebViewConfiguration *wkWebConfig = [[WKWebViewConfiguration alloc] init];
                    wkWebConfig.userContentController = wkUController;
                    self.webView = [[WKWebView alloc] initWithFrame:CGRectMake(10, 10, MainScreenWidth - 20, MainScreenheight - 44 - kStatusBarHeight - 45 - 240 /750.0 * MainScreenWidth) configuration:wkWebConfig];
                    self.webView.scrollView.scrollEnabled = NO;
                    self.webView.scrollView.bounces = NO;
                    self.webView.scrollView.showsVerticalScrollIndicator = NO;
                    self.webView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
                    self.webView.navigationDelegate = self;
                    [cell.contentView addSubview:self.webView];
                    cell.accessoryType = UITableViewCellAccessoryNone;
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                    NSString *request =  [Utility htmlEntityDecode:[self.videoDict objectForKey:@"details"]];
                    // 加载网页
                    [self.webView loadHTMLString:request baseURL:nil];
                }
                
                return cell;
                
                
                
            }else if(type == 1){
                SelCourseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SelCourseTableViewCell"];
                if (cell == nil) {
                    [tableView registerNib:[UINib nibWithNibName:@"SelCourseTableViewCell" bundle:nil] forCellReuseIdentifier:@"SelCourseTableViewCell"];
                    cell = [tableView dequeueReusableCellWithIdentifier:@"SelCourseTableViewCell"];
                }
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
//                [cell loadCourseInfo:[self.courseList objectAtIndex:indexPath.row]];
                
                
                [cell loadCourseWithDetail:[self.courseList objectAtIndex:indexPath.row]];

                return cell;
            }else{
                static NSString *cellId = @"SelCourseCommentTableViewCell";
                SelCourseCommentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
                if (cell == nil) {
                    cell = [[SelCourseCommentTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellId];
                    
                }
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                NSDictionary *dict = @{@"content":@"去几千几万了阿胶了7⃣️文件7⃣️文件额请我看了饥饿离开家去玩了句我起来看饥饿精力看见；离开家离开家了句了"};
                [cell loadComment:dict];
                
                return cell;
            }
            
          
        }
      
    }
    
    return nil;
}



#pragma mark - WKNavigationDelegate
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    
        [webView evaluateJavaScript:@"document.body.offsetHeight" completionHandler:^(id _Nullable result, NSError * _Nullable error) {
            // 计算webView高度
            self.webViewCellHeight = [result doubleValue] + 20;
            // 刷新tableView
            [self->myTableView reloadData];
        }];
        
   
}
#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    // 判断webView所在的cell是否可见，如果可见就layout
//    if (scrollView == self.webView.scrollView) {
//        [self.webView setNeedsLayout];
//
//    }
//
    
}


-(void)clickItem:(UIButton *)btn{
    self.selectedBtn.selected = NO;
    self.selectedBtn = btn;
    self.selectedBtn.selected = YES;
    markView.frame = CGRectMake(self.selectedBtn.frame.origin.x + self.selectedBtn.frame.size.width/2.0 - 14, 43.5, 28, 1.5);
    
    NSInteger type = self.selectedBtn.tag ;
    
    if (type == 0) {
        [myTableView reloadData];
    }else if(type == 1){
        [self requestCatalogue];
        
    }
}




-(void)requestCatalogue{
    NSString *url = [NSString stringWithFormat:@"%@%@",ProxyUrl,kRequest_catalogue_list];
    NSDictionary *dict = @{@"course.id":[self.videoDict objectForKey:@"id"]};
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    WS(weakSelf);
    [[NetworkManager shareNetworkingManager] requestWithMethod:@"GET" headParameter:nil bodyParameter:dict relativePath:url success:^(id responseObject) {
        NSLog(@"视频目录%@",responseObject);
        [weakSelf loadCatalogue:responseObject];
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
    } failure:^(NSString *errorMsg) {
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        [Toast showWithText:errorMsg];
        
    }];
    
}


-(void)loadCatalogue:(NSArray *)array{
    self.courseList = [NSArray arrayWithArray:array];
    [myTableView reloadData];
}


















@end
