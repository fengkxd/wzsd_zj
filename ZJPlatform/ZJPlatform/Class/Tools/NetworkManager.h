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

static NSString *const  ProxyUrl                                  =   @"http://admin.tect365.com.cn/api";
static NSString *const  ImgProxyUrl                                =   @"http://admin.tect365.com.cn";


#pragma mark

static NSString *const  kRequest_subjects_secondLevel          = @"/subjects/secondLevel";


#pragma mark 考试指南
//获得标题信息
static NSString *const  kRequest_testtitle_findGet                       =      @"/testtitle/findGet";
//标题子列表 testvalues/list
static NSString *const  kRequest_testvalues_list                         =      @"/testvalues/list";
//子列表详情信息 testvalues/get
static NSString *const  kRequest_testvalues_get                          =      @"/testvalues/get";

#pragma mark 中教名师
//名师列表
static NSString *const  kRequest_famousTeacher_queryList                  =      @"/famousTeacher/queryList";







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
