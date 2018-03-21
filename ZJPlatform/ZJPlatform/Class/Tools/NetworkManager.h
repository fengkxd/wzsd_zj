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

static NSString *const  ProxyUrl                                  =   @"http://app.longqingshiyi.cn/longshihui/a";
static NSString *const  ShareProxy                                =   @"http://app.longqingshiyi.cn/longshihui";


//

static NSString *const  kRequest_IOSPay                  =      @"/interface/iosPay";

//游客登录
static NSString *const  kRequest_LoginByIos              =      @"/interface/LoginByIos";

static NSString *const  kRequest_LoginByDiSanFang                    =      @"/interface/LoginByDiSanFang";
static NSString *const  kRequest_RegisterBySanFang                   =      @"/interface/RegisterBySanFang";

//登录
static NSString *const  kRequest_LoginByPassword                     =      @"/interface/LoginByPassword";
//退出登录
static NSString *const  kRequest_Logout                              =      @"/interface/logout";

//修改手机号
static NSString *const  kRequest_AppChangeMobileNo                   =      @"/interface/AppChangeMobileNo";

//验证码发送
static NSString *const  kRequest_SendMobileCode                      =      @"/interface/SendMobileCode";
//注册
static NSString *const  kRequest_Register                            =      @"/interface/Register";
static NSString *const  kRequest_ForgetPwd                           =      @"/interface/ForgetPwd";


//首页banner
static NSString *const  kRequest_Banner                              =      @"/interface/banner";
//首页帖子
static NSString *const  kRequest_PostList                            =      @"/interface/postList";
//上传图片
static NSString *const  kRequest_SaveFile                            =      @"/interface/picUpload";
//关注的圈子
static NSString *const  kRequest_Circle                              =      @"/interface/circle";
//发布帖子
static NSString *const  kRequest_PostPublish                         =      @"/interface/postPublish";
//是否关注
static NSString *const  kRequest_CircleFocus                         =      @"/interface/circleFocus";
//设备注册推送
static NSString *const  kRequest_AppResgistrationSet                 =      @"/interface/registrationSet";
static NSString *const  kRequest_AppResgistrationCancel              =      @"/interface/registrationCancel";

//删除帖子
static NSString *const  kRequest_PostDelete                          =      @"/interface/postDelete";
//举报帖子
static NSString *const  kRequest_PostAccuse                          =      @"/interface/postAccuse";


//所有的包括课程帖子评论圈子用户关注classes：post帖子，circle圈子，comment评论，user关注用户
//type：like点赞 focus关注 collect收藏
static NSString *const  kRequest_Related                             =      @"/interface/Related";
//发表评论
static NSString *const  kRequest_CommentOrReplyPublish               =      @"/interface/commentOrReplyPublish";
//评论列表
static NSString *const  kRequest_CommentOrReply                      =      @"/interface/commentOrReply";
//删除评论
static NSString *const  kRequest_commentDelete                       =      @"/interface/commentDelete";

//课程
static NSString *const  kRequest_Course                              =      @"/interface/course";
//课程首页
static NSString *const  kRequest_CourseHome                          =      @"/interface/courseHome";
//考试列表
static NSString *const  kRequest_Exam                                =      @"/interface/exam";
//报名考试
static NSString *const  kRequest_ExamApply                           =      @"/interface/examApply";
//报名等级
static NSString *const  kRequest_ExamLevel                           =      @"/interface/examLevel";
//微信支付
static NSString *const  kURL_WechatPay                               =      @"/interface/wechatPay";
//ali支付
static NSString *const  kURL_AliPay                                  =      @"/interface/aliPay";
//vip详情
static NSString *const  kURL_VIPDetail                               =      @"/interface/vipDetail";
//用户详情
static NSString *const  kURL_UserDetail                              =      @"/interface/userDetail";
//用户发布的动态
static NSString *const  kURL_UserDynamic                             =      @"/interface/userDynamic";
//用户关注的圈子
static NSString *const  kURL_UserFocusCircle                         =      @"/interface/userFocusCircle";
//播放次数
static NSString *const  kURL_WatchNum                                =      @"/interface/watchNum";

//报名详情
static NSString *const  kRequest_ExamineeInfo                        =      @"/interface/examineeInfo";
//取消报名
static NSString *const  kRequest_ExamCencel                          =      @"/interface/examCancel";
//活动列表
static NSString *const  kRequest_CompetitionList                     =      @"/interface/competitionList";
//报名队伍
static NSString *const  kRequest_TeamList                            =      @"/interface/teamList";
//验证VIP
static NSString *const  kRequest_ValidateVip                         =      @"/interface/validateVip";
//更新上传签名
static NSString *const  kRequest_UploadSign                          =      @"/interface/uploadSign";
//报名接口
static NSString *const  kRequest_CompetitionApply                    =      @"/interface/competitionApply";
//作品列表
static NSString *const  kRequest_CompetitionVideo                    =      @"/interface/competitionVideo";
//作品详情
static NSString *const  kRequest_VotePlay                            =      @"/interface/videoPlay";
//投票
static NSString *const  kRequest_VideoVote                           =      @"/interface/videoVote";
//套餐
static NSString *const  kRequest_VipPlan                             =      @"/interface/vipPlan";
//创建订单
static NSString *const  kRequest_CreateOrder                         =      @"/interface/createOrder";

//个人资料
static NSString *const  kURL_UserInformation                        =      @"/interface/userInformation";
//修改个人资料
static NSString *const  kURL_UserInfoEdit                           =      @"/interface/userInfoEdit";
//修改密码
static NSString *const  kURL_ModifyPwd                              =      @"/interface/ModifyPwd";
//个人动态
static NSString *const  kURL_MyDynamic                              =      @"/interface/MyDynamic";
//收藏的帖子
static NSString *const  kURL_CollectPost                            =      @"/interface/collectPost";
//收藏视频
static NSString *const  kURL_CollectCourse                          =      @"/interface/collectCourse";
//我的考证记录
static NSString *const  kURL_MyExam                                 =      @"/interface/myExam";
//我的作品
static NSString *const  kURL_MyVideo                                =      @"/interface/myVideo";
//我的投票
static NSString *const  kURL_MyVideoVote                            =      @"/interface/myVideoVote";
//我的VIP
static NSString *const  kURL_MyVIP                                  =      @"/interface/myVip";
//充值记录
static NSString *const  kURL_MyVipRecord                            =      @"/interface/vipRecord";

//认证请求
static NSString *const  kURL_QualificationList                      =      @"/interface/qualificationList";
//提交认证
static NSString *const  kURL_QualificationApply                     =      @"/interface/qualificationApply";
//认证详情
static NSString *const  kURL_Qualification                          =      @"/interface/qualification";
//取消认证
static NSString *const  kURL_QualificationCancel                    =      @"/interface/qualificationCancel";
//获取年审年份详情
static NSString *const  kURL_Annual                                 =      @"/interface/annual";
//提交年审资料
static NSString *const  kURL_AnnualApply                            =      @"/interface/annualApply";
//意见反馈
static NSString *const  kURL_Suggest                                =      @"/interface/suggest";



//请求消息
static NSString *const  kURL_Message                                =      @"/interface/message";
//消息提醒状态
static NSString *const  kURL_SettingMsg                             =      @"/interface/setting";
//设置消息提醒状态
static NSString *const  kURL_SettingUpdata                          =      @"/interface/settingUpdata";
//被@ 提醒
static NSString *const  kURL_MessageReply                           =      @"/interface/messageReply";
//评论消息
static NSString *const  kURL_MessageComm                            =      @"/interface/messageComm";
//点赞消息
static NSString *const  kURL_MessageLike                            =      @"/interface/messageLike";
//公告
static NSString *const  KURL_NoticeInfo                             =      @"/interface/NoticeInfo";

//公告信息
static NSString *const  kURL_NoticeInfoHtml                         =      @"/busi/staticHtml/noticeInfoHtml";
//关于我们
static NSString *const  kURL_AboutUsHtml                            =      @"/busi/staticHtml/aboutUsHtml";
//协议管理
static NSString *const  kURL_ProtocolHtml                           =      @"/busi/staticHtml/protocolHtml";
//年审介绍
static NSString *const  kURL_ExaminedHtml                           =      @"/busi/staticHtml/examinedHtml";
//帮助中心
static NSString *const  kURL_FaqHtml                                =      @"/busi/staticHtml/faqHtml";



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
