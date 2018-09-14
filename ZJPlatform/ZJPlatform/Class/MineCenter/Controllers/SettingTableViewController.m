//
//  SettingTableViewController.m
//  ZJPlatform
//
//  Created by fengke on 2018/4/6.
//  Copyright © 2018年 wzsd. All rights reserved.
//

#import "SettingTableViewController.h"
#import "AboutViewController.h"

@interface SettingTableViewController ()
{
    
    UISwitch *mySwitch;

}
@end

@implementation SettingTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createBackBtn];
    [self setTitleView:@"设置"];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Table view data source



-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, MainScreenWidth, 30)];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 100, 30)];
    label.textColor = [UIColor colorWithHexString:@"444444"];
    label.font =Font_12;
    [view addSubview:label];
    
    if (section == 0) {
        label.text = @"播放设置";
    }else if(section == 1){
        label.text = @"播放设置";
    }else if(section == 2){
        label.text = @"其他";
    }
    
    return view;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 30;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(section == 0){
        return 1;
    }else{
        return 4;
    }
}

- (IBAction)updateSwitchAtIndexPath:(id)sender {
    
    
//    UISwitch *switchView = (UISwitch *)sender;
//
//    if ([switchView isOn])
//    {
//        [Utility saveObject:@"1" withKey:WIFI_PLAY];
//    }
//    else
//    {
//        [Utility saveObject:@"0" withKey:WIFI_PLAY];
//
//
//    }
}


 -(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 40;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *cellId = @"cellId";
    NSInteger row = indexPath.row;
    NSInteger section = indexPath.section;
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellId];
        cell.textLabel.font = Font_14;
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    
    if(section == 0){
        cell.textLabel.text = @"仅在WIFI模式播放";
        cell.accessoryType = UITableViewCellAccessoryNone;
        if (mySwitch == nil) {
            mySwitch =  [[UISwitch alloc] initWithFrame:CGRectMake(MainScreenWidth - 70, 4, 100, 28)];
            [mySwitch addTarget:self action:@selector(updateSwitchAtIndexPath:) forControlEvents:UIControlEventValueChanged];
            if ([Utility objectForKey:WIFI_PLAY] &&
                [[Utility objectForKey:WIFI_PLAY] boolValue] == NO){
                mySwitch.on = NO;
            }else{
                mySwitch.on = YES;
            }
            [cell.contentView addSubview:mySwitch];
        }

    }else{
         if(row == 0){
            cell.textLabel.text = @"关于我们";
        }else if(row == 1){
            cell.textLabel.text = @"分享应用";
        }else if(row == 2){
            cell.textLabel.text = @"给个好评";
        }else if(row == 3){
            cell.textLabel.text = @"清除缓存";
        }
        
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger section = indexPath.section;
    NSInteger row = indexPath.row;
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (section == 0) {
        
    }else{
        if (row == 0) {
            AboutViewController *vc = [[AboutViewController alloc] initWithNibName:@"AboutViewController" bundle:nil];
            [self.navigationController pushViewController:vc animated:YES];
        }
        
    }
    
    
}



@end
