//
//  QuestionsViewController.m
//  ZJPlatform
//
//  Created by fengke on 2018/3/22.
//  Copyright © 2018年 wzsd. All rights reserved.
//

#import "QuestionsViewController.h"
#import "TQCell1.h"

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
       
        TQCell1 *cell = [tableView dequeueReusableCellWithIdentifier:cellid1];
        
        if (cell == nil) {
           
            cell = [[[NSBundle mainBundle] loadNibNamed:@"TQCell1" owner:self options:nil] lastObject];
            
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
            
            
        }
        
        cell.textLabel.text = @"2";
        
        return cell;
    }
}


@end
