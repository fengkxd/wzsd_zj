//
//  HostBannerView.h
//  ZJPlatform
//
//  Created by fengke on 2018/3/25.
//  Copyright © 2018年 wzsd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HostBannerView : UIView<UIScrollViewDelegate>
{
    UIScrollView *myScrollView;
    
    UIPageControl *myPageControl;
    
    UIView *pageControlBg;
    
}
@property (nonatomic,assign) id delegate;
@property (copy) void (^clickBanner)(NSDictionary *dict);

-(void)initViewWithHeight:(CGFloat)height withData:(NSArray *)tempArray;

-(instancetype)initWithFrame:(CGRect)frame withArray:(NSArray *)array;

//-(void)requestData;


-(void)loadOutData:(NSArray *)bannerList;

@end
