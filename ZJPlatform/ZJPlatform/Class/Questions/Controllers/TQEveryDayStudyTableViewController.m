//
//  TQEveryDayStudyTableViewController.m
//  ZJPlatform
//
//  Created by fengke on 2018/8/19.
//  Copyright © 2018年 wzsd. All rights reserved.
//

#import "TQEveryDayStudyTableViewController.h"
#import <WebKit/WebKit.h>
#import "TQResultCell.h"

@interface TQEveryDayStudyTableViewController ()<WKNavigationDelegate>

@property (nonatomic,strong) WKWebView *webView;
@property (nonatomic,assign) double webViewCellHeight;

@end

@implementation TQEveryDayStudyTableViewController

-(void)viewDidLoad{
    [super viewDidLoad];
    self.selIndexPaths = [NSMutableArray array];
    self.view.backgroundColor = [UIColor whiteColor];
    [self requestDataSource];
    [self createBackBtn];
    [self setTitleView:@"每日一练"];
 //   [self initWebView];
}

-(void)requestDataSource{
    
    NSString *url = [NSString stringWithFormat:@"%@%@",ProxyUrl,kRequest_questions_everyDayStudy];
    WS(weakSelf);
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[NetworkManager shareNetworkingManager] requestWithMethod:@"GET" headParameter:nil bodyParameter:@{@"courseClassify.id":self.courseClassifyId} relativePath:url
                                                       success:^(id responseObject) {
                                                           [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
                                                           NSLog(@"%@",responseObject);
                                                       } failure:^(NSString *errorMsg) {
                                                           [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
                                                           [Toast showWithText:errorMsg];
                                                           
                                                       }];

}


-(void)initWebView{
//    NSString *jScript = @"var meta = document.createElement('meta'); meta.setAttribute('name', 'viewport'); meta.setAttribute('content', 'width=device-width'); document.getElementsByTagName('head')[0].appendChild(meta);";
//    WKUserScript *wkUScript = [[WKUserScript alloc] initWithSource:jScript injectionTime:WKUserScriptInjectionTimeAtDocumentEnd forMainFrameOnly:YES];
//    WKUserContentController *wkUController = [[WKUserContentController alloc] init];
//    [wkUController addUserScript:wkUScript];
//
//    WKWebViewConfiguration *wkWebConfig = [[WKWebViewConfiguration alloc] init];
//    wkWebConfig.userContentController = wkUController;
//
//
//    self.webView = [[WKWebView alloc] initWithFrame:CGRectMake(10, 10, MainScreenWidth - 20, 10) configuration:wkWebConfig];
//    NSString *content = [[self.question objectForKey:@"questions"] objectForKey:@"question"];
//    NSString *string = [Utility htmlEntityDecode:content];
//    // 加载网页
//    [self.webView loadHTMLString:string baseURL:nil];
//    self.webView.scrollView.scrollEnabled = NO;
//    self.webView.scrollView.bounces = NO;
//    self.webView.scrollView.showsVerticalScrollIndicator = NO;
//    self.webView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
//    self.webView.navigationDelegate = self;
}



-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger row =indexPath.row;
//    NSInteger pageType = [[[self.question objectForKey:@"questions"] objectForKey:@"pageType"] integerValue];
//
//    if (row < 2) {
//        NSString *cellId = @"cell";
//        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
//        if (cell == nil) {
//            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellId];
//            cell.selectionStyle = UITableViewCellSelectionStyleNone;
//        }
//        cell.textLabel.font = Font(13);
//        cell.detailTextLabel.font = Font(13);
//        cell.textLabel.numberOfLines = 0;
//        cell.textLabel.text = @"";
//        cell.detailTextLabel.attributedText = nil;
//
//        cell.imageView.image = nil;
//        NSInteger pageType = [[[self.question objectForKey:@"questions"] objectForKey:@"pageType"] integerValue];
//        if (row == 0) {
//            cell.imageView.image = [UIImage imageNamed:@"test.png"];
//            if(pageType == 1){
//                cell.textLabel.text = @"单选题";
//            }else if(pageType == 2){
//                cell.textLabel.text = @"多选题";
//            }else{
//                cell.textLabel.text = @"问答题";
//            }
//            NSString *str = [NSString stringWithFormat:@"%zi/%zi",self.curNum + 1,self.totalCount];
//            NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:str];
//            [attrStr addAttribute:NSForegroundColorAttributeName
//                            value:MainBlueColor
//                            range:[str rangeOfString:[NSString stringWithFormat:@"%zi",self.curNum + 1]]];
//            cell.detailTextLabel.attributedText = attrStr;
//        }else if(row == 1){
//            cell.contentView.clipsToBounds = YES;
//            cell.clipsToBounds = YES;
//            [cell.contentView addSubview:self.webView];
//        }
//
//        return cell;
//    }
//
//    if (pageType < 3){
//        static NSString *cellid = @"TQResultCell";
//        TQResultCell *cell = (TQResultCell *)[tableView dequeueReusableCellWithIdentifier:cellid];
//        if (cell == nil) {
//            cell = [[TQResultCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellid];
//        }
//        NSArray *array = [[self.question objectForKey:@"questions"] objectForKey:@"resultList"];
//        [cell loadInfo:[array objectAtIndex:indexPath.row -2]];
//
//        return cell;
//    }
    
    
    
    return nil;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
//    NSInteger pageType = [[[self.question objectForKey:@"questions"] objectForKey:@"pageType"] integerValue];
//    NSInteger row = indexPath.row;
//    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
//
//    if (pageType < 3) {
//        if (row < 2) {
//            return;
//        }
//        if ([self.selIndexPaths containsObject:indexPath]) {
//            [cell setSelected:NO];
//            [self.selIndexPaths removeObject:indexPath];
//        }else{
//            if (pageType == 1) {
//                NSIndexPath *oldIndexPath = [self.selIndexPaths lastObject];
//                UITableViewCell *oldCell = [tableView cellForRowAtIndexPath:oldIndexPath];
//                [oldCell setSelected:NO];
//                [self.selIndexPaths removeObject:oldIndexPath];
//
//                [cell setSelected: YES];
//                [self.selIndexPaths addObject:indexPath];
//            }else{
//                [cell setSelected: YES];
//                [self.selIndexPaths addObject:indexPath];
//            }
//
//
//        }
//    }
}


#pragma mark - WKNavigationDelegate
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    [webView evaluateJavaScript:@"document.body.offsetHeight" completionHandler:^(id _Nullable result, NSError * _Nullable error) {
        // 计算webView高度
        self.webViewCellHeight = [result doubleValue] + 20;
        self.webView.frame = CGRectMake(10, 5, MainScreenWidth - 20, [result doubleValue] + 10);
        
        // 刷新tableView
        [self.tableView reloadData];
    }];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    NSInteger pageType = [[[self.question objectForKey:@"questions"] objectForKey:@"pageType"] integerValue];
//    if (pageType < 3) {
//        if (indexPath.row == 0) {
//            return 44;
//        }else if (indexPath.row == 1) {
//            return self.webViewCellHeight;
//        }
//        NSArray *array = [[self.question objectForKey:@"questions"] objectForKey:@"resultList"];
//        NSDictionary *dict = [array objectAtIndex:indexPath.row -2];
//        NSString *content = [dict objectForKey:@"resultInro"];
//        CGSize size = CGSizeMake(MainScreenWidth - 8 - 21 - 8 - 8,2000); //设置一个行高上限
//        NSDictionary *attribute = @{NSFontAttributeName: Font(15)};
//        CGFloat height = [content boundingRectWithSize:size options: NSStringDrawingTruncatesLastVisibleLine |NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attribute context:nil].size.height;
//
//        height = height + 20;
//    }
    
    return 44;
}

//#pragma mark - UIScrollViewDelegate
//- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
//    // 判断webView所在的cell是否可见，如果可见就layout
//    [self.webView setNeedsLayout];
//}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
//    NSInteger pageType = [[[self.question objectForKey:@"questions"] objectForKey:@"pageType"] integerValue];
//    if (pageType < 3) {
//        return 2 + [[[self.question objectForKey:@"questions"] objectForKey:@"resultList"] count];
//    }
    return 2;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (self.webViewCellHeight == 0) {
        return 0;
    }
    return 1;
}

@end
