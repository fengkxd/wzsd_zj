//
//  HostSelectedTypeViewController.m
//  ZJPlatform
//
//  Created by sostag on 2018/3/27.
//  Copyright © 2018年 wzsd. All rights reserved.
//

#import "HostSelectedTypeViewController.h"

@interface HostSelectedTypeViewController ()
{
    UIImageView *selImageView;
}


@end

@implementation HostSelectedTypeViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self createBackBtn];
    [self setTitleView:@"请选择专业"];
    
    //此处必须要有创见一个UICollectionViewFlowLayout的对象
    UICollectionViewFlowLayout *layout=[[UICollectionViewFlowLayout alloc]init];
    //同一行相邻两个cell的最小间距
    layout.minimumInteritemSpacing = 5;
    //最小两行之间的间距
    layout.minimumLineSpacing = 5;
    
    myCollectionView =[[UICollectionView alloc]initWithFrame:CGRectMake(0, 00, MainScreenWidth, MainScreenheight  - 64) collectionViewLayout:layout];
    myCollectionView.backgroundColor=BgColor;
    myCollectionView.delegate=self;
    myCollectionView.dataSource=self;
    [self.view addSubview:myCollectionView];
    [myCollectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    
    
    selImageView = [[UIImageView alloc] initWithFrame:CGRectMake((MainScreenWidth - 30) /2.0 - 20 - 8, 8, 20, 20)];
    selImageView.image = [UIImage imageNamed:@"sel.png"];
}

-(void)goBack:(id)sender{

    self.selectedBlock(self.selRow);
    
    [super goBack:self];
}

#pragma mark ---- UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.titles count];
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];

    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, (MainScreenWidth - 30) /2.0, 112);
    [cell.contentView addSubview:btn];
    btn.tag = 11;
    [btn addTarget:self action:@selector(clickCell:) forControlEvents:UIControlEventTouchUpInside];
    NSInteger row = indexPath.row;
   
    [btn setTitle:[self.titles objectAtIndex:row] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:[self.imgNames objectAtIndex:row]] forState:UIControlStateNormal];

    
    btn.userInteractionEnabled = NO;
    [self verticalImageAndTitle:5 withBtn:btn];
    if (self.selRow == row) {
        [btn addSubview:selImageView];
    }
    return cell;
}


-(void)clickCell:(UIButton *)btn{
    [btn resignFirstResponder];
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





// 点击高亮
- (void)collectionView:(UICollectionView *)collectionView didHighlightItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
    UIButton *btn = (UIButton *)[cell.contentView viewWithTag:11];
    
    [btn addSubview:selImageView];
    self.selRow = indexPath.row;
}



#pragma mark ---- UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return (CGSize){(MainScreenWidth - 30) /2.0,112};
}


- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(10, 10, 10, 10);
}


- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 5.f;
}


- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 5.f;
}






#pragma mark ---- UICollectionViewDelegate

- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}


// 选中某item
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
}






@end
