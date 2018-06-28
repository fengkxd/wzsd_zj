//
//  HostCommendVideoView.h
//  ZJPlatform
//
//  Created by sostag on 2018/3/26.
//  Copyright © 2018年 wzsd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HostCommendVideoView : UITableViewCell
{
    IBOutlet UIImageView *imgView;
    IBOutlet UILabel *nameLabel;
    IBOutlet UILabel *teachLabel;
    IBOutlet UILabel *browsingNumberLabel;
    
    
    
}


-(void)loadCourse:(NSDictionary *)dict;

@end
