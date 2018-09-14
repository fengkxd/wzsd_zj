//
//  MenuAlert.m
//  dragonlion
//
//  Created by fengke on 2018/8/12.
//  Copyright © 2018年 sostag. All rights reserved.
//

#import "MenuAlert.h"

@interface MenuAlert() <UITableViewDataSource, UITableViewDelegate>

@property(nonatomic, strong) UITableView * tableView;

@end

@implementation MenuAlert


-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:CGRectMake(0, 0, MainScreenWidth, MainScreenheight)]) {
        UIButton *btnBg = [[UIButton alloc] initWithFrame:CGRectMake(0, frame.origin.y + kStatusBarHeight + 44, MainScreenWidth, MainScreenheight)];
        [btnBg setBackgroundColor:[UIColor blackColor]];
        btnBg.alpha = 0.4;
        [btnBg addTarget:self action:@selector(hidden) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btnBg];
        self.defRow = NSNotFound;
        UITableView * tableView = [UITableView new];

        tableView.frame = CGRectMake(0, frame.origin.y + kStatusBarHeight + 44, frame.size.width, frame.size.height);
        [self addSubview:tableView];
        tableView.delegate = self;
        tableView.dataSource = self;
        self.tableView = tableView;
    }
    return self;
}


-(void)show{
    [[[UIApplication sharedApplication] keyWindow] addSubview:self];
    self.hidden = NO;
}
-(void)hidden{
    self.dismissCallback();
    self.hidden = YES;
}


-(instancetype)init{
    if (self = [super init]) {
    }
    return self;
}

-(void)setTabColor:(UIColor *)tabColor{
    _tabColor = tabColor;
    self.tableView.backgroundColor = tabColor;
}

//-(instancetype)initWithCoder:(NSCoder *)aDecoder{
//    if (self = [super initWithCoder:aDecoder]) {
//        [self initUI];
//    }
//    return self;
//}



-(void)setArrMDataSource:(NSMutableArray *)arrMDataSource{
    _arrMDataSource = arrMDataSource;
    [_tableView reloadData];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:self.defRow inSection:0]];
    UILabel *label = (UILabel *)[cell.contentView viewWithTag:1];
    label.textColor = _txtColor ? _txtColor : [UIColor blackColor];
    
    UITableViewCell *selcell = [tableView cellForRowAtIndexPath:indexPath];
    UILabel *label2 = (UILabel *)[selcell.contentView viewWithTag:1];
    label2.textColor = MainBlueColor;
    self.defRow = indexPath.row;
    [self hidden];
    if (self.didSelectedCallback) {
        self.didSelectedCallback(indexPath.row, _arrMDataSource[indexPath.row]);
    }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _arrMDataSource.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *cellId = @"cellid";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellId];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, MainScreenWidth,44)];
        label.tag = 1;
        label.textAlignment = NSTextAlignmentCenter;
        [cell.contentView addSubview:label];
    }
    UILabel *label = (UILabel *)[cell.contentView viewWithTag:1];
    label.text = _arrMDataSource[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
     cell.contentView.backgroundColor = self.tabColor;
    label.backgroundColor = self.tabColor;
    label.font = _cusFont ? _cusFont : Font(15);
    if (self.defRow == indexPath.row) {
        label.textColor = MainBlueColor;
    }else{
        label.textColor = _txtColor ? _txtColor : [UIColor blackColor];
    }
    return cell;
}

// 以下适配iOS11+
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.1;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return nil;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return nil;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}



@end
