//
//  MyCourseTableViewController.m
//  ZJPlatform
//
//  Created by sostag on 2018/4/2.
//  Copyright © 2018年 wzsd. All rights reserved.
//

#import "MyCourseTableViewController.h"
#import "MyLiveBroadcastViewController.h"
#import "MySelCourseViewController.h"

@interface MyCourseTableViewController ()

@end

@implementation MyCourseTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitleView:@"我的课程"];
    [self createBackBtn];
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
    NSInteger row = indexPath.row;
    static NSString *cellId = @"cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellId];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.textLabel.font = Font_14;
        cell.textLabel.textColor = [UIColor colorWithHexString:@"444444"];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
    }
    NSString *imgName = [NSString stringWithFormat:@"course_icon%zi.png",row + 1];
    cell.imageView.image = [UIImage imageNamed:imgName];
    if (row == 0) {
        cell.textLabel.text = @"我的课程";
    }else if(row == 1){
        cell.textLabel.text = @"我的直播课";
    }else if(row == 2){
        cell.textLabel.text = @"离线课程";
    }else if(row == 3){
        cell.textLabel.text = @"听课记录";
    }else if(row == 4){
        cell.textLabel.text = @"课程评价";
    }
    
    
    return cell;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return nil;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger row = indexPath.row;

    if ( row == 0) {        
        MySelCourseViewController *vc = [[MySelCourseViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }else if (row == 1) {
        MyLiveBroadcastViewController *vc = [[MyLiveBroadcastViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    
    
}


@end
