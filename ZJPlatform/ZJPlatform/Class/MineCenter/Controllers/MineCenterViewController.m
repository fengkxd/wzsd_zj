//
//  MineCenterViewController.m
//  ZJPlatform
//
//  Created by fengke on 2018/3/22.
//  Copyright © 2018年 wzsd. All rights reserved.
//

#import "MineCenterViewController.h"
#import "MineCenterHeaderView.h"

@interface MineCenterViewController ()

@end

@implementation MineCenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    MineCenterHeaderView *headerView = [[[NSBundle mainBundle] loadNibNamed:@"MineCenterHeaderView" owner:self options:nil] lastObject];
    self.tableView.tableHeaderView = headerView;
    
    headerView.sourceView.hidden = YES;
    headerView.nameLabel.hidden = YES;
    headerView.loginBtn.hidden = NO;
    
}



- (void)verticalImageAndTitle:(CGFloat)spacing withBtn:(UIButton *)btn
{
    btn.titleLabel.font = Font_15;
    CGSize imageSize = btn.imageView.frame.size;
    CGSize titleSize = btn.titleLabel.frame.size;
    CGSize size = CGSizeMake(320,2000); //设置一个行高上限
    NSDictionary *attribute = @{NSFontAttributeName: btn.titleLabel.font};
    CGSize textSize = [btn.titleLabel.text boundingRectWithSize:size options: NSStringDrawingTruncatesLastVisibleLine |NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attribute context:nil].size;
    
    
    CGSize frameSize = CGSizeMake(ceilf(textSize.width), ceilf(textSize.height));
    if (titleSize.width + 0.5 < frameSize.width) {
        titleSize.width = frameSize.width;
    }
    [btn setTitleColor:[Utility colorWithHexString:@"333333"] forState:UIControlStateNormal];
    CGFloat totalHeight = (imageSize.height + titleSize.height + spacing);
    btn.imageEdgeInsets = UIEdgeInsetsMake(- (totalHeight - imageSize.height), 0.0, 0.0, - titleSize.width);
    btn.titleEdgeInsets = UIEdgeInsetsMake(0, - imageSize.width, - (totalHeight - titleSize.height) - 10, 0);
    [btn setBackgroundColor:[UIColor whiteColor]];
}



-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}



-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    NSInteger section = indexPath.section;
    NSInteger row = indexPath.row;
    if (section == 0) {
        static NSString *cellid = @"cell1";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellid];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            CGFloat width =  MainScreenWidth /4.0;
            CGFloat h = 80;
            for (NSInteger i = 0; i < 4; i ++ ) {
                NSInteger column = i % 4;
                UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
                btn.frame = CGRectMake(column * width, row * h, width, h);
                [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                switch (i) {
                    case 0:
                        [btn setTitle:@"我的订单" forState:UIControlStateNormal];
                        break;
                    case 1:
                        [btn setTitle:@"我的课程" forState:UIControlStateNormal];
                        break;
                    case 2:
                        [btn setTitle:@"优惠券" forState:UIControlStateNormal];
                        break;
                    case 3:
                        [btn setTitle:@"积分" forState:UIControlStateNormal];
                        break;
                    default:
                        break;
                }
                [btn setImage:[UIImage imageNamed:[NSString stringWithFormat:@"mineIcon%zi.png",i+1]] forState:UIControlStateNormal];
                [cell.contentView addSubview:btn];
                [self verticalImageAndTitle:5 withBtn:btn];
                
            }
        }
        return cell;

    
    }else{
        static NSString *cellid = @"cell2";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellid];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            
            cell.textLabel.font = Font_14;
            cell.textLabel.textColor = [UIColor colorWithHexString:@"333333"];
        }
        if (section == 1) {
            if (row == 0) {
                 cell.textLabel.text = @"当前考试：一级建造师";
            }else if(row == 1){
                cell.textLabel.text = @"学习时间统计";
            }else if(row == 2){
                cell.textLabel.text = @"我的题库";
            }else if(row == 3){
                cell.textLabel.text = @"我的收藏";
            }else if(row == 4){
                cell.textLabel.text = @"我的社区";
            }else if(row == 5){
                cell.textLabel.text = @"我的分享";
            }
        }else{
            if (row == 0) {
                cell.textLabel.text = @"客服中心";
            }else if(row == 1){
                cell.textLabel.text = @"意见反馈";
            }
        }
        
        
        
        return cell;
    
    }
    
    
    return nil;
}






-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 0.1;
    }
    return 10;
}



-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 80;
    }
    return 50;
}



-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }else if(section == 1){
        return 6;
    }
    return 2;
}



-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}







@end
