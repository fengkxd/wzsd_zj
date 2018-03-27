//
//  HostSelectedTypeViewController.h
//  ZJPlatform
//
//  Created by sostag on 2018/3/27.
//  Copyright © 2018年 wzsd. All rights reserved.
//

#import "BaseViewController.h"

@interface HostSelectedTypeViewController : BaseViewController<UICollectionViewDataSource,UICollectionViewDelegate>
{
    UICollectionView *myCollectionView;
}


@property (nonatomic,strong) NSArray *titles;
@property (nonatomic,strong) NSArray *imgNames;
@property (nonatomic,assign) NSInteger selRow;

@property (copy) void (^selectedBlock)(NSInteger row);

@end
