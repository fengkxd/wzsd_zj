//
//  MyOrderViewController.m
//  ZJPlatform
//
//  Created by fk on 2018/8/15.
//  Copyright © 2018年 wzsd. All rights reserved.
//

#import "MyOrderViewController.h"
#import "MainTableView.h"
#import "MyOrderSubVC.h"

@interface MyOrderViewController ()<UITableViewDelegate, UITableViewDataSource, UICollectionViewDelegate, UICollectionViewDataSource, UIScrollViewDelegate>

@property (nonatomic, strong) MainTableView *tableView;
@property (nonatomic, strong) UICollectionView *mainCollection;
@property (nonatomic, assign) BOOL canScroll;
@property (nonatomic,strong) NSMutableArray *subVCs;
@property (nonatomic,strong) UIView *sectionView;
@property (nonatomic,strong) UIButton *selectedBtn;

@end

@implementation MyOrderViewController



-(UITableView *)tableView{
    if (_tableView == nil) {
        _tableView = [[MainTableView alloc] initWithFrame:CGRectMake(0, 44, MainScreenWidth, MainScreenheight - kStatusBarHeight - 44 - 44) style:UITableViewStylePlain];
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor =[UIColor whiteColor];
        self.canScroll = YES;
    }
    return _tableView;
}

-(void)initSectionView{
    self.sectionView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, MainScreenWidth, 44)];
    UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn1.frame = CGRectMake(0, 0, MainScreenWidth/2.0, 44);
    [btn1 setTitle:@"已开通课程" forState:UIControlStateNormal];
    [btn1 setTitleColor:[UIColor colorWithHexString:@"444444"] forState:UIControlStateNormal];
    [btn1 setTitleColor:[UIColor colorWithHexString:@"04a7fd"] forState:UIControlStateSelected];
    [btn1 addTarget:self action:@selector(clickType:) forControlEvents:UIControlEventTouchUpInside];
    btn1.tag = 1;
    self.selectedBtn = btn1;
    self.selectedBtn.selected = YES;
    
    UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn2.frame = CGRectMake(MainScreenWidth/2.0, 0, MainScreenWidth/2.0, 44);
    [btn2 setTitle:@"未付费课程" forState:UIControlStateNormal];
    [btn2 setTitleColor:[UIColor colorWithHexString:@"444444"] forState:UIControlStateNormal];
    [btn2 setTitleColor:[UIColor colorWithHexString:@"04a7fd"] forState:UIControlStateSelected];
    [btn2 addTarget:self action:@selector(clickType:) forControlEvents:UIControlEventTouchUpInside];
    btn2.tag = 2;
    
    btn1.titleLabel.font = Font_15;
    btn2.titleLabel.font = Font_15;
    [self.sectionView addSubview:btn1];
    [self.sectionView addSubview:btn2];
    [self.view addSubview:self.sectionView];
    
}


-(void)clickType:(UIButton *)btn{
    if (self.selectedBtn == btn) {
        return;
    }
    self.selectedBtn.selected = NO;
    self.selectedBtn = btn;
    self.selectedBtn.selected = YES;
    [self.mainCollection setContentOffset:CGPointMake((btn.tag-1) * MainScreenWidth, 0) animated:YES] ;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitleView:@"我的课程"];
    [self createBackBtn];
    self.canScroll = YES;
    self.subVCs = [NSMutableArray array];
    [self initSectionView];
    [self.view addSubview:self.tableView];

    
    for (NSInteger i = 0; i < 2; i ++) {
        MyOrderSubVC *subVC = [[MyOrderSubVC alloc] init];
        if (i == 0) {
            subVC.type  = 3;
        }else{
            subVC.type  = 0;
        }
        __weak typeof(self) weakSelf = self;
        [subVC handlerBlock:^{
            weakSelf.canScroll = YES;
            for (MyOrderSubVC *vc in self.subVCs) {
                if (vc != subVC) {
                    vc.canScroll = NO;
                    vc.tableView.contentOffset = CGPointZero;
                }
            }
        }];
        subVC.didSelectedCourse = ^(NSDictionary *dict) {
            
        };
        
        [self.subVCs addObject:subVC];
        
    }
    [self setMainCrollView];
    [self.tableView reloadData];
    
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



-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    NSInteger tag = scrollView.contentOffset.x/MainScreenWidth + 1;
    if (self.selectedBtn.tag == tag) {
        return;
    }
    UIButton *btn = (UIButton *)[self.sectionView viewWithTag:tag];
    if ([btn isKindOfClass:[UIButton class]]) {
        self.selectedBtn.selected = NO;
        self.selectedBtn = btn;
        self.selectedBtn.selected = YES;
        
    }
}




- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    //    NSLog(@"---%@",scrollView);
    if (scrollView == self.tableView) {
        CGFloat scrollY = [self.tableView rectForSection:0].origin.y;
        if (scrollView.contentOffset.y >= scrollY) {
            if (self.canScroll == YES) {
                self.canScroll = NO;
                for (MyOrderSubVC *vc in self.subVCs) {
                    vc.canScroll = YES;
                    vc.tableView.contentOffset = CGPointZero;
                }
            }
            self.tableView.contentOffset = CGPointMake(0, scrollY);
        }else{
            if (self.canScroll == NO) {
                self.tableView.contentOffset = CGPointMake(0, scrollY);
            }
        }
    }
}


#pragma mark - Table view data source


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell1"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell1"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.contentView.backgroundColor = [UIColor whiteColor];
        
    }
    if (self.mainCollection && self.mainCollection.superview == nil) {
        [cell.contentView addSubview:self.mainCollection];
    }
    return cell;
    
}



-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    
    return  MainScreenheight - kStatusBarHeight - 44 - 44 ;
    
}

#pragma mark collectionview  delegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 2;
    
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"UICollectionViewCellID1" forIndexPath:indexPath];
    MyOrderSubVC *subVC = self.subVCs[indexPath.row];
    subVC.view.frame = CGRectMake(0, 0, MainScreenWidth, MainScreenheight-kStatusBarHeight - 44 - kTabbarHeight - 44);
    subVC.tableView.frame = CGRectMake(0, 0, MainScreenWidth, MainScreenheight-kStatusBarHeight - 44 - kTabbarHeight - 44);
    [cell.contentView addSubview:subVC.view];
    cell.contentView.backgroundColor = [UIColor whiteColor];
    cell.backgroundColor = [UIColor whiteColor];
    return cell;
    
}


-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return nil;
}



-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}



@end
