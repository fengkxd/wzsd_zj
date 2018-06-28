//
//  MySelCourseViewController.m
//  ZJPlatform
//
//  Created by fengke on 2018/4/7.
//  Copyright © 2018年 wzsd. All rights reserved.
//

#import "MySelCourseViewController.h"
#import "MySelCourseTableViewCell.h"
#import "MySelCourseTableViewCell2.h"


@interface MySelCourseViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *myTableView;
    UIView *markView;

}

@property (nonatomic,strong) UIButton *selectedBtn;
@end

@implementation MySelCourseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithHexString:@"eeeeee"];
    [self createBackBtn];
    [self setTitleView:@"我的课程"];
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, MainScreenWidth, 45)];
    
    UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn1.frame = CGRectMake(0, 0, MainScreenWidth/2.0, 44);
    [btn1 setTitle:@"已开课课程" forState:UIControlStateNormal];
    [btn1 setTitleColor:MainBlueColor forState:UIControlStateSelected];
    [btn1 setTitleColor:[UIColor colorWithHexString:@"444444"] forState:UIControlStateNormal];
    btn1.titleLabel.font = Font_14;
    [btn1 setBackgroundColor:[UIColor whiteColor]];
    
    UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn2.frame = CGRectMake(MainScreenWidth/2.0, 0, MainScreenWidth/2.0, 44);
    [btn2 setTitle:@"未付费课程" forState:UIControlStateNormal];
    [btn2 setTitleColor:MainBlueColor forState:UIControlStateSelected];
    [btn2 setTitleColor:[UIColor colorWithHexString:@"444444"] forState:UIControlStateNormal];
    btn2.titleLabel.font = Font_14;
    [btn2 setBackgroundColor:[UIColor whiteColor]];

    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 44.5, MainScreenWidth, 0.5)];
    line.backgroundColor = [UIColor colorWithHexString:@"cccccc"];
    
    [view addSubview:btn1];
    [view addSubview:btn2];
    [view addSubview:line];
    btn1.tag = 0;
    btn2.tag = 1;
    [btn1 addTarget:self action:@selector(clickItem:) forControlEvents:UIControlEventTouchUpInside];
    [btn2 addTarget:self action:@selector(clickItem:) forControlEvents:UIControlEventTouchUpInside];

    [self.view addSubview:view];
    self.selectedBtn = btn1;
    self.selectedBtn.selected = YES;
    
    markView = [[UIView alloc] initWithFrame:CGRectMake(self.selectedBtn.frame.origin.x + self.selectedBtn.frame.size.width/2.0 - 14, 44, 28, 1.5)];
    markView.backgroundColor = MainBlueColor;
    markView.tag = 11;
    markView.frame = CGRectMake(self.selectedBtn.frame.origin.x + self.selectedBtn.frame.size.width/2.0 - 14, 43.5, 28, 1.5);
    [self.view addSubview:markView];
    
    
    myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 45, MainScreenWidth, MainScreenheight - 45) style:UITableViewStylePlain];
    myTableView.delegate = self;
    myTableView.dataSource = self;
    [self.view addSubview:myTableView];
    myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
}

-(void)clickItem:(UIButton *)btn{
    self.selectedBtn.selected = NO;
    
    self.selectedBtn = btn;
    self.selectedBtn.selected = YES;
    markView.frame = CGRectMake(self.selectedBtn.frame.origin.x + self.selectedBtn.frame.size.width/2.0 - 14, 43.5, 28, 1.5);

    [myTableView reloadData];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.selectedBtn.tag == 1) {
        static NSString *cellId = @"MySelCourseTableViewCell";
        MySelCourseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
        if (cell == nil) {
            [tableView registerNib:[UINib nibWithNibName:@"MySelCourseTableViewCell" bundle:nil] forCellReuseIdentifier:@"MySelCourseTableViewCell"];
            cell = [tableView dequeueReusableCellWithIdentifier:@"MySelCourseTableViewCell"];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.line.frame = CGRectMake(10, 130, MainScreenWidth - 20, 0.5);
            
            
        }
        
        [cell loadDetail:nil];
        return cell;
    }else{
        static NSString *cellId = @"MySelCourseTableViewCell2";
        MySelCourseTableViewCell2 *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
        if (cell == nil) {
            [tableView registerNib:[UINib nibWithNibName:@"MySelCourseTableViewCell2" bundle:nil] forCellReuseIdentifier:@"MySelCourseTableViewCell2"];
            cell = [tableView dequeueReusableCellWithIdentifier:@"MySelCourseTableViewCell2"];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.line.frame = CGRectMake(10, 130, MainScreenWidth - 20, 0.5);
            
            
        }

        
        
        return cell;
        
    }
  
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return nil;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 190;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (self.selectedBtn.tag == 0) {
        return 3;
    }
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}




@end
