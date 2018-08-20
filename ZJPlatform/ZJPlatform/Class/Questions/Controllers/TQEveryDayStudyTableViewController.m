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
{
    IBOutlet UITableViewCell *answerCell;
    IBOutlet UILabel *label1;
    IBOutlet UILabel *label2;
    IBOutlet UITextView *explainTextView;
    IBOutlet UITableViewCell *resultCell;
    BOOL isResult;
}

@property (nonatomic,strong) WKWebView *webView;
@property (nonatomic,assign) double webViewCellHeight;
@property (nonatomic,strong) NSDictionary *questionDict;


@end

@implementation TQEveryDayStudyTableViewController

-(void)viewDidLoad{
    [super viewDidLoad];
    self.selIndexPaths = [NSMutableArray array];
    self.view.backgroundColor = [UIColor whiteColor];
    isResult = NO;
    [self requestDataSource];
    [self createBackBtn];
    [self setTitleView:@"每日一练"];
    [self initBottomView];

}

-(void)requestDataSource{
    
    NSString *url = [NSString stringWithFormat:@"%@%@",ProxyUrl,kRequest_questions_everyDayStudy];
    WS(weakSelf);
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[NetworkManager shareNetworkingManager] requestWithMethod:@"GET" headParameter:nil bodyParameter:@{@"courseClassify.id":self.courseClassifyId} relativePath:url
                                                       success:^(id responseObject) {
                                                           [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
                                                            weakSelf.questionDict = responseObject;
                                                           [weakSelf initWebView];
                                                       } failure:^(NSString *errorMsg) {
                                                           [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
                                                           [Toast showWithText:errorMsg];
                                                           
                                                       }];
}



-(void)initBottomView{
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, MainScreenheight - kBottomHeight - 44 - kStatusBarHeight - 44, MainScreenWidth, 0.5)];
    line.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:line];
    
    CGFloat y = MainScreenheight - kBottomHeight - 44 - kStatusBarHeight - 44;
    UIButton *commitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [commitBtn setBackgroundColor:MainBlueColor];
    commitBtn.titleLabel.font = Font(15);
    commitBtn.frame = CGRectMake((MainScreenWidth - 120)/2.0, y +  4, 120, 35);
    [commitBtn setTitle:@"立即提交" forState:UIControlStateNormal];
    [self.view addSubview:commitBtn];
    [commitBtn addTarget:self action:@selector(commit) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake(MainScreenWidth/2.0 + 60, y + 4, MainScreenWidth/2.0 - 60, 35);
    [rightBtn setTitle:@"下题" forState:UIControlStateNormal];
    [rightBtn setImage:[UIImage imageNamed:@"arrow_right"] forState:UIControlStateNormal];
    [self verticalImageAndTitle:0 withBtn:rightBtn];
    [self.view addSubview:rightBtn];
    
    
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBtn.frame = CGRectMake(0, y + 4, MainScreenWidth/2.0 - 60, 35);
    [leftBtn setTitle:@"上题" forState:UIControlStateNormal];
    [leftBtn setImage:[Utility image:[UIImage imageNamed:@"arrow_right"] rotation:UIImageOrientationDown] forState:UIControlStateNormal];
    [self verticalImageAndTitle:0 withBtn:leftBtn];
    [self.view addSubview:leftBtn];
    
 }


- (void)verticalImageAndTitle:(CGFloat)spacing withBtn:(UIButton *)btn
{
    btn.titleLabel.font = Font_13;
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
    btn.titleEdgeInsets = UIEdgeInsetsMake(0, - imageSize.width, - (totalHeight - titleSize.height) - 5, 0);
    [btn setBackgroundColor:[UIColor whiteColor]];
}




-(void)initWebView{
    NSString *jScript = @"var meta = document.createElement('meta'); meta.setAttribute('name', 'viewport'); meta.setAttribute('content', 'width=device-width'); document.getElementsByTagName('head')[0].appendChild(meta);";
    WKUserScript *wkUScript = [[WKUserScript alloc] initWithSource:jScript injectionTime:WKUserScriptInjectionTimeAtDocumentEnd forMainFrameOnly:YES];
    WKUserContentController *wkUController = [[WKUserContentController alloc] init];
    [wkUController addUserScript:wkUScript];

    WKWebViewConfiguration *wkWebConfig = [[WKWebViewConfiguration alloc] init];
    wkWebConfig.userContentController = wkUController;

    self.webView = [[WKWebView alloc] initWithFrame:CGRectMake(10, 10, MainScreenWidth - 20, 10) configuration:wkWebConfig];
    NSString *content = [self.questionDict objectForKey:@"question"];
    NSString *string = [Utility htmlEntityDecode:content];
    // 加载网页
    [self.webView loadHTMLString:string baseURL:nil];
    self.webView.scrollView.scrollEnabled = NO;
    self.webView.scrollView.bounces = NO;
    self.webView.scrollView.showsVerticalScrollIndicator = NO;
    self.webView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    self.webView.navigationDelegate = self;
}



-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger row =indexPath.row;
    NSInteger pageType = [[self.questionDict objectForKey:@"pageType"] integerValue];

    if (row < 2) {
        NSString *cellId = @"cell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellId];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        cell.textLabel.font = Font(13);
        cell.detailTextLabel.font = Font(13);
        cell.textLabel.numberOfLines = 0;
        cell.textLabel.text = @"";
        cell.detailTextLabel.attributedText = nil;

        cell.imageView.image = nil;
        if (row == 0) {
            cell.imageView.image = [UIImage imageNamed:@"test.png"];
            if(pageType == 1){
                cell.textLabel.text = @"单选题";
            }else if(pageType == 2){
                cell.textLabel.text = @"多选题";
            }else{
                cell.textLabel.text = @"问答题";
            }
            NSString *str = @"1/1";
            NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:str];
            [attrStr addAttribute:NSForegroundColorAttributeName
                            value:MainBlueColor
                            range:[str rangeOfString:@"1"]];
            cell.detailTextLabel.attributedText = attrStr;
        }else if(row == 1){
            cell.contentView.clipsToBounds = YES;
            cell.clipsToBounds = YES;
            [cell.contentView addSubview:self.webView];
        }

        return cell;
    }
    if (pageType < 3){
        if (row < 2 + [[self.questionDict objectForKey:@"resultList"] count] ) {
            static NSString *cellid = @"TQResultCell";
            TQResultCell *cell = (TQResultCell *)[tableView dequeueReusableCellWithIdentifier:cellid];
            if (cell == nil) {
                cell = [[TQResultCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellid];
            }
            NSArray *array = [self.questionDict  objectForKey:@"resultList"];
            [cell loadEveryDayStudy:[array objectAtIndex:indexPath.row -2]];
            
            if (isResult) {
                [cell loadReuslt:[array objectAtIndex:indexPath.row -2]];
            }
            
            return cell;
        }
    }
    if (row == 2 + [[self.questionDict objectForKey:@"resultList"] count]) {
        return answerCell;
    }
    return resultCell;

}



-(void)commit{
    
    if (isResult) {
        return;
    }
 
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"确定要交卷吗？" preferredStyle:UIAlertControllerStyleAlert];
    //创建提示按钮
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self updateAnswer];
    //    [self checkAnswer];
    }];
    
    [alertController addAction:action1];
    [alertController addAction:action2];
    [self presentViewController:alertController animated:YES completion:nil];
}


-(void)updateAnswer{
    NSArray *array = [self.questionDict objectForKey:@"resultList"];
    
    NSMutableString *str = [NSMutableString string];
    for (NSIndexPath *indexPath in self.selIndexPaths) {
        NSDictionary *dict = [array objectAtIndex:indexPath.row - 2];
        [str appendFormat:@"%@,",[dict objectForKey:@"checkValue"]];
    }
    NSRange deleteRange = { [str length] - 1, 1 };
    [str deleteCharactersInRange:deleteRange];
    NSDictionary *answer =@{@"id":[self.questionDict objectForKey:@"id"],@"answer":str,@"questions.id":[[[self.questionDict objectForKey:@"everydayPractise"] objectForKey:@"questions"] objectForKey:@"id"]};
    
    NSString *url = [NSString stringWithFormat:@"%@%@",ProxyUrl,kRequest_everydayPractise_updateupdateAnswer];
    WS(weakSelf);
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[NetworkManager shareNetworkingManager] requestWithMethod:@"POST" headParameter:nil bodyParameter:answer relativePath:url
                                                       success:^(id responseObject) {
                                                           [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
                                                           NSLog(@"%@",responseObject);
                                                           [weakSelf checkAnswer];
                                                       } failure:^(NSString *errorMsg) {
                                                         [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
                                                        //   [Toast showWithText:errorMsg];
                                                           [weakSelf checkAnswer];
                                                       }];
    
    
}

-(void)checkAnswer{
    isResult = YES;
    NSArray *array = [self.questionDict objectForKey:@"resultList"];
    NSMutableArray *answerArray = [NSMutableArray array];
    for (NSIndexPath *indexPath in self.selIndexPaths) {
        NSDictionary *dict = [array objectAtIndex:indexPath.row - 2];
        [answerArray addObject:[dict objectForKey:@"checkValue"]];
    }
    NSArray *resultArray = [answerArray sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        NSComparisonResult result = [obj1 compare:obj2];
        return result == NSOrderedDescending; // 升序
    }];
    
    label1.text = [resultArray componentsJoinedByString:@","];
    label2.text = [self.questionDict objectForKey:@"rightAnswers"];
    NSString *explain = [self.questionDict objectForKey:@"explain"];
    if ([Utility isNotBlank:explain]) {
        explainTextView.text = explain;
    }else{
        explainTextView.text = @"无";
    }
    [self.tableView reloadData];
    
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (isResult) {
        return;
    }
    NSInteger pageType = [[self.questionDict objectForKey:@"pageType"] integerValue];
    NSInteger row = indexPath.row;
    
    if (row >= 2 + [[self.questionDict objectForKey:@"resultList"] count] ) {
        return;
    }
    
    TQResultCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (pageType < 3) {
        if (row < 2) {
            return;
        }
        if ([self.selIndexPaths containsObject:indexPath]) {
            [cell setAnswer:NO];
            [self.selIndexPaths removeObject:indexPath];
        }else{
            if (pageType == 1) {
                NSIndexPath *oldIndexPath = [self.selIndexPaths lastObject];
                TQResultCell *oldCell = [tableView cellForRowAtIndexPath:oldIndexPath];
                [oldCell setAnswer:NO];
                [self.selIndexPaths removeObject:oldIndexPath];

                [cell setAnswer: YES];
                [self.selIndexPaths addObject:indexPath];
            }else{
                [cell setAnswer: YES];
                [self.selIndexPaths addObject:indexPath];
            }


        }
    }
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
    NSInteger pageType = [[self.questionDict  objectForKey:@"pageType"] integerValue];
    NSInteger row = indexPath.row;
    if (pageType < 3) {
        if (row == 2 + [[self.questionDict objectForKey:@"resultList"] count]) {
            return answerCell.frame.size.height;
        }else if(row == 2 + [[self.questionDict objectForKey:@"resultList"] count] + 1){
            return resultCell.frame.size.height;
        }
        if (indexPath.row == 0) {
            return 44;
        }else if (indexPath.row == 1) {
            return self.webViewCellHeight;
        }
        NSArray *array = [self.questionDict  objectForKey:@"resultList"];
        NSDictionary *dict = [array objectAtIndex:indexPath.row -2];
        NSString *content = [dict objectForKey:@"resultInro"];
        CGSize size = CGSizeMake(MainScreenWidth - 8 - 21 - 8 - 8,2000); //设置一个行高上限
        NSDictionary *attribute = @{NSFontAttributeName: Font(15)};
        CGFloat height = [content boundingRectWithSize:size options: NSStringDrawingTruncatesLastVisibleLine |NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attribute context:nil].size.height;

        height = height + 20;
    }
    
    return 44;
}

//#pragma mark - UIScrollViewDelegate
//- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
//    // 判断webView所在的cell是否可见，如果可见就layout
//    [self.webView setNeedsLayout];
//}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSInteger pageType = [[self.questionDict objectForKey:@"pageType"] integerValue];
    if (pageType < 3) {
        if (isResult) {
            return 2 + [[self.questionDict objectForKey:@"resultList"] count] + 2;
        }
        return 2 + [[self.questionDict objectForKey:@"resultList"] count];
    }
    return 2;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (self.webViewCellHeight == 0) {
        return 0;
    }
    return 1;
}

@end
