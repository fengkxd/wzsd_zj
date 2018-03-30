//
//  TeacherDetailViewController.m
//  ZJPlatform
//
//  Created by sostag on 2018/3/30.
//  Copyright © 2018年 wzsd. All rights reserved.
//

#define UILABEL_LINE_SPACE 7

#import "TeacherDetailViewController.h"

@interface TeacherDetailViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *myTableView;
    UIView *sectionView;
    
    UIView *markView;
}


@property (nonatomic,assign) UIButton *selectedBtn;
// 0:名师资料 1: 名师成就   2: 名师课堂

@end

@implementation TeacherDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, MainScreenWidth, MainScreenheight - 64 ) style:UITableViewStylePlain];
    myTableView.delegate = self;
    myTableView.dataSource = self;
    [self.view addSubview:myTableView];
    
    
    myTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [self createBackBtn];
 
    UIImageView *headImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, MainScreenWidth, 240 /750.0 * MainScreenWidth)];
    headImgView.image = [UIImage imageNamed:@"banenr.png"];
    myTableView.tableHeaderView = headImgView;
    
    
    
    
}

-(void)clickBtn:(UIButton *)btn{
    
    self.selectedBtn.selected = NO;
    self.selectedBtn = btn;
    self.selectedBtn.selected = YES;
    
    markView.frame = CGRectMake(self.selectedBtn.frame.origin.x + self.selectedBtn.frame.size.width/2.0 - 14, 43.5, 28, 1.5);
    
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (sectionView == nil) {
        sectionView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, MainScreenWidth, 45)];
        sectionView.backgroundColor = [UIColor whiteColor];
        
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 44, MainScreenWidth, 0.5)];
        line.backgroundColor = [UIColor colorWithHexString:@"cccccc"];
        [sectionView addSubview:line];
        CGFloat width = 80;
        CGFloat x = (MainScreenWidth - width * 3 - 30 *2) /2.0;
        for (int i = 0; i < 3 ; i++) {
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame = CGRectMake(x, 0, width, 45);
            if (i == 0) {
                [btn setTitle:@"名师资料" forState:UIControlStateNormal];
            }else if(i == 1){
                [btn setTitle:@"名师成就" forState:UIControlStateNormal];
            }else {
                [btn setTitle:@"名师课程" forState:UIControlStateNormal];
            }
            btn.titleLabel.font = Font_13;
            [btn setTitleColor:[UIColor colorWithHexString:@"444444"] forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor colorWithHexString:@"04a7fd"] forState:UIControlStateSelected];
            [sectionView addSubview:btn];
            x = x + width + 30;
            if (i == 0) {
                self.selectedBtn = btn;
                btn.selected = YES;
            }
            [btn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
            btn.tag = i;
        }
        markView = [[UIView alloc] initWithFrame:CGRectZero];
        markView.backgroundColor = MainBlueColor;
        markView.tag = 11;
        markView.frame = CGRectMake(self.selectedBtn.frame.origin.x + self.selectedBtn.frame.size.width/2.0 - 14, 43.5, 28, 1.5);
        [sectionView addSubview:markView];
        
        
    }
    return sectionView;
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 45;
    
}




-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger type = self.selectedBtn.tag;
    NSInteger row = indexPath.row;
    
    NSString *cellId = @"cell";
        
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellId];
        
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(10, 20, 0.5, 14)];
        view.backgroundColor = MainBlueColor;
        [cell.contentView addSubview:view];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(17, 0, 150, 54)];
        label.font = Font_14;
        label.textColor = MainBlueColor;
        [cell.contentView addSubview:label];
        label.tag =  11;

        
        UILabel *detailLabel =[[UILabel alloc] initWithFrame:CGRectMake(10, 45, MainScreenWidth - 20, 20)];
        detailLabel.tag = 22;
        detailLabel.font = Font_12;
        [detailLabel setTextColor:[UIColor colorWithHexString:@"656565"]];
        [cell.contentView addSubview:detailLabel];
        detailLabel.numberOfLines = 0;
        
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    UILabel *label = (UILabel *)[cell.contentView viewWithTag:11];
    if (type == 0) {
        if (row == 0) {
            label.text = @"名师简介";
        }else if(row == 1){
            label.text = @"教学特点";
        }else if(row == 2){
            label.text = @"教学理念";
        }
    }else{
        
        
    }
   
    
    UILabel *detailLabel = (UILabel *)[cell.contentView viewWithTag:22];
    NSString *text ;
    if (row == 0) {
        text = @"rfrewgerg而归而两个空间儿科感觉而干净了金融控股乐基儿老顾客金额利润高科技了惹我个人个人过";
    }else if(row == 1){
        text = @"我如果热火个人他会让他今天荣誉军人他已经有人调侃如同一颗容易推开人痛苦他也加入太阳镜儿童婴儿";
    }else if(row == 2){
        text = @"我如果热火个人他会让他如果芦荟胶客人管理计划未来科技果然好了剋为家人活过来看我和人刚看了就喝了五块如果哈伦裤饿我好人更快乐婴儿";
    }
    
    
    detailLabel.text = text;
    detailLabel.frame = CGRectMake(10, 45, MainScreenWidth - 20, [self getSpaceLabelHeight:text withFont:Font_12 withWidth:MainScreenWidth - 20 ] + 5);
    
    [self setLabelSpace:detailLabel withValue:text withFont:Font_12];
    
    return cell;
    
    
    
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger row = indexPath.row;
    NSString *text ;
    if (row == 0) {
        text = @"rfrewgerg而归而两个空间儿科感觉而干净了金融控股乐基儿老顾客金额利润高科技了惹我个人个人过";
    }else if(row == 1){
        text = @"我如果热火个人他会让他今天荣誉军人他已经有人调侃如同一颗容易推开人痛苦他也加入太阳镜儿童婴儿";
    }else if(row == 2){
        text = @"我如果热火个人他会让他如果芦荟胶客人管理计划未来科技果然好了剋为家人活过来看我和人刚看了就喝了五块如果哈伦裤饿我好人更快乐婴儿";
    }
   return  [self getSpaceLabelHeight:text withFont:Font_12 withWidth:MainScreenWidth - 20] + 68 + 5;
}



-(void)setLabelSpace:(UILabel*)label withValue:(NSString*)str withFont:(UIFont*)font {
    NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
    paraStyle.lineBreakMode = NSLineBreakByCharWrapping;
    paraStyle.alignment = NSTextAlignmentLeft;
    paraStyle.lineSpacing = UILABEL_LINE_SPACE; //设置行间距
    paraStyle.hyphenationFactor = 1.0;
    paraStyle.firstLineHeadIndent = 0.0;
    paraStyle.paragraphSpacingBefore = 0.0;
    paraStyle.headIndent = 0;
    paraStyle.tailIndent = 0;
    //设置字间距 NSKernAttributeName:@1.5f
    NSDictionary *dic = @{NSFontAttributeName:font, NSParagraphStyleAttributeName:paraStyle, NSKernAttributeName:@1.5f
                          };
    NSAttributedString *attributeStr = [[NSAttributedString alloc] initWithString:str attributes:dic];
    label.attributedText = attributeStr;
}


//计算UILabel的高度(带有行间距的情况)

-(CGFloat)getSpaceLabelHeight:(NSString*)str withFont:(UIFont*)font withWidth:(CGFloat)width {
    NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
    paraStyle.lineBreakMode = NSLineBreakByCharWrapping;
    paraStyle.alignment = NSTextAlignmentLeft;
    paraStyle.lineSpacing = UILABEL_LINE_SPACE;
    paraStyle.hyphenationFactor = 1.0;
    paraStyle.firstLineHeadIndent = 0.0;
    paraStyle.paragraphSpacingBefore = 0.0;
    paraStyle.headIndent = 0;
    paraStyle.tailIndent = 0;
    NSDictionary *dic = @{NSFontAttributeName:font, NSParagraphStyleAttributeName:paraStyle, NSKernAttributeName:@1.5f};
    CGSize size = [str boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size;
    return size.height;
}







@end
