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


-(instancetype)initWithFrame:(CGRect)frame withArray:(NSArray *)array;

 

-(void)loadOutData:(NSArray *)bannerList;

@end
