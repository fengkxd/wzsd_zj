//
//  TQGGLXCell.m
//  ZJPlatform
//
//  Created by Rongbo Li on 2018/4/2.
//  Copyright © 2018年 wzsd. All rights reserved.
//

#import "TQGGLXCell.h"

@implementation TQGGLXCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.firstVi.layer.cornerRadius = 2.0f;
    self.firstVi.layer.borderWidth = 1;
    self.firstVi.layer.borderColor = CTPUIColorFromRGB(0xDDDDDD).CGColor;
    
    self.secVi.layer.cornerRadius = 2.0f;
    self.secVi.layer.borderWidth = 1;
    self.secVi.layer.borderColor = CTPUIColorFromRGB(0xDDDDDD).CGColor;
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
