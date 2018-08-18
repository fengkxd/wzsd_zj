//
//  UploadManager.h
//  tea
//
//  Created by fengke on 16/2/27.
//  Copyright © 2016年 com.xhhc. All rights reserved.
//

#define  kNotification_UploadFileFinish  @"kNotification_UploadFileFinish"

#import <Foundation/Foundation.h>
#import "UploadOperation.h"



@interface UploadManager : NSObject{
    NSOperationQueue *myOperationQueue;
}
@property (nonatomic,strong) NSMutableArray *ids;

-(void)uploadFileWithPaths:(NSArray *)paths;

-(void)uploadFileWithImgs:(NSArray *)imgs;


+(UploadManager *) sharedInstance;
//暂停所有下载
-(void)cancelAllOperation;
//// 暂停下载
//-(void)cancelOperationKey:(NSString *)fid;
////查找是否正在下载中
//-(BOOL)findOperation:(NSString *)fid;


@end
