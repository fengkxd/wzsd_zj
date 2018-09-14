//
//  TQHistoryViewController.m
//  ZJPlatform
//
//  Created by Rongbo Li on 2018/4/1.
//  Copyright © 2018年 wzsd. All rights reserved.
//

#import "TQHistoryViewController.h"
#import "TQTestInfoViewController.h"
#import "MJRefresh.h"
#import "TQHistoryCell.h"
#import "TQTestViewController.h"
#import "TQTestSubVC.h"
#import "JSONKit.h"

@interface TQHistoryViewController () <UITableViewDelegate,UITableViewDataSource>
{
    NSInteger page;

}
@property (nonatomic,strong) NSMutableArray *subVCs;
@property (nonatomic, strong) UICollectionView *mainCollection;


@property (nonatomic,strong) NSMutableArray *dataArray;
@property (nonatomic,assign) NSInteger page;
@property (nonatomic,assign) NSInteger pageSize;
@end

@implementation TQHistoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if (self.type == 1) {
        [self setTitleView:@"巩固练习"];
    }else if(self.type == 2){
        [self setTitleView:@"全真模拟"];
    }else{
        [self setTitleView:@"历年真题"];
    }
    
    [self createBackBtn];
    self.dataArray = [NSMutableArray array];
    self.page = 0;
    self.pageSize = 10;

    [self requestDataSource];
}

-(void)requestDataSource{
    NSString *url;
    if (self.type == 1) {
        url = [NSString stringWithFormat:@"%@%@",ProxyUrl,kRequest_questions_consolidation];
    }else{
        url = [NSString stringWithFormat:@"%@%@",ProxyUrl,kRequest_testPaper_list];
    }
    WS(weakSelf);
    NSDictionary *dict =  @{@"courseClassify.id":self.courseClassifyId,@"pageNo":[NSString stringWithFormat:@"%zi",self.page],@"pageSize":[NSString stringWithFormat:@"%zi",self.pageSize],@"type":[NSString stringWithFormat:@"%zi",self.type]};
    
    
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
    NSLog(@"%@",dict);
    
    if (self.type == 1) {
        self.subVCs = [NSMutableArray array];
        [self.dataArray addObjectsFromArray:[dict objectForKey:@"single"]];
        [self.dataArray addObjectsFromArray:[dict objectForKey:@"checkbox"]];
        
        for (NSInteger i = 0; i < [self.dataArray count]; i++) {
            TQTestSubVC *subVC = [[TQTestSubVC alloc] init];
            subVC.question = [self.dataArray objectAtIndex:i];
            subVC.curNum = i;
            subVC.totalCount = [self.dataArray count] ;
            [self.subVCs addObject:subVC];
        }
        
        _myTable.hidden = YES;
        [self initBottomView];
        [self setMainCrollView];
    }else{
        
        if ([[dict objectForKey:@"lastPage"] integerValue] == self.page+1) {
            _myTable.footer.hidden = YES;
        }else{
            _myTable.footer.hidden = NO;
        }
        [self.dataArray addObjectsFromArray:[dict objectForKey:@"list"]];
        [_myTable reloadData];
    }
}



#pragma mark 左右滑动的collectionview
- (void)setMainCrollView {
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(MainScreenWidth,  MainScreenheight - kBottomHeight - 44 - kStatusBarHeight - 44);
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
    layout.sectionInset = UIEdgeInsetsZero;
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    self.mainCollection = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, MainScreenWidth, MainScreenheight - kBottomHeight - 44 - kStatusBarHeight - 44) collectionViewLayout:layout];
    self.mainCollection.delegate = self;
    self.mainCollection.dataSource = self;
    self.mainCollection.showsHorizontalScrollIndicator = NO;
    self.mainCollection.pagingEnabled = YES;
    self.mainCollection.scrollEnabled = NO;
    [self.mainCollection registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"UICollectionViewCellID1"];
    self.mainCollection.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.mainCollection];
}

#pragma mark collectionview  delegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.dataArray count];
    
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"UICollectionViewCellID1" forIndexPath:indexPath];
    TQTestSubVC *subVC = self.subVCs[indexPath.row];
    subVC.view.frame = CGRectMake(0, 0, MainScreenWidth, MainScreenheight - kBottomHeight - 44 - kStatusBarHeight - 44);
    subVC.tableView.frame = CGRectMake(0, 0, MainScreenWidth, MainScreenheight - kBottomHeight - 44 - kStatusBarHeight - 44);
    [cell.contentView addSubview:subVC.view];
    cell.contentView.backgroundColor = [UIColor whiteColor];
    cell.backgroundColor = [UIColor whiteColor];
    return cell;
    
}

-(void)initBottomView{
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, MainScreenheight - kBottomHeight - 44 - kStatusBarHeight - 44, MainScreenWidth, 0.5)];
    line.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:line];
    
    CGFloat y = MainScreenheight - kBottomHeight - 44 - kStatusBarHeight - 44;
    UIButton *commitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [commitBtn setBackgroundColor:MainBlueColor];
    commitBtn.titleLabel.font = Font(15);
    commitBtn.frame = CGRectMake((MainScreenWidth - 120)/2.0, y +  4, 120, 35);
    [commitBtn setTitle:@"立即提交" forState:UIControlStateNormal];
    [self.view addSubview:commitBtn];
    [commitBtn addTarget:self action:@selector(commit) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake(MainScreenWidth/2.0 + 60, y + 4, MainScreenWidth/2.0 - 60, 35);
    [rightBtn setTitle:@"下题" forState:UIControlStateNormal];
    [rightBtn setImage:[UIImage imageNamed:@"arrow_right"] forState:UIControlStateNormal];
    [self verticalImageAndTitle:0 withBtn:rightBtn];
    [self.view addSubview:rightBtn];
    
    
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBtn.frame = CGRectMake(0, y + 4, MainScreenWidth/2.0 - 60, 35);
    [leftBtn setTitle:@"上题" forState:UIControlStateNormal];
    [leftBtn setImage:[Utility image:[UIImage imageNamed:@"arrow_right"] rotation:UIImageOrientationDown] forState:UIControlStateNormal];
    [self verticalImageAndTitle:0 withBtn:leftBtn];
    [self.view addSubview:leftBtn];
    
    [leftBtn addTarget:self action:@selector(up) forControlEvents:UIControlEventTouchUpInside];
    [rightBtn addTarget:self action:@selector(next) forControlEvents:UIControlEventTouchUpInside];
    page = 1;
}


-(void)commit{
    
    NSMutableArray *listAnswer = [NSMutableArray array];
    for (NSInteger i = 0; i < [self.subVCs count]; i ++  ) {
        UIViewController *vc = self.subVCs[i];
        if ([vc isKindOfClass:[TQTestSubVC class]]) {
            NSDictionary *questionDict = [self.dataArray objectAtIndex:i];
            NSArray *array = [questionDict objectForKey:@"resultList"];
            TQTestSubVC *subVc = (TQTestSubVC *)vc;
            if ([subVc.selIndexPaths count] == 0) {
                NSDictionary *answer =@{@"questionId":[questionDict objectForKey:@"id"],@"answer":@""};
                [listAnswer addObject:answer];
                continue;
            }
            NSMutableString *str = [NSMutableString string];
            for (NSIndexPath *indexPath in subVc.selIndexPaths) {
                NSDictionary *dict = [array objectAtIndex:indexPath.row - 2];
                [str appendFormat:@"%@,",[dict objectForKey:@"checkValue"]];
            }
            NSRange deleteRange = { [str length] - 1, 1 };
            [str deleteCharactersInRange:deleteRange];
            NSDictionary *answer =@{@"questionId":[questionDict objectForKey:@"id"],@"answer":str};
            [listAnswer addObject:answer];
        }
 
    }
    NSString *str = @"确定要交卷吗？";

    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:str preferredStyle:UIAlertControllerStyleAlert];
    //创建提示按钮
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];

    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSDictionary *commitDict = @{@"listAnswer":[listAnswer JSONString]};
        [self requestAnswer:commitDict];

    }];

    [alertController addAction:action1];
    [alertController addAction:action2];
    [self presentViewController:alertController animated:YES completion:nil];
}


-(void)requestAnswer:(NSDictionary *)dict{
    NSString *url = [NSString stringWithFormat:@"%@%@",ProxyUrl,kRequest_questions_verifying];
    WS(weakSelf);
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[NetworkManager shareNetworkingManager] requestWithMethod:@"POST" headParameter:nil bodyParameter:dict relativePath:url
                                                       success:^(id responseObject) {
                                                           [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
                                                           [weakSelf loadResult:responseObject];
                                                       } failure:^(NSString *errorMsg) {
                                                           [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
                                                           [Toast showWithText:errorMsg];
                                                           
                                                       }];
}

-(void)loadResult:(NSString *)str{
 
    NSArray *arr = [str componentsSeparatedByString:@","];
    NSInteger suc =[[arr firstObject] integerValue];
    NSInteger fail = [[arr lastObject] integerValue];
    NSString *alertStr =[NSString stringWithFormat:@"共%zi题，回答正确%zi题，错误%zi题",suc + fail , suc, fail] ;
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:alertStr preferredStyle:UIAlertControllerStyleAlert];
    //创建提示按钮
    
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self.navigationController popViewControllerAnimated:YES];
    }];
    [alertController addAction:action];
    [self presentViewController:alertController animated:YES completion:nil];
    
    
}

-(void)up{
    if (page == 1) {
        return;
    }
    page -- ;
    [self.mainCollection setContentOffset:CGPointMake((page -1) * MainScreenWidth, 0) animated:YES];
}


-(void)next{
    NSInteger totle = [self.dataArray count];
    if (page == totle) {
        return;
    }
    page ++ ;
    
    [self.mainCollection setContentOffset:CGPointMake((page -1) * MainScreenWidth, 0) animated:YES];
}




- (void)verticalImageAndTitle:(CGFloat)spacing withBtn:(UIButton *)btn
{
    btn.titleLabel.font = Font_13;
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
    btn.titleEdgeInsets = UIEdgeInsetsMake(0, - imageSize.width, - (totalHeight - titleSize.height) - 5, 0);
    [btn setBackgroundColor:[UIColor whiteColor]];
}






#pragma mark - UITableViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    TQTestViewController *vc = [[TQTestViewController alloc] init];
    vc.testId = [self.dataArray[indexPath.row] objectForKey:@"id"];
    [vc setTitleView:[self.dataArray[indexPath.row] objectForKey:@"title"]];
    [self.navigationController pushViewController:vc animated:YES];
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 65.0f;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 10;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 0.1;
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [[self dataArray] count];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellid = @"TQHistoryCell";
    TQHistoryCell *cell = (TQHistoryCell *)[tableView dequeueReusableCellWithIdentifier:cellid];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"TQHistoryCell" owner:self options:nil] lastObject];
    }
    [cell loadinfo:[self.dataArray objectAtIndex:indexPath.row]];
    return cell;
}

@end
