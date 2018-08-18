//
//  MyWebViewController.m
//  dragonlion
//
//  Created by sostag on 2017/6/8.
//  Copyright © 2017年 sostag. All rights reserved.
//


#import "MyWebViewController.h"
#import "MBProgressHUD.h"

@interface MyWebViewController ()<UIWebViewDelegate>
{
    UIWebView *myWebView;
}

@property (nonatomic,strong) NSString *htmlStr;
@property (nonatomic,strong) NSString *webTitle;
@end

@implementation MyWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createBackBtn];
    if (myWebView == nil) {
        myWebView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, MainScreenWidth, MainScreenheight  - 44 - kStatusBarHeight)];
        myWebView.delegate = self;
        myWebView.scalesPageToFit = YES;
        [self.view addSubview:myWebView];
        
 
    }
    
    [self.navigationController setNavigationBarHidden:NO];
}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self.navigationController setNavigationBarHidden:NO];
    
}








-(void)goBack{
    [self  goBack:nil];
}

-(void)loadHtmlStr:(NSString *)str{
    NSLog(@"加载Html：%@",str);
    self.htmlStr = str;
    if ([Utility isBlank:str]) {
        return;
    }
    if (myWebView == nil) {
        myWebView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, MainScreenWidth, MainScreenheight - 44 - kStatusBarHeight  )];
        myWebView.delegate = self;
        myWebView.scalesPageToFit = NO;
        [self.view addSubview:myWebView];
    }
    
//    [myWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
    
    NSString *htmls = [NSString stringWithFormat:@"<html> \n"
                       "<head> \n"
                       "<style type=\"text/css\"> \n"
                       "body {font-size:15px;}\n"
                       "</style> \n"
                       "</head> \n"
                       "<body>"
                       "<script type='text/javascript'>"
                       "window.onload = function(){\n"
                       "var $img = document.getElementsByTagName('img');\n"
                       "for(var p in  $img){\n"
                       " $img[p].style.width = '100%%';\n"
                       "$img[p].style.height ='auto'\n"
                       "}\n"
                       "}"
                       "</script>%@"
                       "</body>"
                       "</html>",self.htmlStr];
    [myWebView loadHTMLString:htmls baseURL:nil];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
}


-(void)loadUrlStr:(NSString *)urlStr{
    NSLog(@"加载Url：%@",urlStr);
    
    if ([Utility isBlank:urlStr]) {
        return;
    }
    if (myWebView == nil) {
        myWebView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, MainScreenWidth, MainScreenheight - 44 - kStatusBarHeight  )];
        myWebView.delegate = self;
        myWebView.scalesPageToFit = NO;
        [self.view addSubview:myWebView];
    }
    
    [myWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]]];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
}


-(void)webViewDidStartLoad:(UIWebView *)webView{
}



//设置标题
-(void)setTitleView:(NSString *)title
{
    
    UILabel *labelTitle = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 210, 44)];
    labelTitle.text = title;
    [labelTitle setFont:[UIFont fontWithName:@"STXihei" size:18]];
    [labelTitle setTextColor:[UIColor whiteColor]];
    [labelTitle setTextAlignment:NSTextAlignmentCenter];
    [labelTitle setBackgroundColor:[UIColor clearColor]];
    self.navigationItem.titleView = labelTitle;
    self.webTitle = title;
    
}


-(void)webViewDidFinishLoad:(UIWebView *)webView{
 
    
    if (self.webTitle == nil) {
        [self setTitleView:[webView stringByEvaluatingJavaScriptFromString:@"document.title"]];
    }
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    
//    NSString *lJs2 = @"document.documentElement.innerText"; //根据标识符获取不同内容
//    NSString *lHtml2 = [webView stringByEvaluatingJavaScriptFromString:lJs2];
    
   
}

-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    
    //    [self setTitleView:[webView stringByEvaluatingJavaScriptFromString:@"document.title"]];
    //    [self performSelector:@selector(setTitleView:) withObject:[webView stringByEvaluatingJavaScriptFromString:@"document.title"] afterDelay:0.2];
    
    return YES;
}
@end
