//
//  BaseTableViewController.m
//  tea
//
//  Created by fengke on 16/2/21.
//  Copyright © 2016年 com.xhhc. All rights reserved.
//

#import "BaseTableViewController.h"

@interface BaseTableViewController ()

@end

@implementation BaseTableViewController


-(void)reload{
    [self.tableView reloadData];
}



- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.extendedLayoutIncludesOpaqueBars = NO;
    self.modalPresentationCapturesStatusBarAppearance = NO;
    
    self.navigationController.interactivePopGestureRecognizer.delegate = nil;
    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    self.navigationController.interactivePopGestureRecognizer.delaysTouchesBegan = YES;
    
    
    self.tableView.tableFooterView = [[UIView alloc] init];
    self.view.backgroundColor = BgColor;
    [self loadFeildView];
}


-(void)loadFeildView{
//    feildView = [[[NSBundle mainBundle] loadNibNamed:@"FeildView" owner:self options:nil] lastObject];
//    feildView.center = CGPointMake(self.view.center.x, self.view.center.y - 64 - 64);
//    [self.tableView addSubview:feildView];
//    feildView.hidden = YES;
}



-(void)endRefreshing{
    if (self.tableView.header.isRefreshing) {
        [self.tableView.header endRefreshing];
    }
    if (self.tableView.footer.isRefreshing) {
        [self.tableView.footer endRefreshing];
    }
    
}

-(void)beginRefreshing{
    if (!self.tableView.header.isRefreshing) {
        [self.tableView.header beginRefreshing];
    }
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}





-(void)repeatRequest{}


//设置标题
-(void)setTitleView:(NSString *)title
{
    UILabel *labelTitle = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 210, 44)];
    labelTitle.text = title;
    [labelTitle setFont:[UIFont fontWithName:@"SourceHanSansSC-Regular" size:18]];
    [labelTitle setTextColor:[UIColor whiteColor]];
    [labelTitle setTextAlignment:NSTextAlignmentCenter];
    [labelTitle setBackgroundColor:[UIColor clearColor]];
    self.navigationItem.titleView = labelTitle;
}



-(void)createRightWithTitle:(NSString *)title{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 40, 40);
    btn.titleLabel.font = TitleFont;
    if ([title hasSuffix:@".png"]) {
        [btn setImage:[UIImage imageNamed:title] forState:UIControlStateNormal];
        btn.imageEdgeInsets = UIEdgeInsetsMake(0, 20, 0, 0);
    }else{
        [btn setTitle:title forState:UIControlStateNormal];
    }
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(clickRightBtn) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
}



-(void)createLeftWithTitle:(NSString *)title{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 40, 40);
    btn.titleLabel.font = TitleFont;
    if ([title hasSuffix:@".png"]) {
        [btn setImage:[UIImage imageNamed:title] forState:UIControlStateNormal];
        btn.imageEdgeInsets = UIEdgeInsetsMake(0, -20, 0, 0);
    }else{
        [btn setTitle:title forState:UIControlStateNormal];
    }
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(clickLeftBtn) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
}


-(void)clickRightBtn{


}

//设置返回按钮
- (void)createBackBtn{
    
    UIImage *imgBack = [UIImage imageNamed:@"back.png"];
    UIButton *_backBtnView =[UIButton buttonWithType:UIButtonTypeCustom];
    
    _backBtnView.frame = CGRectMake(0, 2, 40, 40);
    
    [_backBtnView setImage:imgBack
                  forState:UIControlStateNormal];
    
    [_backBtnView addTarget:self action:@selector(goBack:) forControlEvents:UIControlEventTouchUpInside];
    
    _backBtnView.imageEdgeInsets = UIEdgeInsetsMake(0, -20, 0, 0);
    UIBarButtonItem *_backBtn = [[UIBarButtonItem alloc] initWithCustomView:_backBtnView];
    
    self.navigationItem.leftBarButtonItem = _backBtn;
}


-(void)goBack:(id)sender
{
    
    if (self.navigationController.presentingViewController && [self.navigationController.viewControllers count] == 1) {
        [self.navigationController dismissViewControllerAnimated:YES completion:nil];
        
    }else {
        [self.navigationController popViewControllerAnimated:YES];
        
    }
    
}


-(void)showAlert:(NSString *)text{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:text delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
    [alertView show];
}




#pragma mark - Table view data source


- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    [cell setSeparatorInset:UIEdgeInsetsZero];
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
    
}




- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
     return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
     return 0;
}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
