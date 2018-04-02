//
//  CouponTableViewController.m
//  ZJPlatform
//
//  Created by sostag on 2018/4/2.
//  Copyright © 2018年 wzsd. All rights reserved.
//

#import "CouponTableViewController.h"
#import "CouponTableViewCell.h"

@interface CouponTableViewController ()

@end

@implementation CouponTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createBackBtn];
    [self setTitleView:@"优惠券"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
     return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
     return 5;
}

 - (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
     CouponTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CouponTableViewCell"];
     if (cell == nil) {
         [tableView registerNib:[UINib nibWithNibName:@"CouponTableViewCell" bundle:nil] forCellReuseIdentifier:@"CouponTableViewCell"];
         cell = [tableView dequeueReusableCellWithIdentifier:@"CouponTableViewCell"];
         cell.selectionStyle = UITableViewCellSelectionStyleNone;
      }
     cell.selectionStyle = UITableViewCellSelectionStyleNone;
     return cell;
}


-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, MainScreenWidth, 30)];
    view.backgroundColor = [UIColor colorWithHexString:@"eeeeee"];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, MainScreenWidth - 10, 30)];
    label.textColor = [Utility colorWithHexString:@"444444"];
    label.font = Font_13;
    NSString *content = @"你有1张优惠券可以使用";
    NSMutableAttributedString *AttributedStr = [[NSMutableAttributedString alloc]initWithString:content];
    [AttributedStr addAttribute:NSForegroundColorAttributeName
                          value:MainBlueColor
                          range:NSMakeRange(2, 2)];
    label.attributedText = AttributedStr;
    
    [view addSubview:label];
    return view;
}


-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForHeaderInSection:(NSInteger)section{
    return 30;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 85;
}



@end
