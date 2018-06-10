//
//  SettingTableViewController.m
//  ZJPlatform
//
//  Created by fengke on 2018/4/6.
//  Copyright © 2018年 wzsd. All rights reserved.
//

#import "SettingTableViewController.h"

@interface SettingTableViewController ()
{
    
    UISwitch *mySwitch1;
    UISwitch *mySwitch2;

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
        label.text = @"下载设置";
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

    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 2;
    }else if(section == 1){
        return 1;
    }else{
        return 6;
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



-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
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
    
    
    if (section == 0) {
        if (row == 0) {
            cell.textLabel.text = @"已下载";
        }else{
            cell.textLabel.text = @"仅在WIFI模式下载";
            cell.accessoryType = UITableViewCellAccessoryNone;
       
//            if (mySwitch1 == nil) {
//                mySwitch1 =  [[UISwitch alloc] initWithFrame:CGRectMake(MainScreenWidth - 70, 4, 100, 28)];
//                [mySwitch1 addTarget:self action:@selector(updateSwitchAtIndexPath:) forControlEvents:UIControlEventValueChanged];
//                if ([Utility getObjectForkey:WIFI_DOWNLOAD] &&
//                    [[Utility getObjectForkey:WIFI_DOWNLOAD] boolValue] == NO){
//                    mySwitch1.on = NO;
//                }else{
//                    mySwitch1.on = YES;
//                }
//                [cell.contentView addSubview:mySwitch1];
//            }
        }
    }else if(section == 1){
        cell.textLabel.text = @"仅在WIFI模式播放";
        cell.accessoryType = UITableViewCellAccessoryNone;
        if (mySwitch2 == nil) {
            mySwitch2 =  [[UISwitch alloc] initWithFrame:CGRectMake(MainScreenWidth - 70, 4, 100, 28)];
            [mySwitch2 addTarget:self action:@selector(updateSwitchAtIndexPath:) forControlEvents:UIControlEventValueChanged];
            if ([Utility objectForKey:WIFI_PLAY] &&
                [[Utility objectForKey:WIFI_PLAY] boolValue] == NO){
                mySwitch2.on = NO;
            }else{
                mySwitch2.on = YES;
            }
            [cell.contentView addSubview:mySwitch2];
        }

    }else{
        if (row == 0) {
            cell.textLabel.text = @"联系客服";
        }else if(row == 1){
            cell.textLabel.text = @"关于我们";
        }else if(row == 2){
            cell.textLabel.text = @"分享应用";
        }else if(row == 3){
            cell.textLabel.text = @"给个好评";
        }else if(row == 4){
            cell.textLabel.text = @"清除缓存";
        }else if(row == 5){
            cell.textLabel.text = @"清除出书";
        }
        
    }
    
    
    return cell;
}




@end
