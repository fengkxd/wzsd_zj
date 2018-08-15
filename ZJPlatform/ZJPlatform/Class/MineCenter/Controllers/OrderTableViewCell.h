//
//  OrderTableViewCell.h
//  ZJPlatform
//
//  Created by fk on 2018/8/15.
//  Copyright © 2018年 wzsd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrderTableViewCell : UITableViewCell
{
    IBOutlet UILabel *orderLabel;
    IBOutlet UIImageView *imgView;
    IBOutlet UILabel *nameLabel;
    IBOutlet UILabel *priceLabel;
    
    
}

-(void)loadInfo:(NSDictionary *)dict;


@end
