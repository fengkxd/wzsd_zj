//
//  HostViewController.m
//  ZJPlatform
//
//  Created by fengke on 2018/3/22.
//  Copyright © 2018年 wzsd. All rights reserved.
//

#import "HostViewController.h"
#import "HostBannerView.h"
#import "HostVideoView.h"
#import "HostCommendVideoView.h"
#import "HostFreeVideoView.h"
#import "HostInformationTableViewCell.h"

@interface HostViewController ()
{
    IBOutlet UITableViewCell *newscell;
    
}
@end

@implementation HostViewController

- (void)viewDidLoad {
    [super viewDidLoad];


    
    CGFloat bannerHeitght = 310 /750.0 * MainScreenWidth;

    
    HostBannerView *bannerView = [[HostBannerView alloc] initWithFrame:CGRectMake(0, 0, MainScreenWidth, bannerHeitght)];
    self.tableView.tableHeaderView = bannerView;
    
    
    
    
    
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, MainScreenWidth, bannerView.frame.size.height)];
    imgView.image = [UIImage imageNamed:@"banenr.png"];
    [bannerView addSubview:imgView];
    
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0 || section == 1) {
        return 5;
    }
    
    return 10;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}



-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 7;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 3 || section == 4 || section == 5) {
        return 3;
    }else if(section == 6){
        return 4;
    }
    
    return 1;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger section = indexPath.section;
    NSInteger row = indexPath.row;
    if (section == 0) {
        return 35;
    }else if(section == 1){
        return 190;
    }else if(section == 2){
        return 160.0 /750.0 * MainScreenWidth;
    }else if(section > 2 && row == 0){
        return 42;
    }else if(section == 3){
       return  230.0/346.0 * ( MainScreenWidth/2.0 - 15) + 87;
    }else if(section == 4){
        return 88;
    }else if(section == 5){
        return 180.0/346.0 * (MainScreenWidth/2.0 - 15)  + 50;
    }
    
    return 90;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger section = indexPath.section;
    NSInteger row = indexPath.row;
    if (section == 0) {
        return newscell;
    }else if(section == 1){
        static NSString *cellid = @"cell1";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellid];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            CGFloat width =  MainScreenWidth /4.0;
            CGFloat h = 85;
            for (NSInteger i = 0; i < 8; i ++ ) {
                NSInteger row  = i / 4;
                NSInteger column = i % 4;
                UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
                btn.frame = CGRectMake(column * width, row * h, width, h);
                [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                switch (i) {
                    case 0:
                        [btn setTitle:@"免费课程" forState:UIControlStateNormal];
                        break;
                    case 1:
                        [btn setTitle:@"直播课程" forState:UIControlStateNormal];
                        break;
                    case 2:
                        [btn setTitle:@"在线课程" forState:UIControlStateNormal];
                        break;
                    case 3:
                        [btn setTitle:@"名师团队" forState:UIControlStateNormal];
                        break;
                    case 4:
                        [btn setTitle:@"在线题库" forState:UIControlStateNormal];
                        break;
                    case 5:
                        [btn setTitle:@"学院社区" forState:UIControlStateNormal];
                        break;
                    case 6:
                        [btn setTitle:@"考试指南" forState:UIControlStateNormal];
                        break;

                    case 7:
                        [btn setTitle:@"备考资料" forState:UIControlStateNormal];
                        break;
                    default:
                        break;
                }
                [btn setImage:[UIImage imageNamed:[NSString stringWithFormat:@"HostIcon%zi.png",i+1]] forState:UIControlStateNormal];
                [cell.contentView addSubview:btn];
                [self verticalImageAndTitle:5 withBtn:btn];
                
            }
        }
        return cell;
    }else if(section == 2){
    
        static NSString *cellid = @"cell2";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellid];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, MainScreenWidth, 160.0 /750.0 * MainScreenWidth)];
            imgView.image = [UIImage imageNamed:@"centerBanner.png"];
            [cell.contentView addSubview:imgView];
            
        }
        return cell;
    }else if(row == 0 && section > 2){
        NSString *cellId = @"cell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellId];
            
            UIView *view = [[UIView alloc] initWithFrame:CGRectMake(10, 9.5, 0.5, 23)];
            view.backgroundColor = [UIColor colorWithHexString:@"11a2ec"];
            [cell.contentView addSubview:view];
            
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(17, 0, 150, 42)];
            label.textColor = [UIColor blackColor];
            label.font = TitleFont;
            label.textColor = [UIColor colorWithHexString:@"333333"];
            [cell.contentView addSubview:label];
            label.tag =  11;
            
            cell.detailTextLabel.text = @"更多";
            [cell.detailTextLabel setTextColor:[UIColor colorWithHexString:@"8e8e8e"]];
            cell.detailTextLabel.font = Font_15;
            cell.accessoryType = UITableViewCellAccessoryNone;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        UILabel *label = (UILabel *)[cell.contentView viewWithTag:11];
        if (section == 3) {
            label.text = @"限时免费";
        }else if(section == 4){
            label.text = @"推荐课程";
        }else if(section == 5){
            label.text = @"免费课程";
        }else{
            label.text = @"考试咨询";
        }
        return cell;
    }else if(section == 3){
        static NSString *cellId = @"cell3";
        
        CGFloat videoWidth = MainScreenWidth/2.0;
        CGFloat videoHeight =  230.0/346.0 * (MainScreenWidth/2.0 - 15)  + 87;
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];

        
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellId];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            NSInteger count = 2;
            for (NSInteger i = 0; i <count ; i++) {
                NSInteger column = i % 2;
                HostVideoView *videoView = [[HostVideoView alloc] initWithFrame:CGRectMake( videoWidth * column , 0, videoWidth, videoHeight)];
                [cell.contentView addSubview:videoView];
               
             //   [videoView loadVideo:[self.freelist objectAtIndex:i]];
                videoView.delegate = self;
            }
        }
//        [cell.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
      
        return cell;
  

    }else if(section == 4){
       
        HostCommendVideoView *cell = [tableView dequeueReusableCellWithIdentifier:@"HostCommendVideoView"];
        if (cell == nil) {
            [tableView registerNib:[UINib nibWithNibName:@"HostCommendVideoView" bundle:nil] forCellReuseIdentifier:@"HostCommendVideoView"];
            cell = [tableView dequeueReusableCellWithIdentifier:@"HostCommendVideoView"];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
//        [cell loadCourse:[self.dataSource objectAtIndex:indexPath.row - 1]];
        return cell;
    }else if(section == 5){
        static NSString *cellId = @"cell5";
        
        CGFloat videoWidth = MainScreenWidth/2.0;
        CGFloat videoHeight =  180.0/346.0 * (MainScreenWidth/2.0 - 15)  + 50;
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
        
        
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellId];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            NSInteger count = 2;
            for (NSInteger i = 0; i <count ; i++) {
                NSInteger column = i % 2;
                HostFreeVideoView *videoView = [[HostFreeVideoView alloc] initWithFrame:CGRectMake( videoWidth * column , 0, videoWidth, videoHeight)];
                [cell.contentView addSubview:videoView];
                
                //   [videoView loadVideo:[self.freelist objectAtIndex:i]];
                //videoView.delegate = self;
            }
        }
        //        [cell.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
        
        return cell;
        
        
    }
    
    HostInformationTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HostInformationTableViewCell"];
    if (cell == nil) {
        [tableView registerNib:[UINib nibWithNibName:@"HostInformationTableViewCell" bundle:nil] forCellReuseIdentifier:@"HostInformationTableViewCell"];
        cell = [tableView dequeueReusableCellWithIdentifier:@"HostInformationTableViewCell"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;

}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

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




@end
