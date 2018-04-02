//
//  TQGGLXViewController.m
//  ZJPlatform
//
//  Created by Rongbo Li on 2018/4/2.
//  Copyright © 2018年 wzsd. All rights reserved.
//

#import "TQGGLXViewController.h"
#import "TQGGLXCell.h"

@interface TQGGLXViewController () <UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) NSArray *dataArray;

@end

@implementation TQGGLXViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.myTable.backgroundColor = [UIColor whiteColor];
    
    
    [self setTitleView:@"巩固练习"];
    [self createBackBtn];
}

- (void)setTableData{
    
    NSDictionary *dic1 = @{@"titile":@"法律法规",@"count":@"1234"};
    NSDictionary *dic2 = @{@"titile":@"法律法规",@"count":@"1234"};
    NSDictionary *dic3 = @{@"titile":@"法律法规",@"count":@"1234"};
    NSDictionary *dic4 = @{@"titile":@"法律法规",@"count":@"1234"};
    NSDictionary *dic5 = @{@"titile":@"法律法规",@"count":@"1234"};
    NSDictionary *dic6 = @{@"titile":@"法律法规",@"count":@"1234"};
    NSDictionary *dic7 = @{@"titile":@"法律法规",@"count":@"1234"};
    NSDictionary *dic8 = @{@"titile":@"法律法规",@"count":@"1234"};
    NSDictionary *dic9 = @{@"titile":@"法律法规",@"count":@"1234"};
    NSDictionary *dic10 = @{@"titile":@"法律法规",@"count":@"1234"};
    NSDictionary *dic11 = @{@"titile":@"法律法规",@"count":@"1234"};
    NSDictionary *dic12 = @{@"titile":@"法律法规",@"count":@"1234"};
    NSDictionary *dic13 = @{@"titile":@"法律法规",@"count":@"1234"};
    NSDictionary *dic14 = @{@"titile":@"法律法规",@"count":@"1234"};
    
    self.dataArray = [NSArray arrayWithObjects:dic1,dic2,dic3,dic4,dic5,dic6,dic7,dic8,dic9,dic10,dic11,dic12,dic13,dic14, nil];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 80.0f;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 10;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 10;
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 10;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellid = @"cell";
    
    TQGGLXCell *cell = (TQGGLXCell *)[tableView dequeueReusableCellWithIdentifier:cellid];
    
    if (cell == nil) {
        
        cell = [[[NSBundle mainBundle] loadNibNamed:@"TQGGLXCell" owner:self options:nil] lastObject];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    
    
    return cell;
}

@end
