//
//  QuestionsViewController.m
//  ZJPlatform
//
//  Created by fengke on 2018/3/22.
//  Copyright © 2018年 wzsd. All rights reserved.
//

#import "QuestionsViewController.h"
#import "TQHistoryViewController.h"
#import "TQDayViewController.h"
#import "TQItem.h"
#import "TQItem1.h"

@interface QuestionsViewController () <UITableViewDelegate,UITableViewDataSource>

@end

@implementation QuestionsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitleView:@"我的题库"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        
        return 300.0f;
        
    }else if (indexPath.section == 1){
        
        //750*281
        
        CGFloat h = (CGFloat)281/(CGFloat)750;
        
        return h*MainScreenWidth;
        
    }else{
        
        return 115.0f;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 0.1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 10;
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        
        static NSString *cellid1 = @"TQCell1";
       
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid1];
        
        if (cell == nil) {
           
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid1];
            
            __weak __typeof(self) weakself = self;
            
            TQItem *item1 = [[TQItem alloc] initWithTitle:@"历年真题" icon:@"TQ_item1.png" frame:CGRectMake(0, 0, MainScreenWidth/2, 150)];
            item1.itemCallBack = ^(NSString *title) {
                
                [weakself itemSelected:title];
            };
            
            TQItem *item2 = [[TQItem alloc] initWithTitle:@"全真模拟" icon:@"TQ_item2.png" frame:CGRectMake(MainScreenWidth/2, 0, MainScreenWidth/2, 150)];
            item2.itemCallBack = ^(NSString *title) {
                
                [weakself itemSelected:title];
            };
            
            TQItem *item3 = [[TQItem alloc] initWithTitle:@"每日一练" icon:@"TQ_item3.png" frame:CGRectMake(0, 150, MainScreenWidth/2, 150)];
            item3.itemCallBack = ^(NSString *title) {
                
                [weakself itemSelected:title];
            };
            
            TQItem *item4 = [[TQItem alloc] initWithTitle:@"巩固练习" icon:@"TQ_item4.png" frame:CGRectMake(MainScreenWidth/2, 150, MainScreenWidth/2, 150)];
            item4.itemCallBack = ^(NSString *title) {
                
                [weakself itemSelected:title];
            };
            
            
            [cell.contentView addSubview:item1];
            [cell.contentView addSubview:item2];
            [cell.contentView addSubview:item3];
            [cell.contentView addSubview:item4];
            
            UIView *hLine = [[UIView alloc] initWithFrame:CGRectMake(25, 150, MainScreenWidth - 50, 0.5)];
            hLine.backgroundColor = CTPUIColorFromRGB(0xDBDBDB);
            
            UIView *vLine = [[UIView alloc] initWithFrame:CGRectMake(MainScreenWidth/2, 25, 0.5, 250)];
            vLine.backgroundColor = CTPUIColorFromRGB(0xDBDBDB);
            
            [cell.contentView addSubview:hLine];
            [cell.contentView addSubview:vLine];
        }
        
        //cell.textLabel.text = @"1";
        
        return cell;
        
    }else if (indexPath.section == 1){
        
        static NSString *cellid2 = @"cell2";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid2];
        
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellid2];
            
             CGFloat h = (CGFloat)281/(CGFloat)750;
            
            UIImageView *imv = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, MainScreenWidth, h*MainScreenWidth)];
            imv.image = [UIImage imageNamed:@"TQ_gg.png"];
            
            [cell.contentView addSubview:imv];
        }
        
        
        return cell;
        
    }else{
        
        static NSString *cellid3 = @"cell3";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid3];
        
        if (cell == nil) {
           
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellid3];
            
            __weak __typeof(self) weakself = self;
            
            CGFloat width = MainScreenWidth/3;
            
            TQItem1 *item1 = [[TQItem1 alloc] initWithTitle:@"试题收藏" icon:@"TQ_item7.png" frame:CGRectMake(0, 0, width, 115)];
            item1.itemCallBack = ^(NSString *title) {
                
                [weakself item1Selected:title];
            };
            
            TQItem1 *item2 = [[TQItem1 alloc] initWithTitle:@"错题集" icon:@"TQ_item7.png" frame:CGRectMake(width, 0, width, 115)];
            item2.itemCallBack = ^(NSString *title) {
                
                [weakself item1Selected:title];
            };
            
            TQItem1 *item3 = [[TQItem1 alloc] initWithTitle:@"做题记录" icon:@"TQ_item7.png" frame:CGRectMake(width*2, 0, width, 115)];
            item3.itemCallBack = ^(NSString *title) {
                
                [weakself item1Selected:title];
            };
            
            [cell.contentView addSubview:item1];
            [cell.contentView addSubview:item2];
            [cell.contentView addSubview:item3];
        }
         
        return cell;
    }
}

#pragma mark - ItemAction

- (void)itemSelected:(NSString *)title{
    
    NSLog(@"%@",title);
    
    if ([title isEqualToString:@"历年真题"]) {
       
        TQHistoryViewController *historyVc = [[TQHistoryViewController alloc] initWithNibName:@"TQHistoryViewController" bundle:nil];
        
        [self.navigationController pushViewController:historyVc animated:YES];
    }else{
        
        TQDayViewController *dayVc = [[TQDayViewController alloc] initWithNibName:@"TQDayViewController" bundle:nil];
        
        [self.navigationController pushViewController:dayVc animated:YES];
        
    }
}

- (void)item1Selected:(NSString *)title{
    
    NSLog(@"%@",title);
}

@end
