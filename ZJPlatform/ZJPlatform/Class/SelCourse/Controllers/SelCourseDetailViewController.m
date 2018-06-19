//
//  SelCourseDetailViewController.m
//  ZJPlatform
//
//  Created by sostag on 2018/4/3.
//  Copyright © 2018年 wzsd. All rights reserved.
//

#import "SelCourseDetailViewController.h"
#import "SelCourseCommentTableViewCell.h"


@interface SelCourseDetailViewController ()<UITableViewDelegate,UITableViewDataSource>
{
//    MRVLCPlayer *player;
    CGFloat videoHeight;

    UITableView *myTableView;
    IBOutlet UITableViewCell *cell1;
    IBOutlet UITableViewCell *cell2;
    
    
    UIView *markView;

}
@property (nonatomic,strong) UIButton *selectedBtn;

@end

@implementation SelCourseDetailViewController


- (BOOL)prefersStatusBarHidden{
    return YES;
}



-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear: animated];
    [[UIApplication sharedApplication] setStatusBarHidden:YES];
}


-(void)initPlayer{
  
//    videoHeight = 520 /750.0 * MainScreenWidth;
//
//    if (player) {
//        [player stopPlay];
//        [player removeFromSuperview];
//        player =  nil;
//    }
//    player = [[MRVLCPlayer alloc] initWithFrame:CGRectMake(0, 0, MainScreenWidth, videoHeight)];
//    player.controlView.moreButton.selected = YES;
//
//
//
//    player.mediaURL =  [NSURL URLWithString:@""];
//    player.tag = 22;
//    [player showInView:self.view];
//    WS(weakSelf);
//    player.dismissBlock = ^{
//        [weakSelf stopPlayer];
//        [[UIApplication sharedApplication] setStatusBarHidden:NO];
//        [weakSelf.navigationController popViewControllerAnimated:YES];
//    };
//
//    player.moreBlock = ^{
//        [weakSelf showActionSheet];
//    };
//
//    player.updateWatchNumBlock = ^{
//        [weakSelf updateWatchNum];
//    };
    
    
}




-(void)showActionSheet{
    
//    MRVLCPlayer *VLCPlayer = (MRVLCPlayer *)[self.view viewWithTag:22];
//
//    if (self.curCourse.isCollect == 0) {
//        self.curCourse.isCollect = 1;
//        VLCPlayer.controlView.moreButton.selected = YES;
//
//    }else{
//        self.curCourse.isCollect = 0;
//        VLCPlayer.controlView.moreButton.selected = NO;
//
//    }
//    NSString *url = [NSString stringWithFormat:@"%@%@",ProxyUrl,kRequest_Related];
//    NetworkManager *networkManager = [NetworkManager shareNetworkingManager];
//    [networkManager cancelTask:url];
//    NSMutableDictionary *dict =[NSMutableDictionary dictionaryWithDictionary:@{@"data":@{@"classes":@"course",@"isRelated":[NSString stringWithFormat:@"%zi",self.curCourse.isCollect],@"id":self.curCourse.courseId,@"type":@"collect"}}];
//    WS(weakSelf);
//    [networkManager requestWithMethod:@"POST" headParameter:nil
//                        bodyParameter:dict
//                         relativePath:url success:^(id responseObject) {
//                             //  [weakSelf performSelector:@selector(showToast) withObject:nil afterDelay:0.5];
//                             if (weakSelf.curCourse.isCollect == 0) {
//                                 [Toast showWithText:@"取消收藏成功"];
//                             }else{
//                                 [Toast showWithText:@"收藏成功"];
//                             }
//                         } failure:^(NSString *errorMsg) {
//                         }];
    
    
}



-(void)updateWatchNum{
//    if (!isUpdate) {
//        isUpdate = YES;
//        NSString *url = [NSString stringWithFormat:@"%@%@",ProxyUrl,kURL_WatchNum];
//        [[NetworkManager shareNetworkingManager] requestWithMethod:@"POST"
//                                                     headParameter:nil
//                                                     bodyParameter:@{@"data":@{@"courseId":self.curCourse.courseId}}
//                                                      relativePath:url
//                                                           success:^(id responseObject) {
//                                                           } failure:^(NSString *errorMsg) {
//                                                           }];
//    }
}






-(void)stopPlayer{
   // [player stopPlay];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.backBarButtonItem = nil;
    self.navigationItem.leftBarButtonItem = nil;
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    }
    [self initPlayer];
    
    myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, videoHeight, MainScreenWidth, MainScreenheight - videoHeight) style:UITableViewStylePlain];
    myTableView.delegate = self;
    myTableView.dataSource = self;
    [self.view addSubview:myTableView];
    myTableView.tableFooterView = [UIView new];
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 0.1;
    }else if(section == 1){
        return 10;
    }
    return 10;
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section < 2) {
        return 1;
    }
    return 5;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    NSInteger section = indexPath.section;
    NSInteger row = indexPath.row;

    if (section == 0) {
        return 140;
    }else if(section == 1){
        return 102;
    }else if(section == 2 && row == 0){
        return 45;
    }
    
    
    NSDictionary *dict = @{@"content":@"去几千几万了阿胶了7⃣️文件7⃣️文件额请我看了饥饿离开家去玩了句我起来看饥饿精力看见；离开家离开家了句了"};
    NSString *content = [dict objectForKey:@"content"];
    
    CGFloat height = [Utility getSpaceLabelHeight:content withFont:Font_13 withWidth:MainScreenWidth - 85];

    return 38 + height + 10 + 15 + 10;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return nil;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger section = indexPath.section;
    NSInteger row = indexPath.row;
    if (section == 0) {
        return cell1;
    }else if(section == 1){
        return cell2;
    }else{
        if (row == 0) {
            static NSString *cellId = @"cellId";
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
            if (cell == nil) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellId];
                
                for (int i = 0; i < 2 ; i++) {
                    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
                    btn.frame = CGRectMake(i * MainScreenWidth/2.0, 0, MainScreenWidth/2.0, 44);
                    if (i == 0) {
                        [btn setTitle:@"课程详情" forState:UIControlStateNormal];
                        self.selectedBtn = btn;
                    }else{
                        [btn setTitle:@"课程评论" forState:UIControlStateNormal];
                    }
                    btn.titleLabel.font = Font_13;
                    [btn setTitleColor:[UIColor colorWithHexString:@"444444"] forState:UIControlStateNormal];
                    [btn setTitleColor:[UIColor colorWithHexString:@"04a7fd"] forState:UIControlStateSelected];
                    [btn addTarget:self action:@selector(clickItem:) forControlEvents:UIControlEventTouchUpInside];
                    [cell.contentView addSubview:btn];
                }
                
                markView = [[UIView alloc] initWithFrame:CGRectZero];
                markView.backgroundColor = [UIColor colorWithHexString:@"00a9ff"];
                markView.tag = 11;
                markView.frame = CGRectMake(self.selectedBtn.frame.origin.x + self.selectedBtn.frame.size.width/2.0 - 14, 43.5, 28, 1.5);
                [cell.contentView addSubview:markView];
                
            }
            cell.separatorInset = UIEdgeInsetsMake(0, -50, 0, 0);
            return cell;
        }else{
            
            static NSString *cellId = @"SelCourseCommentTableViewCell";
            SelCourseCommentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
            if (cell == nil) {
                cell = [[SelCourseCommentTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellId];
                
                
                
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            NSDictionary *dict = @{@"content":@"去几千几万了阿胶了7⃣️文件7⃣️文件额请我看了饥饿离开家去玩了句我起来看饥饿精力看见；离开家离开家了句了"};
            [cell loadComment:dict];
            
            return cell;
        }
      
    }
    
    return nil;
}



-(void)clickItem:(UIButton *)btn{

    self.selectedBtn.selected = NO;
    self.selectedBtn = btn;
    self.selectedBtn.selected = YES;
    
    markView.frame = CGRectMake(self.selectedBtn.frame.origin.x + self.selectedBtn.frame.size.width/2.0 - 14, 43.5, 28, 1.5);
    
    
}


























@end
