//
//  CouponTableViewCell.h
//  ZJPlatform
//
//  Created by sostag on 2018/4/2.
//  Copyright © 2018年 wzsd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CouponTableViewCell : UITableViewCell{
    
    IBOutlet UILabel *priceLabel;
    IBOutlet UILabel *label1;
    IBOutlet UILabel *label2;
    IBOutlet UIImageView *imgView;
}

-(void)loadDetail:(NSDictionary *)dict;
@end
