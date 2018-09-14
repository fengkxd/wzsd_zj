//
//  UploadOperation.m
//  tea
//
//  Created by fengke on 16/2/27.
//  Copyright © 2016年 com.xhhc. All rights reserved.
//

#import "UploadOperation.h"
#import "RequestPostUploadHelper.h"
#import "NetworkManager.h"

@implementation UploadOperation


-(instancetype)initWithPath:(NSString *)path{
    self = [super init];
    if (self) {
        
        self.curPath = path;
        
    }
    return self;
}


-(instancetype)initWithImage:(UIImage *)img{

    self = [super init];
    if (self) {
        
        self.curImg = img;
        
    }
    return self;

}





-(void)main{
    NSString *url = [NSString stringWithFormat:@"%@/%@",ProxyUrl,@"file"];
    __weak __typeof(self) weakSelf = self;
    
    
    if (self.curImg) {
        self.myTast =  [RequestPostUploadHelper postRequestWithURL:url
                                                        postParems:@{@"handler":@"id",@"name":@"1.png"}
                                                           picFile:self.curImg  // IN 上传图片
                                                       picFileName:@"file"
                                                           success:^(id responseObject) {
                                                               [weakSelf.delegate upload:self didFinishWithSuccessWithPath:self.curPath withObject:responseObject];
                                                               weakSelf.isFinish = YES;
                                                           } failure:^(NSError *error) {
                                                               [weakSelf.delegate upload:self didStopWithError:error];
                                                               weakSelf.isFinish = YES;
                                                           }];
    }else{
        self.myTast =  [RequestPostUploadHelper postRequestWithURL:url
                                                        postParems:@{@"handler":@"id"}
                                                       picFilePath:self.curPath
                                                       picFileName:@"name"
                                                           success:^(id responseObject) {
                                                               [weakSelf.delegate upload:self didFinishWithSuccessWithPath:self.curPath withObject:responseObject];
                                                               weakSelf.isFinish = YES;
                                                           } failure:^(NSError *error) {
                                                               [weakSelf.delegate upload:self didStopWithError:error];
                                                               weakSelf.isFinish = YES;
                                                           }];
    
    }
    
    
    
    
    
    while (!self.isFinish) {
        [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
    }
}

-(void)cancelTask{
    [self.myTast cancel];
    [self cancel];
}



@end
