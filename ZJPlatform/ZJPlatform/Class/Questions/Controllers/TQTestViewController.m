//
//  TQTestViewController.m
//  ZJPlatform
//
//  Created by fk on 2018/8/18.
//  Copyright © 2018年 wzsd. All rights reserved.
//

#import "TQTestViewController.h"
#import "TQTestView.h"


@interface TQTestViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, UIScrollViewDelegate>

@property (nonatomic, strong) UICollectionView *mainCollection;

@property (nonatomic,strong) NSMutableArray *subVCs;

@property (nonatomic,strong) NSArray *dataSource;


@end

@implementation TQTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self requestDataSource];
    [self setMainCrollView];
}

-(void)requestDataSource{
    
    NSString *url = [NSString stringWithFormat:@"%@%@",ProxyUrl,kRequest_testPaper_get];
    WS(weakSelf);
    NSDictionary *dict =  @{@"id":self.testId};
    
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[NetworkManager shareNetworkingManager] requestWithMethod:@"GET" headParameter:nil bodyParameter:dict relativePath:url
                                                       success:^(id responseObject) {
                                                           [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
                                                           [weakSelf loadDataSource:responseObject];
                                                           
                                                       } failure:^(NSString *errorMsg) {
                                                           [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
                                                           [Toast showWithText:errorMsg];
                                                           
                                                       }];
}

-(void)loadDataSource:(NSDictionary *)dict{
    NSLog(@"题目列表%@",dict);
    
    
    
}


#pragma mark 左右滑动的collectionview
- (void)setMainCrollView {
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(MainScreenWidth, MainScreenheight -kStatusBarHeight - 44-kTabbarHeight-40);
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
    layout.sectionInset = UIEdgeInsetsZero;
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    self.mainCollection = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, MainScreenWidth, MainScreenheight -kStatusBarHeight - 44-kTabbarHeight-40) collectionViewLayout:layout];
    self.mainCollection.delegate = self;
    self.mainCollection.dataSource = self;
    self.mainCollection.showsHorizontalScrollIndicator = NO;
    self.mainCollection.pagingEnabled = YES;
    [self.mainCollection registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"UICollectionViewCellID1"];
    self.mainCollection.backgroundColor = [UIColor whiteColor];
}

#pragma mark collectionview  delegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.dataSource count];
    
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"UICollectionViewCellID1" forIndexPath:indexPath];
    TQTestView *subVC = self.subVCs[indexPath.row];
    subVC.frame = CGRectMake(0, 0, MainScreenWidth, MainScreenheight-kStatusBarHeight - 44  - 44 - kBottomHeight);
    subVC.frame = CGRectMake(0, 0, MainScreenWidth, MainScreenheight-kStatusBarHeight - 44  - 44 - kBottomHeight);
    [cell.contentView addSubview:subVC];
    cell.contentView.backgroundColor = [UIColor whiteColor];
    cell.backgroundColor = [UIColor whiteColor];
    return cell;
    
}

@end
