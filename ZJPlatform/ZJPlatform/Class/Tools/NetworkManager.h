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




static NSString *const  ProxyUrl                                  =   @"http://admin.tect365.com.cn/api";
static NSString *const  ImgProxyUrl                                =   @"http://admin.tect365.com.cn";



//登陆
static NSString *const  kRequest_signin                            = @"/signin";
//获取用户信息
static NSString *const  kRequest_member_getMemberMessage           = @"/member/getMemberMessage";
//banner
static NSString *const  kRequest_adv_list                          = @"/adv/list";


static NSString *const  kRequest_identifyingCode      =   @"/identifyingCode";

static NSString *const  kRequest_signup      =   @"/signup";



#pragma mark

static NSString *const  kRequest_subjects_secondLevel          = @"/subjects/secondLevel";

static NSString *const  kRequest_video_list                       = @"/course/list";
static NSString *const  kRequest_video_details                    = @"/course/details";
static NSString *const  kRequest_studyduration_save                    = @"/studyduration/save";




static NSString *const  kRequest_catalogue_list                    = @"/catalogue/list";
static NSString *const  kRequest_comment_list                    = @"/comment/list";
static NSString *const  kRequest_newsbulletin_findList         = @"/newsbulletin/findList";


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



static NSString *const  kRequest_sysDict_list                  =      @"/sysDict/list";

static NSString *const  kRequest_newsInformation_list          =      @"/newsInformation/list";
static NSString *const  kRequest_newsInformation_get           =      @"/newsInformation/get";


//学生优惠券
static NSString *const  kRequest_coupon_list             =      @"/coupon/list";
static NSString *const  kRequest_studyduration_list      =     @"/studyduration/list";
static NSString *const  kRequest_orders_list              =     @"/orders/list";
static NSString *const  kRequest_comment_findSelf            =     @"/comment/findSelf";
static NSString *const  kRequest_comment_delete           =     @"/comment/delete";

//考试
static NSString *const  kRequest_subjects_eProject             =      @"/subjects/eProject";
static NSString *const  kRequest_testPaper_list               =      @"/testPaper/list";

static NSString *const  kRequest_questions_consolidation      =      @"/questions/consolidation";

static NSString *const  kRequest_testPaper_get                =      @"/testPaper/get";
static NSString *const  kRequest_memberAnswer_verifying       =      @"/memberAnswer/verifying";
static NSString *const  kRequest_questions_everyDayStudy       =      @"/questions/everyDayStudy";
static NSString *const  kRequest_everydayPractise_updateupdateAnswer       =      @"/everydayPractise/updateupdateAnswer";


static NSString *const  kRequest_membererror_list             =      @"/membererror/list";
static NSString *const  kRequest_testPaper_queryMemberTest       =      @"/testPaper/queryMemberTest";

static NSString *const  kRequest_questions_verifying       =      @"/questions/verifying";

static NSString *const  kRequest_student_updateStudent       =      @"/student/updateStudent";


static NSString *const  kRequest_member_updatePassword       =      @"/member/updatePassword";



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
