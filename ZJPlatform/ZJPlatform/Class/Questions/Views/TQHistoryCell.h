//
//  TQHistoryCell.h
//  ZJPlatform
//
//  Created by Rongbo Li on 2018/4/1.
//  Copyright © 2018年 wzsd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TQHistoryCell : UITableViewCell
{
    IBOutlet UILabel *label1;
    IBOutlet UILabel *label2;
    
}

-(void)loadinfo:(NSDictionary *)dict;


@end
