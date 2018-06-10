//
//  NetworkManager.m
//  tea
//
//  Created by fengke on 16/1/18.
//  Copyright © 2016年 com.xhhc. All rights reserved.
//




#import "NetworkManager.h"
#import "Toast.h"
#import "JSONKit.h"


@implementation NSString (URL)

- (NSString *)URLEncodedString
{
    NSString *encodedString = (NSString *)
    CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                              (CFStringRef)self,
                                                              (CFStringRef)@"!$&'()*+,-./:;=?@_~%#[]",
                                                              NULL,
                                                              kCFStringEncodingUTF8));
    return encodedString;
}
@end

@implementation NetworkManager

static NSMutableDictionary *taskDict;

+ (instancetype) shareNetworkingManager
{
    static NetworkManager *networkingManager = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        taskDict = [[NSMutableDictionary alloc] init];
        networkingManager = [[NetworkManager alloc] init];
    });
    return networkingManager;
}



- (BOOL)isReachability
{
    // 网络检测
    if ([AFHTTPSessionManager manager].reachabilityManager.networkReachabilityStatus == 0) {
        return NO;
    } else {
        return YES;
    }
}




- (NSURLSessionTask *)requestWithMethod:(NSString *)method
                          headParameter:(NSDictionary *)headDic
                          bodyParameter:(NSDictionary *)bodyDic
                           relativePath:(NSString *)url
                                success:(void (^)(id responseObject))success
                                failure:(void (^)(NSString *errorMsg))failure{
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    
    

    session.requestSerializer = [AFHTTPRequestSerializer serializer];
    session.requestSerializer.timeoutInterval = 15;
//    [session.requestSerializer setValue:@"text/html;charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    
    session.responseSerializer = [AFHTTPResponseSerializer serializer];
//    session.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];

    
    if ([method isEqualToString:@"GET"]){   //  GET 方式
        NSURLSessionTask *task = [session GET:url parameters:bodyDic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
            [taskDict removeObjectForKey:url];
            
            NSHTTPURLResponse *response = (NSHTTPURLResponse *)task.response;
            NSInteger code = response.statusCode;
            if (code == 200) {
                if ([responseObject isKindOfClass:[NSData class]]) {
                    id jsonObject = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
                    if ([jsonObject isKindOfClass:[NSDictionary class]]) {
                        if ([jsonObject objectForKey:@"data"]) {
                            success([jsonObject objectForKey:@"data"]);
                        }else{
                            failure(nil);
                        }
                    }
                }else{
                    if ([responseObject isKindOfClass:[NSDictionary class]]) {
                        if ([responseObject objectForKey:@"error"]) {
                            failure(nil);
                        }else if ([[responseObject objectForKey:@"meta"] isKindOfClass:[NSNull class]] ||[[responseObject objectForKey:@"meta"] isEqualToString:@"null"] ) {
                            success(responseObject);
                            
                        }else{
                            failure(nil);
                        }
                    }
                }
            }else if(code == 203){
                failure(nil);
                [[NSNotificationCenter defaultCenter] postNotificationName:kNotification_SHOW_LOGIN object:nil];
            }else{
                
                failure(nil);
            }
            
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
            [taskDict removeObjectForKey:url];
            failure(@"注册失败");
            
        }];
        [taskDict setObject:task forKey:url];
        return task;
    }else if ([method isEqualToString:@"POST"]){
        NSURLSessionTask *task = [session POST:url parameters:bodyDic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
            dispatch_async(dispatch_get_main_queue(), ^{
                [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
                
                NSHTTPURLResponse *response = (NSHTTPURLResponse *)task.response;
                NSInteger code = response.statusCode;
                if (code == 200) {
                    if ([responseObject isKindOfClass:[NSDictionary class]]) {
                        NSDictionary *dict = responseObject;
                        NSInteger errorCode = [[dict objectForKey:@"errorCode"] integerValue];
                        
                        if (errorCode == 9000) {
                            success([[responseObject objectForKey:@"data"] objectFromJSONString]);
                        }else if(errorCode == 9041 || errorCode == 9042){  //第三方登录
                            success([responseObject objectForKey:@"data"]);
                        }else if(errorCode == 9011 || errorCode == 9013){
                            
                            [self refreshAccessToken:^{
                                [self requestWithMethod:@"POST"
                                          headParameter:headDic
                                          bodyParameter:bodyDic
                                           relativePath:url
                                                success:success failure:false];
                            } failure:^{
                                failure([responseObject objectForKey:@"errorMessage"]);
                                [[NSNotificationCenter defaultCenter] postNotificationName:kNotification_SHOW_LOGIN object:nil];
                                
                            }];
                        }else if(errorCode == 9005 ){
                            [[NSNotificationCenter defaultCenter] postNotificationName:kNotification_SHOW_LOGIN object:nil];
                            failure([responseObject objectForKey:@"errorMessage"]);

                        }else if(errorCode == 9111 ){
                            failure(@"9111"); //支付验证
                        }else{
                            [Toast showWithText:[responseObject objectForKey:@"errorMessage"]];
                            
                            failure(nil);
                        }
                    }else if ([[responseObject objectForKey:@"error"] isKindOfClass:[NSDictionary class]]) {
                        [Toast showWithText:[responseObject objectForKey:@"errorMessage"]];
                        failure(nil);
                    }
                    
                }else if(code == 203){
                    [Toast showWithText:[responseObject objectForKey:@"errorMessage"]];
                    failure(nil);
                    [[NSNotificationCenter defaultCenter] postNotificationName:kNotification_SHOW_LOGIN object:nil];
                }else{
                    [Toast showWithText:[responseObject objectForKey:@"errorMessage"]];
                    failure(nil);
                }
                
                [taskDict removeObjectForKey:url];
            });
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
            dispatch_async(dispatch_get_main_queue(), ^{
                [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
                if (failure) {
                    failure(nil);
                }
                [Toast showWithText:@"网络请求失败"];
                [taskDict removeObjectForKey:url];
            });
            
        }];
        
        [taskDict setObject:task forKey:url];
        return task;
    }else if ([method isEqualToString:@"PUT"]){
        
        NSURLSessionTask *task = [session PUT:url parameters:bodyDic success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
            dispatch_async(dispatch_get_main_queue(), ^{
                [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
                
                NSHTTPURLResponse *response = (NSHTTPURLResponse *)task.response;
                NSInteger code = response.statusCode;
                if (code == 200) {
                    if ([responseObject isKindOfClass:[NSDictionary class]]) {
                        NSDictionary *dict = responseObject;
                        if ([[dict objectForKey:@"code"] integerValue] == 9) {//需要登录
                            //                            [self refreshAccessToken:^{
                            //                                [self requestWithMethod:@"POST"
                            //                                          headParameter:headDic
                            //                                          bodyParameter:bodyDic
                            //                                           relativePath:url
                            //                                                success:success failure:false];
                            //                            } failure:^{
                            //                                failure([dict objectForKey:@"message"]);
                            //                                if ([url rangeOfString:kNetworkGoodsCart].location != NSNotFound) {
                            //                                    [[NSNotificationCenter defaultCenter] postNotificationName:kNotification_SHOW_LOGIN object:nil];
                            //                                }
                            //                            }];
                            
                        }
                    }
                    success(responseObject);
                }else if(code == 203){
                    failure(nil);
                    [[NSNotificationCenter defaultCenter] postNotificationName:kNotification_SHOW_LOGIN object:nil];
                }else{
                    
                    failure(nil);
                }
                
                [taskDict removeObjectForKey:url];
            });
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
            dispatch_async(dispatch_get_main_queue(), ^{
                [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
                failure(nil);
                
                [taskDict removeObjectForKey:url];
            });
            
        }];
        
        [taskDict setObject:task forKey:url];
        return task;
    }
    return nil;
}


-(void)refreshAccessToken:(void (^)(void))success
                  failure:(void (^)(void))failure{
    if([Utility isNotBlank:[Utility objectForKey:USERNAME]] &&
             [Utility isNotBlank:[Utility objectForKey:PASSWORD]]){
        NSDictionary *dict = @{@"data":@{@"userName":[Utility objectForKey:USERNAME],@"password":[Utility objectForKey:PASSWORD]}};
        NSString *url = [NSString stringWithFormat:@"%@",ProxyUrl];
        [[NetworkManager shareNetworkingManager] requestWithMethod:@"POST"
                                                     headParameter:nil
                                                     bodyParameter:dict
                                                      relativePath:url success:^(id responseObject) {
                                                          NSString *userId = [dict objectForKey:@"userId"];
                                                          [Utility saveObject:userId withKey:KUID];
                                                          [Utility saveObject:[dict objectForKey:@"isVip"] withKey:ISVIP];

                                                          success();
                                                          
                                                      } failure:^(NSString *errorMsg) {
                                                          failure();
                                                      }];
    }else if([Utility isNotBlank:[Utility objectForKey:DeriverID]]){
        
        
        NSString *url = [NSString stringWithFormat:@"%@%@",ProxyUrl,ProxyUrl];
        NSDictionary *dict = @{@"data":@{@"iosDeriverId":[Utility objectForKey:DeriverID]}};
        [[NetworkManager shareNetworkingManager] requestWithMethod:@"POST"
                            headParameter:nil
                            bodyParameter:dict
                             relativePath:url
                                  success:^(id responseObject) {
                                      NSLog(@"第三方登录：%@",responseObject);
                                          [Utility saveObject:[responseObject objectForKey:@"userId"] withKey:KUID];
                                          [Utility saveObject:[dict objectForKey:@"isVip"] withKey:ISVIP];
                                        success();
                                  } failure:^(NSString *errorMsg) {
                                       failure();

                                  }];

    }
}





-(void)cancelTask:(NSString *)url{
    NSURLSessionTask *task = [taskDict objectForKey:url];
    if (task) {
        [task cancel];
    }
}

-(BOOL)findTask:(NSString *)url{
    NSURLSessionTask *task = [taskDict objectForKey:url];
    if (task) {
        return YES;
    }
    return NO;
}


@end
