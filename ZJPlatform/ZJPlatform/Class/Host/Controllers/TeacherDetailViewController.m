//
//  TeacherDetailViewController.m
//  ZJPlatform
//
//  Created by sostag on 2018/3/30.
//  Copyright © 2018年 wzsd. All rights reserved.
//


#import "TeacherDetailViewController.h"
#import "TeacherVideoTableViewCell.h"
#import <WebKit/WebKit.h>

@interface TeacherDetailViewController ()<UITableViewDataSource,UITableViewDelegate,WKNavigationDelegate>
{
    UITableView *myTableView;
    UIView *sectionView;
    
    UIView *markView;
}
@property (nonatomic,strong) WKWebView *webView1;
@property (nonatomic,strong) WKWebView *webView2;

@property (nonatomic,assign) double webViewCellHeight1;
@property (nonatomic,assign) double webViewCellHeight2;

@property (nonatomic,assign) UIButton *selectedBtn;
// 0:名师资料 1: 名师成就   2: 名师课堂

@end

@implementation TeacherDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, MainScreenWidth, MainScreenheight - 64 ) style:UITableViewStylePlain];
    myTableView.delegate = self;
    myTableView.dataSource = self;
    [self.view addSubview:myTableView];
    
    
    myTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [self createBackBtn];
 
    UIImageView *headImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, MainScreenWidth, 240 /750.0 * MainScreenWidth)];
    headImgView.image = [UIImage imageNamed:@"banenr.png"];
    myTableView.tableHeaderView = headImgView;
    
    
    [self setTitleView:[self.teachDict objectForKey:@"name"]];
    
}

-(void)clickBtn:(UIButton *)btn{
    
    self.selectedBtn.selected = NO;
    self.selectedBtn = btn;
    self.selectedBtn.selected = YES;
    
    markView.frame = CGRectMake(self.selectedBtn.frame.origin.x + self.selectedBtn.frame.size.width/2.0 - 14, 43.5, 28, 1.5);
    
    [myTableView reloadData];
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (sectionView == nil) {
        sectionView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, MainScreenWidth, 45)];
        sectionView.backgroundColor = [UIColor whiteColor];
        
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 44, MainScreenWidth, 0.5)];
        line.backgroundColor = [UIColor colorWithHexString:@"cccccc"];
        [sectionView addSubview:line];
        CGFloat width = 80;
        CGFloat x = (MainScreenWidth - width * 3 - 30 *2) /2.0;
        for (int i = 0; i < 3 ; i++) {
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame = CGRectMake(x, 0, width, 45);
            if (i == 0) {
                [btn setTitle:@"名师资料" forState:UIControlStateNormal];
            }else if(i == 1){
                [btn setTitle:@"名师成就" forState:UIControlStateNormal];
            }else {
                [btn setTitle:@"名师课程" forState:UIControlStateNormal];
            }
            btn.titleLabel.font = Font_13;
            [btn setTitleColor:[UIColor colorWithHexString:@"444444"] forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor colorWithHexString:@"04a7fd"] forState:UIControlStateSelected];
            [sectionView addSubview:btn];
            x = x + width + 30;
            if (i == 0) {
                self.selectedBtn = btn;
                btn.selected = YES;
            }
            [btn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
            btn.tag = i;
        }
        markView = [[UIView alloc] initWithFrame:CGRectZero];
        markView.backgroundColor = MainBlueColor;
        markView.tag = 11;
        markView.frame = CGRectMake(self.selectedBtn.frame.origin.x + self.selectedBtn.frame.size.width/2.0 - 14, 43.5, 28, 1.5);
        [sectionView addSubview:markView];
        
        
    }
    return sectionView;
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 45;
    
}




-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger type = self.selectedBtn.tag;

    if (type == 0) {
        NSString *cellId = @"cell0";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellId];
            
            NSString *jScript = @"var meta = document.createElement('meta'); meta.setAttribute('name', 'viewport'); meta.setAttribute('content', 'width=device-width'); document.getElementsByTagName('head')[0].appendChild(meta);";
            WKUserScript *wkUScript = [[WKUserScript alloc] initWithSource:jScript injectionTime:WKUserScriptInjectionTimeAtDocumentEnd forMainFrameOnly:YES];
            WKUserContentController *wkUController = [[WKUserContentController alloc] init];
            [wkUController addUserScript:wkUScript];

            WKWebViewConfiguration *wkWebConfig = [[WKWebViewConfiguration alloc] init];
            wkWebConfig.userContentController = wkUController;
            self.webView1 = [[WKWebView alloc] initWithFrame:CGRectMake(10, 10, MainScreenWidth - 20, MainScreenheight - 64 - 45 - 240 /750.0 * MainScreenWidth) configuration:wkWebConfig];
            NSString *request =  [Utility htmlEntityDecode:[self.teachDict objectForKey:@"description"]];

            // 加载网页
            [self.webView1 loadHTMLString:request baseURL:nil];
            self.webView1.scrollView.scrollEnabled = NO;
            self.webView1.scrollView.bounces = NO;
            self.webView1.scrollView.showsVerticalScrollIndicator = NO;
            self.webView1.autoresizingMask = UIViewAutoresizingFlexibleHeight;
            self.webView1.navigationDelegate = self;

            [cell.contentView addSubview:self.webView1];
            
//            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, MainScreenWidth - 20, MainScreenheight - 64 - 45 - 240 /750.0 * MainScreenWidth)];
//            label.numberOfLines = 0;
//            label.text = [Utility htmlEntityDecode:[self.teachDict objectForKey:@"description"]];
//            [cell.contentView addSubview:label];
//
            cell.accessoryType = UITableViewCellAccessoryNone;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }

        return cell;
        

    }else if(type == 2){
        
        TeacherVideoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TeacherVideoTableViewCell"];
        if (cell == nil) {
            [tableView registerNib:[UINib nibWithNibName:@"TeacherVideoTableViewCell" bundle:nil] forCellReuseIdentifier:@"TeacherVideoTableViewCell"];
            cell = [tableView dequeueReusableCellWithIdentifier:@"TeacherVideoTableViewCell"];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else{
        NSString *cellId = @"cell1";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellId];
            NSString *jScript = @"var meta = document.createElement('meta'); meta.setAttribute('name', 'viewport'); meta.setAttribute('content', 'width=device-width'); document.getElementsByTagName('head')[0].appendChild(meta);";
            WKUserScript *wkUScript = [[WKUserScript alloc] initWithSource:jScript injectionTime:WKUserScriptInjectionTimeAtDocumentEnd forMainFrameOnly:YES];
            WKUserContentController *wkUController = [[WKUserContentController alloc] init];
            [wkUController addUserScript:wkUScript];
            
            WKWebViewConfiguration *wkWebConfig = [[WKWebViewConfiguration alloc] init];
            wkWebConfig.userContentController = wkUController;
            self.webView2 = [[WKWebView alloc] initWithFrame:CGRectMake(10, 10, MainScreenWidth - 20, MainScreenheight - 64 - 45 - 240 /750.0 * MainScreenWidth) configuration:wkWebConfig];
            NSString *request =  [Utility htmlEntityDecode:[self.teachDict objectForKey:@"honour"]];
            
            // 加载网页
            [self.webView2 loadHTMLString:request baseURL:nil];
            self.webView2.scrollView.scrollEnabled = NO;
            self.webView2.scrollView.bounces = NO;
            self.webView2.scrollView.showsVerticalScrollIndicator = NO;
            self.webView2.autoresizingMask = UIViewAutoresizingFlexibleHeight;
            self.webView2.navigationDelegate = self;
            
            [cell.contentView addSubview:self.webView2];
            
            cell.accessoryType = UITableViewCellAccessoryNone;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        
        
        return cell;
    }
}


#pragma mark - WKNavigationDelegate
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    if (webView == self.webView1) {
        [webView evaluateJavaScript:@"document.body.offsetHeight" completionHandler:^(id _Nullable result, NSError * _Nullable error) {
            // 计算webView高度
            self.webViewCellHeight1 = [result doubleValue] + 20;
            // 刷新tableView
            [self->myTableView reloadData];
        }];

    }else{
        if (webView == self.webView2) {
            [webView evaluateJavaScript:@"document.body.offsetHeight" completionHandler:^(id _Nullable result, NSError * _Nullable error) {
                // 计算webView高度
                self.webViewCellHeight2 = [result doubleValue] + 20;
                // 刷新tableView
                [self->myTableView reloadData];
            }];
            
        }

    }
}
#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    // 判断webView所在的cell是否可见，如果可见就layout
    if (scrollView == self.webView1.scrollView) {
        [self.webView1 setNeedsLayout];

    }else{
        [self.webView2 setNeedsLayout];

    }

}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (self.selectedBtn.tag < 2) {
        return 1;
    }
    return 3;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
     if (self.selectedBtn.tag == 0) {
//        return MainScreenheight - 64 - 45 - 240 /750.0 * MainScreenWidth;
         return self.webViewCellHeight1;
     }else if(self.selectedBtn.tag == 1){
//        return MainScreenheight - 64 - 45 - 240 /750.0 * MainScreenWidth;
         return self.webViewCellHeight2;
     }
    
    
    return 92;
}









@end
