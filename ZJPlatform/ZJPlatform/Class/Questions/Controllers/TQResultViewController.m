//
//  TQResultViewController.m
//  ZJPlatform
//
//  Created by fk on 2018/8/20.
//  Copyright © 2018年 wzsd. All rights reserved.
//

#import "TQResultViewController.h"

@interface TQResultViewController ()

@end

@implementation TQResultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitleView:@"考试结果"];
    [self createBackBtn];
    self.view.backgroundColor = [UIColor whiteColor];
    UILabel *sourceLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, MainScreenWidth, 50)];
    sourceLabel.font = Font(15);
    sourceLabel.textAlignment = NSTextAlignmentCenter;
    NSString *totalScore = [NSString stringWithFormat:@"%zi",[[self.rateDict objectForKey:@"totalScore"] integerValue]];
    NSString *str =  [NSString stringWithFormat:@"本次得分:%@分",totalScore];
    
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:str];
    [attrStr addAttribute:NSForegroundColorAttributeName
                    value:MainBlueColor
                    range:[str rangeOfString:totalScore]];
    [attrStr addAttribute:NSFontAttributeName
                    value:Font(15)
                    range:[str rangeOfString:str]];
    [attrStr addAttribute:NSFontAttributeName
                    value:Font(17)
                    range:[str rangeOfString:totalScore]];
    sourceLabel.attributedText = attrStr;
    [self.view addSubview:sourceLabel];
    
    NSDictionary *dict = [self.rateDict objectForKey:@"rate"] ;
    NSArray *allKeys = [dict allKeys];
    
    UIScrollView *myscorllView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 50, MainScreenWidth, 40 * [allKeys count])];
    myscorllView.backgroundColor = [UIColor whiteColor];
    CGFloat width1 = MainScreenWidth/2.0;
    CGFloat width2 = MainScreenWidth/6.0;
    CGFloat y = 0;
    CGFloat height = 0;
    CGFloat contentSize_W = 0;
    for (NSInteger i = 0; i < [allKeys count] + 1; i ++ ) {
        CGSize maximumLabelSize = CGSizeMake( width1, 9999);//labelsize的最大值
        UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(0, y, width1, 5)];
        NSString *key;
        if (i == 0) {
             label1.text = @"知识点名称";
        }else{
            key = allKeys[i - 1];
            label1.text = key;
        }

        label1.textColor = [UIColor colorWithHexString:@"333333"];
        label1.numberOfLines = 0;
        label1.font = Font(15);
        CGSize expectSize = [label1 sizeThatFits:maximumLabelSize];
        label1.frame = CGRectMake(0, y, width1, expectSize.height + 16);
        label1.textAlignment = NSTextAlignmentCenter;
        [myscorllView addSubview:label1];
        if (i % 2 == 0 ) {
            label1.backgroundColor = [UIColor colorWithHexString:@"F3F3F3"];
        }else{
            label1.backgroundColor = [UIColor whiteColor];
        }
        
        if ( i == 0) {
            NSArray *years = [[[dict allValues] lastObject] allKeys];
            for (NSInteger j = 0; j < [years count]; j++) {
                NSString *year = [NSString stringWithFormat:@"%zi年",[years[j] integerValue]];
                UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(width1 + j * width2, y, width2, expectSize.height + 16)];
                label.textColor = [UIColor colorWithHexString:@"333333"];
                label.numberOfLines = 0;
                label.textAlignment = NSTextAlignmentCenter;
                label.font = Font(15);
                label.text = year;
                [myscorllView addSubview:label];
                if (i % 2 == 0 ) {
                    label.backgroundColor = [UIColor colorWithHexString:@"F3F3F3"];
                }else{
                    label.backgroundColor = [UIColor whiteColor];
                }
            }
        }else{
            NSArray *years = [[[dict allValues] lastObject] allKeys];
            NSDictionary *values = [dict objectForKey:allKeys[i - 1]];
            for (NSInteger j = 0; j < [years count]; j++) {
                NSString *year = [NSString stringWithFormat:@"%zi",[[values objectForKey:years[j]] integerValue]];
                UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(width1 + j * width2, y, width2, expectSize.height + 16)];
                label.textColor = [UIColor colorWithHexString:@"333333"];
                label.numberOfLines = 0;
                label.textAlignment = NSTextAlignmentCenter;
                label.font = Font(15);
                label.text = year;
                [myscorllView addSubview:label];
                if (i % 2 == 0 ) {
                    label.backgroundColor = [UIColor colorWithHexString:@"F3F3F3"];
                }else{
                    label.backgroundColor = [UIColor whiteColor];
                }
            }
            contentSize_W =   width1 + width2 * [values count];
        }
        y = y + label1.frame.size.height;
        height = expectSize.height + 16;
    }
    myscorllView.frame = CGRectMake(0, 60, MainScreenWidth, y);
    myscorllView.contentSize = CGSizeMake(contentSize_W, y);
    [self.view addSubview:myscorllView];
}



@end
