//
//  HostCommendVideoView.m
//  ZJPlatform
//
//  Created by sostag on 2018/3/26.
//  Copyright © 2018年 wzsd. All rights reserved.
//

#import "HostCommendVideoView.h"
#import "UIImageView+WebCache.h"

@implementation HostCommendVideoView



-(void)loadCourse:(NSDictionary *)dict{
    
    nameLabel.text = [dict objectForKey:@"name"];
    if ([Utility isBlank:[[dict objectForKey:@"famousTeacher"] objectForKey:@"name"]]) {
        teachLabel.text = @"";
    }else{
        teachLabel.text = [NSString stringWithFormat:@"名师：%@",[[dict objectForKey:@"famousTeacher"] objectForKey:@"name"]];

    }
    browsingNumberLabel.text = [NSString stringWithFormat:@"%zi人",[[dict objectForKey:@"browsingNumber"] integerValue]];

    [imgView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",ImgProxyUrl,[dict objectForKey:@"frontCover"]]]];
}
@end
