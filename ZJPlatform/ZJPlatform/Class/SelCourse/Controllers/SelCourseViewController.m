//
//  SelCourseViewController.m
//  ZJPlatform
//
//  Created by fengke on 2018/3/22.
//  Copyright © 2018年 wzsd. All rights reserved.
//

#import "SelCourseViewController.h"

@interface SelCourseViewController ()
{
    
    
}
@end

@implementation SelCourseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitleView:@"在线选课"];
    [self initHeaderView];
    
}

-(void)initHeaderView{
    CGFloat width = MainScreenWidth / 3.0;
    
    for (NSInteger i = 0; i < 3; i++) {
        UIButton *btn = [UIButton  buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(i * width, 0, width, 45);
        if (i == 0) {
            [btn setTitle:@"科目" forState:UIControlStateNormal];
        }else if(i == 1){
            [btn setTitle:@"主讲老师" forState:UIControlStateNormal];
        }else {
            [btn setTitle:@"主讲老师" forState:UIControlStateNormal];
        }
        btn.titleLabel.font = Font_13;
        [btn setImage:[UIImage imageNamed:@"arrow_up2.png"] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"arrow_up3.png"] forState:UIControlStateSelected];
        [btn setBackgroundColor:[UIColor whiteColor]];
        [btn setTitleColor:[UIColor colorWithHexString:@"444444"] forState:UIControlStateNormal];

        [Utility changeImageTitleForBtn:btn];

        [self.view addSubview:btn];
        
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
