//
//  UploadManager.m
//  tea
//
//  Created by fengke on 16/2/27.
//  Copyright © 2016年 com.xhhc. All rights reserved.
//

#import "UploadManager.h"
#import "JSONKit.h"

@implementation UploadManager
static UploadManager *sharedInstance;
static dispatch_once_t onceToken;

-(instancetype)init{
    self = [super init];
    if (self) {
        myOperationQueue = [[NSOperationQueue alloc] init];
        [myOperationQueue setMaxConcurrentOperationCount:2];
        self.ids = [NSMutableArray array];
    }
    return self;
}

//单例
+(UploadManager *)sharedInstance
{
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
        
    });
    return sharedInstance;
}

-(void)uploadFileWithPaths:(NSArray *)paths{
    
    for (NSInteger i = 0;i <[paths count]; i++) {
//    for (NSInteger i = 0;i <[paths count]; i++) {
        NSString *path = [paths objectAtIndex:i];
        UploadOperation *operation = [[UploadOperation alloc] initWithPath:path];
        operation.delegate = self;
        [myOperationQueue setMaxConcurrentOperationCount:1];
        [myOperationQueue addOperation:operation];
    }
}

-(void)uploadFileWithImgs:(NSArray *)imgs{
    
 //    for (NSInteger i = [imgs count] -1 ; i >= 0 ; i--) {
    for (NSInteger i = 0;i <[imgs count]; i++) {
        UIImage *img = [imgs objectAtIndex:i];
//        UploadOperation *operation = [[UploadOperation alloc] initWithPath:img];
        UploadOperation *operation = [[UploadOperation alloc] initWithImage:img];
        operation.delegate = self;
        [myOperationQueue setMaxConcurrentOperationCount:1];
        [myOperationQueue addOperation:operation];
    }


}




- (void)upload:(UploadOperation *)Download didStopWithError:(NSError *)error
{
    NSLog(@"error%@",error);
    if (myOperationQueue.operationCount == 1) {
        [[NSNotificationCenter defaultCenter] postNotificationName:kNotification_UploadFileFinish object:nil];
        self.ids = [NSMutableArray array];
    }
}

- (void)upload:(UploadOperation *)operation didFinishWithSuccessWithPath:(NSString *)pathToFile withObject:(id)responseObject
{
    
 
    if ([responseObject isKindOfClass:[NSData class]]) {
        NSDictionary *dict = [[[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding] objectFromJSONString];
        
        NSString *keyId = [[dict objectForKey:@"data"] objectForKey:@"url"];
        [self.ids addObject:keyId];
    }
    if (myOperationQueue.operationCount == 1 && [self.ids count]) {
        [[NSNotificationCenter defaultCenter] postNotificationName:kNotification_UploadFileFinish object:self.ids];
        self.ids = [NSMutableArray array];
    }
}


-(void)cancelAllOperation{
    [myOperationQueue cancelAllOperations];
}



@end
