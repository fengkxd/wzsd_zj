//
//  UploadOperation.h
//  tea
//
//  Created by fengke on 16/2/27.
//  Copyright © 2016年 com.xhhc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class UploadOperation;
@protocol UploadOperationDelegate <NSObject>
- (void)upload:(UploadOperation *)Download didStopWithError:(NSError *)error;
- (void)upload:(UploadOperation *)operation didFinishWithSuccessWithPath:(NSString *)pathToFile withObject:(id)responseObject;
@end

@interface UploadOperation : NSOperation

-(instancetype)initWithPath:(NSString *)path;
-(instancetype)initWithImage:(UIImage *)img;





@property (nonatomic,strong) NSURLSessionDataTask *myTast;
@property (nonatomic,assign) BOOL isFinish;

@property (nonatomic,assign) id delegate;
@property (nonatomic,strong) NSString *curPath;
@property (nonatomic,strong) UIImage *curImg;


-(void)cancelTask;

@end
