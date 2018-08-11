//
//  CNCMediaPlayerSDK.h
//  CNCMediaPlayer
//
//  Created by Chen on 2016/12/5.
//  Copyright © 2016年 Chinanetcenter. All rights reserved.
//  Public

#import <Foundation/Foundation.h>
#import "CNCMediaPlayerComDef.h"

@interface CNCMediaPlayerSDK : NSObject

#pragma mark- 鉴权
/*! @brief 向CNC注册第三方应用。
 *
 * 需要在每次启动第三方应用程序时调用， 此接口为同步接口 网络情况不好时 可能会耗时较长。
 
 * @param   appid    CNC分配给客户的ID
 authKey  CNC分配给客户的key
 * @return 详见错误码CNC_MediaPlayer_ret_Code定义。
 */
+ (CNC_MediaPlayer_ret_Code)regist_app:(NSString *_Nonnull)app_id auth_key:(NSString *_Nonnull)auth_key;

/*! @brief 向CNC注册第三方应用。
 *
 * 需要在每次启动第三方应用程序时调用， 此接口为异步接口 请在调用前监听CNCMediaPlayerSDKInitDidFinishNotification 消息 将返回结果的 NSNotification中的object对象从NSNumber转化为CNC_Ret_Code 错误信息详见错误码CNC_Ret_Code定义 。
 * @param   appid    CNC分配给客户的ID
 authKey  CNC分配给客户的key
 * @return 无。
 */
+ (void)async_regist_app:(NSString *_Nonnull)app_id auth_key:(NSString *_Nonnull)auth_key;


#pragma mark- 日志系统
/*! @brief 打开or关闭日志系统。
 *
 * 打开日志系统会将某些关键步骤的日志存储在设备当中。
 * @param   open    是否开启，开启后本次运行的某些关键步骤日志会被记录到设备当中。
 * @return 详见错误码CNC_MediaPlayer_LogSystem_Err_code定义。
 */
+ (CNC_MediaPlayer_LogSystem_Err_code)log_system_open:(BOOL) open;

/*! @brief 跳转到日志系统交互界面。
 *
 * 该界面展示log列表,并支持email发送到指定邮箱。
 * @return 无。
 */
+ (void) open_log_system_ui;

#pragma mark - 点播缓存设置
/*! @brief 开启点播缓存功能
 *
 * @param   open    是否开启点播缓存功能
 * @param   folderPath  点播缓存文件存放文件夹路径
 * @return 开启成功返回YES
 */
+ (BOOL)openLocalCache:(BOOL)open withFolderPath:(NSString *_Nullable)folderPath;

/*! @brief 设置点播缓存视频个数上限
 *
 * @param   cacheVideoCount    缓存视频个数上限
 * @return  无
 * @see setLocalCacheVideoSize:
 * @remark  该方法与setLocalCacheVideoSize:若同时设置，则优先生效setLocalCacheVideoSize:
 */
+ (void)setLocalCacheVideoCount:(NSUInteger)cacheVideoCount;

/*! @brief 设置点播缓存视频大小上限
 *
 * @param   cacheVideoSize    缓存视频大小上限
 * @return  无
 * @see setLocalCacheVideoCount:
 * @remark  该方法与setLocalCacheVideoCount:若同时设置，则优先生效setLocalCacheVideoSize:
 */
+ (void)setLocalCacheVideoSize:(NSUInteger)cacheVideoSize;

#pragma mark - 通用方法
/*! @brief 获取SDK类型
 *
 * @return 详见状态码CNCMediaPlayerSDKType定义。
 */
+ (CNCMediaPlayerSDKType)getSDKType;

/*! @brief 设置播放器声音为静音与否
 *
 * @param   mute    <=0 为非静音 || >0 为静音
 * @return  设置成功返回YES
 */
+ (BOOL)setPlyerMute:(int) mute;

/**
 设置全局参数
 
 @param value 数值
 @param key 键值
 @return 设置成功与否
 */

/*! @brief 设置全局参数
 *
 * @param value 数值
 * @param key 键值
 * @return 设置成功与否
 */
+ (BOOL)setOptionValue:(NSString *_Nullable)value forKey:(NSString *_Nullable)key;


//#pragma mark- 录屏
//
//+ (BOOL)showRecorderView:(nonnull id) recorderCtrlView;
//+ (BOOL)startRecordingWithHandler:(nullable void(^)(NSError * __nullable error))handler NS_DEPRECATED_IOS(9_0, 10_0);
//+ (BOOL)stopRecordingWithHandler:(nullable void(^)(NSObject * __nullable object, NSError * __nullable error))handler;
@end
