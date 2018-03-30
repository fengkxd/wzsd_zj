//
//  TeacherListViewController.m
//  ZJPlatform
//
//  Created by sostag on 2018/3/30.
//  Copyright © 2018年 wzsd. All rights reserved.
//

#import "TeacherListViewController.h"
#import "TeacherListTableViewCell.h"
#import "TeacherDetailViewController.h"




@interface TeacherListViewController ()

@end

@implementation TeacherListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitleView:@"中教名师"];
    [self createBackBtn];
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    TeacherDetailViewController *vc = [[TeacherDetailViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}




-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 121;
}




-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TeacherListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TeacherListTableViewCell"];
    if (cell == nil) {
        [tableView registerNib:[UINib nibWithNibName:@"TeacherListTableViewCell" bundle:nil] forCellReuseIdentifier:@"TeacherListTableViewCell"];
        cell = [tableView dequeueReusableCellWithIdentifier:@"TeacherListTableViewCell"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}










@end
