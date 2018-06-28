//
//  MyDetailTableViewController.m
//  ZJPlatform
//
//  Created by fk on 2018/6/22.
//  Copyright © 2018年 wzsd. All rights reserved.
//

#import "MyDetailTableViewController.h"

@interface MyDetailTableViewController ()

@end

@implementation MyDetailTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitleView:@"个人中心"];
    [self createBackBtn];
    
}





#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 4;
    }
    return 4;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger section = indexPath.section;
    NSInteger row = indexPath.row;
    if (section == 0 && row == 0) {
        return 60;
    }
    return 40;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return nil;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section == 0) {
        return 10;
    }
    return 0;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger section = indexPath.section;
    NSInteger row = indexPath.row;
    static NSString *cellId = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellId];
        cell.textLabel.textColor = [UIColor colorWithHexString:@"444444"];
        cell.textLabel.font = Font_15;
        cell.detailTextLabel.textColor = [UIColor colorWithHexString:@"999999"];
        cell.detailTextLabel.font = Font_14;
        
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    cell.detailTextLabel.text = @"";
    if (section == 0) {
        if (row == 0) {
            cell.textLabel.text = @"头像";
        }else if(row == 1){
            cell.textLabel.text = @"用户名";
        }else if(row == 2){
            cell.textLabel.text = @"性别";
        }else if(row == 3){
            cell.textLabel.text = @"生日";
        }
        
        
    }else{
        
    
        
        
        
    }
    
    return cell;
}





@end
