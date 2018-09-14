//
//  MyTQTableViewController.m
//  ZJPlatform
//
//  Created by fk on 2018/8/21.
//  Copyright © 2018年 wzsd. All rights reserved.
//

#import "MyTQTableViewController.h"
#import "TQErrorsViewController.h"
#import "TQMemberTableViewController.h"

@interface MyTQTableViewController ()

@end

@implementation MyTQTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createBackBtn];
    [self setTitleView:@"我的题库"];
}



#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
     return 2;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *cellId = @"cellId";
    NSInteger row = indexPath.row;
     UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellId];
        cell.textLabel.font = Font_14;
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    if(row == 0){
        cell.textLabel.text = @"我的错题集";
    }else if(row == 1){
        cell.textLabel.text = @"我的做题记录";
    }
        
 
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == 0) {
        TQErrorsViewController *vc = [[TQErrorsViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }else{
        TQMemberTableViewController *vc =[[TQMemberTableViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];

    }
    
}




@end
