//
//  TQTestViewController.m
//  ZJPlatform
//
//  Created by fk on 2018/8/18.
//  Copyright © 2018年 wzsd. All rights reserved.
//

#import "TQTestViewController.h"
#import "TQTestViewSubVC.h"
#import "TQTestArticSubVC.h"
#import "JSONKit.h"
#import "TQResultViewController.h"

@interface TQTestViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, UIScrollViewDelegate>{
    NSInteger page;
    
}

@property (nonatomic, strong) UICollectionView *mainCollection;

@property (nonatomic,strong) NSMutableArray *subVCs;

@property (nonatomic,strong) NSMutableArray *array1;  // 选择题
@property (nonatomic,strong) NSMutableArray *array2; //  阅读题
@end

@implementation TQTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.subVCs = [NSMutableArray array];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self initBottomView];
    [self createBackBtn];
    [self requestDataSource];
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
        if ([vc isKindOfClass:[TQTestViewSubVC class]]) {
            NSDictionary *questionDict = [self.array1 objectAtIndex:i];
            NSArray *array = [[questionDict objectForKey:@"questions"] objectForKey:@"resultList"];
            TQTestViewSubVC *subVc = (TQTestViewSubVC *)vc;
            if ([subVc.selIndexPaths count] == 0) {
                NSDictionary *answer = @{@"answer":@"",@"questionId":[[[array lastObject] objectForKey:@"questions"] objectForKey:@"id"]};
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
            NSDictionary *answer = @{@"answer":str,@"questionId":[[[array lastObject] objectForKey:@"questions"] objectForKey:@"id"]};
            [listAnswer addObject:answer];
        }
        
        
        
        if ([vc isKindOfClass:[TQTestArticSubVC class]]) {
            NSDictionary *questionDict = [self.array2 objectAtIndex:i - [self.array1 count]];
            TQTestArticSubVC *subVc = (TQTestArticSubVC *)vc;
            if ([Utility isNotBlank:subVc.myTextView.text]) {
                NSDictionary *answer = @{@"answer":subVc.myTextView.text,@"questionId":[[[questionDict objectForKey:@"questionsArticle"] objectForKey:@"questions"] objectForKey:@"id"]};
                [listAnswer addObject:answer];
            }else{
                NSDictionary *answer = @{@"answer":@"",@"questionId":[[[questionDict objectForKey:@"questionsArticle"] objectForKey:@"questions"] objectForKey:@"id"]};
                [listAnswer addObject:answer];
            }
        }
    }
    NSString *str = @"确定要交卷吗？";
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:str preferredStyle:UIAlertControllerStyleAlert];
    //创建提示按钮
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSDictionary *commitDict = @{@"listAnswer":[listAnswer JSONString],@"testPaper.id":self.testId};
        [self requestAnswer:commitDict];
        
    }];

    [alertController addAction:action1];
    [alertController addAction:action2];
    [self presentViewController:alertController animated:YES completion:nil];
}


-(void)requestAnswer:(NSDictionary *)dict{
    NSString *url = [NSString stringWithFormat:@"%@%@",ProxyUrl,kRequest_memberAnswer_verifying];
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

-(void)loadResult:(NSDictionary *)dict{    
    TQResultViewController *vc = [[TQResultViewController alloc] initWithNibName:nil bundle:nil];
    vc.rateDict = dict;
    NSMutableArray *vcs = [NSMutableArray arrayWithArray:[self.navigationController viewControllers]];
    [vcs replaceObjectAtIndex:[vcs count]-1 withObject:vc];
    [self.navigationController setViewControllers:vcs animated:YES];
}



-(void)up{
    if (page == 1) {
        return;
    }
     page -- ;
    [self.mainCollection setContentOffset:CGPointMake((page -1) * MainScreenWidth, 0) animated:YES];
}


-(void)next{
     NSInteger totle = [self.array1 count] + [self.array2 count];
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
    NSDictionary *testPaper = [dict objectForKey:@"testPaper"];
    NSArray *articArray = [dict objectForKey:@"artic"];
    
    self.array1 = [NSMutableArray array];
    self.array2 = [NSMutableArray array];

    for (NSDictionary *bigQuestion in [testPaper objectForKey:@"bigQuestionList"]) {
        if ([[bigQuestion objectForKey:@"paperQuestionList"] count]) {
            if ([[[[[bigQuestion objectForKey:@"paperQuestionList"] lastObject] objectForKey:@"questions"] objectForKey:@"pageType"] integerValue] != 3) {
                [self.array1 addObjectsFromArray:[bigQuestion objectForKey:@"paperQuestionList"]];
            }
        }
    }
    
    for (NSInteger i = 0; i < [articArray count]; i++) {
        NSDictionary *dict = [articArray objectAtIndex:i];
        NSArray *questionsArticleList = [dict objectForKey:@"questionsArticleList"];
        for (NSInteger j = 0; j < [questionsArticleList count]; j ++) {
            NSDictionary *questionsArticle  = [questionsArticleList objectAtIndex:j];
            NSMutableDictionary *articleDict = [NSMutableDictionary dictionary];
            [articleDict setObject:[dict objectForKey:@"article"] forKey:@"article"];
            [articleDict setObject:questionsArticle forKey:@"questionsArticle"];
            [self.array2 addObject:articleDict];
        }
    }
    
    for (NSInteger i = 0; i < [self.array1 count]; i++) {
        TQTestViewSubVC *subVC = [[TQTestViewSubVC alloc] initWithNibName:@"TQTestViewSubVC" bundle:nil];
        subVC.question = [self.array1 objectAtIndex:i];
        subVC.curNum = i;
        subVC.totalCount = [self.array1 count] + [self.array2 count];
        [self.subVCs addObject:subVC];
    }
    
    for (NSInteger i = 0; i < [self.array2 count]; i++) {
        TQTestArticSubVC *subVC = [[TQTestArticSubVC alloc] init];
        subVC.articleDict = [self.array2 objectAtIndex:i];
        subVC.curNum = [self.array1 count] + i;
        subVC.totalCount = [self.array1 count] + [self.array2 count];
        [self.subVCs addObject:subVC];
    }
    [self setMainCrollView];
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
    return [self.array1 count] + [self.array2 count];
    
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"UICollectionViewCellID1" forIndexPath:indexPath];
    TQTestViewSubVC *subVC = self.subVCs[indexPath.row];
    subVC.view.frame = CGRectMake(0, 0, MainScreenWidth, MainScreenheight - kBottomHeight - 44 - kStatusBarHeight - 44);
    subVC.tableView.frame = CGRectMake(0, 0, MainScreenWidth, MainScreenheight - kBottomHeight - 44 - kStatusBarHeight - 44);
    [cell.contentView addSubview:subVC.view];
    cell.contentView.backgroundColor = [UIColor whiteColor];
    cell.backgroundColor = [UIColor whiteColor];
    return cell;
    
}

@end
