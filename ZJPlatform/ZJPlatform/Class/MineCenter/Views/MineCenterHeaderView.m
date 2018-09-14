//
//  MineCenterHeaderView.m
//  ZJPlatform
//
//  Created by sostag on 2018/3/26.
//  Copyright © 2018年 wzsd. All rights reserved.
//

#import "MineCenterHeaderView.h"
#import "UIImageView+WebCache.h"

@implementation MineCenterHeaderView


-(void)loadInfo:(NSDictionary *)dict{
    if (dict == nil) {
        _loginBtn.hidden = NO;
        _nameLabel.hidden = YES;
        _sourceView.hidden = YES;
    }else{
        _loginBtn.hidden = YES;
        _nameLabel.hidden = NO;
        _sourceView.hidden = NO;
        
        _nameLabel.text = [[dict objectForKey:@"member"] objectForKey:@"account"];
        _sourceLabel.text = [NSString stringWithFormat:@"%zi", [[[dict objectForKey:@"student"] objectForKey:@"integral"] integerValue]];
        if ([Utility isNotBlank:[[dict objectForKey:@"member"] objectForKey:@"headPortrait"]]) {
            [_imgView sd_setImageWithURL:[NSURL URLWithString:[[dict objectForKey:@"member"] objectForKey:@"headPortrait"]]];
        }else{
            [_imgView setImage:[UIImage imageNamed:@"head_default"]];
        }

        _imgView.layer.masksToBounds = YES;
        _imgView.layer.cornerRadius = _imgView.frame.size.height/2.0;
    }
    
}


-(IBAction)showLogin:(id)sender{
    SHOW_LOGIN
}


-(IBAction)showSetting:(id)sender{
    self.clickSetting();
}

-(IBAction)showMsg:(id)sender{
    self.clickMsg();
}

-(IBAction)showScan:(id)sender{
    self.clickScan();
}


@end
