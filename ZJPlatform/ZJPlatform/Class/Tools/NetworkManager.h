//
//  NetworkManager.h
//  tea
//
//  Created by fengke on 16/1/18.
//  Copyright © 2016年 com.xhhc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFHTTPSessionManager.h"

#define WX_TOKEN  @"WX_TOKEN"


//static NSString *const  ProxyUrl                                 =   @"http://192.168.1.107:8007/longshihui/a";
//static NSString *const  ProxyUrl                                 =   @"http://39.108.102.49:8007/longshihui/a";
//static NSString *const  ShareProxy                               =   @"http://39.108.102.49:8007/longshihui";

static NSString *const  ProxyUrl                                  =   @"https://www.szwzsd.com/api";
static NSString *const  ShareProxy                                =   @"http://app.longqingshiyi.cn/longshihui";


//验证码发送
static NSString *const  kRequest_Scaptcha_New                  =      @"/captcha/new";





@interface NSString (URL)
- (NSString *)URLEncodedString;
@end

@interface NetworkManager : NSObject{
    
}


// 网络可达性
- (BOOL)isReachability;


+ (instancetype) shareNetworkingManager;

-(BOOL)findTask:(NSString *)url;

-(void)cancelTask:(NSString *)url;

/**
 根据条件进行网络请求
 @param method  请求方式 如GET，PUT，POST，Delete
 @param headDic http头参数
 @param bodyDic body参数
 @param url     相对路径
 @param success block对象 responseObject 请求成功时，返回的数据
 @param failure block对象 error 请求失败时的状态信息
 @return
 *******************************************/
- (NSURLSessionTask *)requestWithMethod:(NSString *)method
                          headParameter:(NSDictionary *)headDic
                          bodyParameter:(NSDictionary *)bodyDic
                           relativePath:(NSString *)url
                                success:(void (^)(id responseObject))success
                                failure:(void (^)(NSString *errorMsg))failure;





@end
