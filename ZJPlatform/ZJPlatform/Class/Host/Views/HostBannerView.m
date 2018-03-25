//
//  HostBannerView.m
//  ZJPlatform
//
//  Created by fengke on 2018/3/25.
//  Copyright © 2018年 wzsd. All rights reserved.
//


#define ScrollTimeDuration 5

#import "HostBannerView.h"
#import "NetworkManager.h"
#import "Utility.h"
#import "UIButton+WebCache.h"



@interface HostBannerView()
{
    CGFloat animationDuration;
    NSInteger curCount;
}

@property (nonatomic,strong) NSArray *array;
@property (nonatomic,strong) NSMutableArray *animationLabels;
//@property (nonatomic,strong) NSTimer *myTimer;
@end



@implementation HostBannerView


-(instancetype)initWithFrame:(CGRect)frame withArray:(NSArray *)array{
    self = [super initWithFrame:frame];
    if (self) {
        myScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, MainScreenWidth, frame.size.height - 85)];
        myScrollView.delegate = self;
        //        [self addSubview:myScrollView];
        myScrollView.backgroundColor = [UIColor clearColor];
        myScrollView.pagingEnabled = YES;
        myScrollView.showsHorizontalScrollIndicator = NO;
        myScrollView.showsVerticalScrollIndicator = NO;
        [self loadOutData:self.array];
        CGFloat headerHeight = frame.size.height - 85;
        myPageControl = [[UIPageControl alloc] initWithFrame:CGRectMake((MainScreenWidth - 15 * [array count])/2, headerHeight - 15, 15 * [array count], 10)];
        myPageControl.currentPageIndicatorTintColor = [Utility colorWithHexString:@"fdfbfc"];
        myPageControl.pageIndicatorTintColor = [Utility colorWithHexString:@"8e7d73"];
        myPageControl.currentPage = 0;
        [self addSubview:myPageControl];
        
    }
    return self;
}

-(void)initViewWithHeight:(CGFloat)height withData:(NSArray *)tempArray{
    if (myScrollView) {
        return;
    }
    //    CGFloat headerHeight = height - 85;
    
    CGFloat headerHeight = height ;
    
    self.backgroundColor = BgColor;
    
    myScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, MainScreenWidth, headerHeight)];
    myScrollView.delegate = self;
    [self addSubview:myScrollView];
    myScrollView.backgroundColor = [UIColor clearColor];
    myScrollView.pagingEnabled = YES;
    myScrollView.showsHorizontalScrollIndicator = NO;
    myScrollView.showsVerticalScrollIndicator = NO;
    
    myPageControl = [[UIPageControl alloc] initWithFrame:CGRectMake((MainScreenWidth - 15 * 0)/2, headerHeight - 15 , 15 * 0, 10)];
    myPageControl.currentPageIndicatorTintColor = [Utility colorWithHexString:@"fdfbfc"];
    myPageControl.pageIndicatorTintColor = [Utility colorWithHexString:@"8e7d73"];
    
    myPageControl.currentPage = 0;
    //        [myPageControl addTarget:self action:@selector(changePage:) forControlEvents:UIControlEventValueChanged];
    [self addSubview:myPageControl];
    
    
}




//定时器执行的操作
- (void)startAnimation{
    animationDuration = [self.animationLabels count] * 0.5;
    
    UILabel *label = [self.animationLabels objectAtIndex:curCount];
    label.frame = CGRectMake(105, 25, MainScreenWidth - 110, 25);
    __weak __typeof(self)  weakSelf = self;
    [UIView animateWithDuration:2 animations:^{
        
        
        label.frame = CGRectMake(105, 0, MainScreenWidth - 110, 25);
    } completion:^(BOOL finished) {
        [weakSelf performSelector:@selector(animationSecond) withObject:nil afterDelay:1];
    }];
    
}

-(void)animationSecond{
    UILabel *label = [self.animationLabels objectAtIndex:curCount];
    __weak __typeof(self)  weakSelf = self;
    [UIView animateWithDuration:2 animations:^{
        label.frame = CGRectMake(105, -25, MainScreenWidth - 110, 25);
    } completion:^(BOOL finished) {
        if (curCount == [weakSelf.animationLabels count] - 1) {
            curCount = 0;
        }else{
            curCount ++;
        }
        [weakSelf startAnimation];
    }];
    
    
    
}



-(void)loadOutData:(NSArray *)bannerList{
    
    if ([bannerList count] == 0) {
        return;
    }
    
    self.array = [NSArray arrayWithArray:bannerList];
    
    [myScrollView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    myScrollView.backgroundColor = [UIColor whiteColor];
    UIButton *Leftbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    Leftbtn.frame = CGRectMake(0 * MainScreenWidth, 0, MainScreenWidth, myScrollView.frame.size.height);
    //    NSString *url1 = [NSString stringWithFormat:@"%@%@",ProxyUrl,[[bannerList lastObject] objectForKey:@"photo"]];
    NSString *url1 = [NSString stringWithFormat:@"%@",[[bannerList lastObject] objectForKey:@"bannerPath"]];
    
    [Leftbtn sd_setImageWithURL:[NSURL URLWithString:url1] forState:UIControlStateNormal];
    [Leftbtn addTarget:self action:@selector(clickBanner:) forControlEvents:UIControlEventTouchUpInside];
    [myScrollView addSubview:Leftbtn];
    
    
    for (int i = 0; i < [bannerList count]; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake((i+1) * MainScreenWidth, 0, MainScreenWidth, myScrollView.frame.size.height);
        //  NSString *url = [NSString stringWithFormat:@"%@",ProxyUrl,[[bannerList objectAtIndex:i] objectForKey:@"photo"]];
        NSString *url = [NSString stringWithFormat:@"%@",[[bannerList objectAtIndex:i] objectForKey:@"bannerPath"]];
        
        
        [btn sd_setImageWithURL:[NSURL URLWithString:url] forState:UIControlStateNormal];
        btn.tag =i;
        btn.adjustsImageWhenHighlighted = NO;
        btn.showsTouchWhenHighlighted = NO;
        [btn addTarget:self action:@selector(clickBanner:) forControlEvents:UIControlEventTouchUpInside];
        [myScrollView addSubview:btn];
    }
    
    UIButton *rightbtn_ = [UIButton buttonWithType:UIButtonTypeCustom];
    rightbtn_.frame = CGRectMake(([bannerList count]+ 1) * MainScreenWidth, 0, MainScreenWidth, myScrollView.frame.size.height);
    //    NSString *url2 = [NSString stringWithFormat:@"%@%@",ProxyUrl,[[bannerList objectAtIndex:0] objectForKey:@"photo"]];
    
    NSString *url2 = [NSString stringWithFormat:@"%@",[[bannerList objectAtIndex:0] objectForKey:@"bannerPath"]];
    
    [rightbtn_ sd_setImageWithURL:[NSURL URLWithString:url2] forState:UIControlStateNormal];
    [rightbtn_ addTarget:self action:@selector(clickBanner:) forControlEvents:UIControlEventTouchUpInside];
    [myScrollView addSubview:rightbtn_];
    
    
    myScrollView.contentSize = CGSizeMake(MainScreenWidth * ([bannerList count] + 2), myScrollView.frame.size.height);
    myScrollView.contentOffset = CGPointMake(MainScreenWidth, 0);
    
    myPageControl.frame =  CGRectMake((MainScreenWidth - 15 * [self.array count])/2, myScrollView.frame
                                      .size.height- 15, 15 * [self.array count], 10);
    myPageControl.numberOfPages = [bannerList count];
    myPageControl.currentPage = 0;
    [self bringSubviewToFront:myPageControl];
    if ([bannerList count] > 1) {
        [self performSelector:@selector(autoScroll) withObject:nil afterDelay:ScrollTimeDuration];
    }else{
        myScrollView.scrollEnabled = NO;
    }
    
    if ([bannerList count] == 1) {
        myPageControl.hidden = YES;
    }else{
        myScrollView.hidden = NO;
    }
    
    
    
}

-(void)autoScroll{
    
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(autoScroll) object:nil];
    
    NSInteger page = myPageControl.currentPage;
    if (page == [self.array count] -1) {
        myPageControl.currentPage = 0;
    }else{
        myPageControl.currentPage = page + 1;
    }
    
    
    CGFloat offsetX = myScrollView.contentOffset.x + myScrollView.frame.size.width;
    offsetX = (int)(offsetX/MainScreenWidth) * MainScreenWidth;
    [myScrollView setContentOffset:CGPointMake(offsetX, 0) animated:YES];
    [self performSelector:@selector(autoScroll) withObject:nil afterDelay:ScrollTimeDuration];
    
    
}



#pragma mark -- scrollview delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if ([self.array isKindOfClass:[NSNull class]]) {
        return;
    }
    
    NSInteger TOTALCOUNT = self.array.count;
    float targetX = scrollView.contentOffset.x;
    float ITEM_WIDTH = scrollView.frame.size.width;
    
    if (targetX < ITEM_WIDTH/2 ) {
        
        [scrollView setContentOffset:CGPointMake(ITEM_WIDTH * TOTALCOUNT + targetX, 0)];
        
    }
    else if (targetX > ITEM_WIDTH * TOTALCOUNT + ITEM_WIDTH/2)
    {
        [scrollView setContentOffset:CGPointMake(targetX - ITEM_WIDTH * TOTALCOUNT, 0)];
        
    }
}


-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    NSInteger page = scrollView.contentOffset.x / MainScreenWidth - 1;
    myPageControl.currentPage = page;
}


-(void)clickBanner:(UIButton *)btn{
    self.clickBanner([self.array objectAtIndex:btn.tag]);
}



@end
