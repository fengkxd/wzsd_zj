//
//  CNCMediaPlayerComDef.h
//  CNCMediaPlayerFramework
//
//  Created by Hjf on 16/8/11.
//  Copyright © 2016年 CNC. All rights reserved.
//

#ifndef CNCMediaPlayerComDef_h
#define CNCMediaPlayerComDef_h

#ifndef __OPTIMIZE__
#define CNC_MP_NSLog(...) NSLog(__VA_ARGS__)
#else
#define CNC_MP_NSLog(...) {}
#endif

#ifdef __cplusplus
#define CNC_EXTERN extern "C" __attribute__((visibility ("default")))
#else
#define CNC_EXTERN extern __attribute__((visibility ("default")))
#endif

/// 准备好播放
CNC_EXTERN NSString * const CNCMediaPlayerLoadDidPrepareNotification;

/// 播放状态改变
CNC_EXTERN NSString * const CNCMediaPlayerPlayStateDidChangeNotification;
/// 当前播放状态
CNC_EXTERN NSString * const CNCMediaPlayerPlayStateDidChangeUserInfoKey;

/// 加载状态改变
CNC_EXTERN NSString * const CNCMediaPlayerLoadStateDidChangeNotification;
/// 当前加载状态
CNC_EXTERN NSString * const CNCMediaPlayerLoadStateDidChangeUserInfoKey;

/// 播放结束
CNC_EXTERN NSString * const CNCMediaPlayerPlayDidFinishNotification;
/// 播放结束原因
CNC_EXTERN NSString * const CNCMediaPlayerPlayDidFinishUserInfoKey;

/// 视频比例改变
CNC_EXTERN NSString * const CNCMediaPlayerScalingModeDidChangeNotification;

/// 视频分辨率改变
CNC_EXTERN NSString * const CNCMediaPlayerResolutionChangedNotification;

/// 开启硬解
CNC_EXTERN NSString * const CNCMediaPlayerVideoDecoderOpenNotification;

/// 首帧视频渲染
CNC_EXTERN NSString * const CNCMediaPlayerFirstVideoFrameRenderedNotification;

/// 首帧音频渲染
CNC_EXTERN NSString * const CNCMediaPlayerFirstAudioFrameRenderedNotification;

/// seek成功并结束
CNC_EXTERN NSString * const CNCMediaPlayerDidSeekCompleteNotification;

/// 鉴权成功
CNC_EXTERN NSString * const CNCMediaPlayerSDKInitDidFinishNotification;

/// 播放器状态通知
CNC_EXTERN NSString * const CNCMediaPlayerStatusCodeNotification;
/// 当前播放器状态
CNC_EXTERN NSString * const CNCMediaPlayerStatusKey;

/// 播放器释放完成
CNC_EXTERN NSString * const CNCMediaPlayerDidShutdown;

/// HTTP协议视频请求返回值通知
CNC_EXTERN NSString * const CNCMediaPlayerHTTPRCodeNotification;
/// HTTP协议视频请求返回值
CNC_EXTERN NSString * const CNCMediaPlayerHTTPRcodeKey;

/// 录制状态通知
CNC_EXTERN NSString * const CNCMediaPlayerRecordingStatusCodeNotification;
/// 当前录制状态
CNC_EXTERN NSString * const CNCMediaPlayerRecordingStatusKey;

/// 录制通知附带码
CNC_EXTERN NSString * const CNCMediaPlayerDetailCode;

/// 录制成功与录制失败的具体原因
CNC_EXTERN NSString * const CNCMediaPlayerRecordInfo;

/// 录制结束时的录制文件名称
CNC_EXTERN NSString * const CNCMediaPlayerRecordFileName;

/// 录制结束时的视频时长
CNC_EXTERN NSString * const CNCMediaPlayerRecordDuration;

/// sei通知
CNC_EXTERN NSString * const CNCMediaPlayerWSCustomSEINotification;
/// sei通知的相关数据字段
CNC_EXTERN NSString * const CNCMediaPlayerWSCustomSEI;

/// hls播放相关通知
CNC_EXTERN NSString * const CNCMediaPlayerHLSNotification;
/// hls首次播放播放码率
CNC_EXTERN NSString * const CNCMediaPlayerFirstHLSBitrate;
/// hls当前播放码率
CNC_EXTERN NSString * const CNCMediaPlayerCurrentHLSBitrate;
/// hls多码率列表
CNC_EXTERN NSString * const CNCMediaPlayerHLSBitrateList;
/// hls多码率-开始播放新码率视频
CNC_EXTERN NSString * const CNCMediaPlayerHLSChangeBitrate;



/**
 *  SDK类型，full为完整版本，live为简洁版本
 */
typedef NS_ENUM(NSInteger, CNCMediaPlayerSDKType) {
    /**
     *  完整版本，支持较多协议和视频格式
     */
    CNC_Media_Player_SDK_Full = 0,
    /**
     *  简洁版本，适用于直播
     */
    CNC_Media_Player_SDK_Live,
};

/**
 *  播放器状态
 */
typedef NS_ENUM(NSInteger, CNCMediaPlayerbackState) {
    /**
     *  停止
     */
    CNC_PLAYER_STATE_ON_MEDIA_STOP              = 0,
    /**
     *  开始播放
     */
    CNC_PLAYER_STATE_ON_MEDIA_START             = 1,
    /**
     *  暂停播放
     */
    CNC_PLAYER_STATE_ON_MEDIA_PAUSE             = 3,
    /**
     *  快进
     */
    CNC_PLAYER_STATE_ON_MEDIA_SEEKING_FORWARD   = 4,
};

/**
 *  播放器加载状态
 */
typedef NS_ENUM(NSInteger, CNCMediaLoadstate) {
    /**
     *  加载错误
     */
    CNC_MEDIA_LOAD_STATE_UNKNOWN        = 0,
    /**
     *  可播放
     */
    CNC_MEDIA_LOAD_STATE_PLAYABLE       = 1,
    /**
     *  播放中
     */
    CNC_MEDIA_LOAD_STATE_PLAYTHROUGHOK  = 2,
    /**
     *  缓冲中
     */
    CNC_MEDIA_LOAD_STATE_STALLED        = 3
};


/**
 *  播放器解码模式
 */
typedef NS_ENUM(NSInteger, CNCMediaVideoDecoderMode) {
    /**
     *  软解
     */
    CNC_VIDEO_DECODER_MODE_SOFTWARE = 0,
    /**
     *  硬解
     */
    CNC_VIDEO_DECODER_MODE_HARDWARE = 1,
    /**
     *  自动（iOS8及以上为硬解，以下为软解
     */
    CNC_VIDEO_DECODER_MODE_AUTO     = 2
};

/**
 *  播放器结束原因
 */
typedef NS_ENUM(NSInteger, CNCMediaPlayerDidFinish) {
    /**
     * 视频播放结束
     */
    CNC_MEDIA_PLAYER_DID_FINISH_END       = 0,
    /**
     *  视频播放出错
     */
    CNC_MEDIA_PLAYER_DID_FINISH_ERROR     = 1
};

/**
 *  播放器显示模式
 */
typedef NS_ENUM(NSInteger, CncMpVideoScalingMode){
    /**
     *  以原比例适配画布
     */
    CNC_MP_VIDEO_SCALE_MODE_ASPECTFIT  = 0,
    /**
     *  以原比例填充画布
     */
    CNC_MP_VIDEO_SCALE_MODE_ASPECTFILL = 1,
    /**
     *  非原比例填充画布
     */
    CNC_MP_VIDEO_SCALE_MODE_FILL       = 2,
    /**
     *  非原比例16：9
     */
    CNC_MP_VIDEO_SCALE_MODE_16_9       = 3,
    /**
     *  非原比例4：3
     */
    CNC_MP_VIDEO_SCALE_MODE_4_3        = 4
};


/**
 *  播放器播放模式
 */
typedef NS_ENUM(NSInteger, CNCMediaPlayerMode) {
    /**
     *   点播
     */
    CNC_MEDIA_PLAYER_MODE_VOD     = 0,
    /**
     *  直播
     */
    CNC_MEDIA_PLAYER_MODE_LIVE    = 1
};

/**
 *  播放器相关返回码
 */
typedef NS_ENUM(NSUInteger, CNC_MediaPlayer_ret_Code) {
    /**
     *  成功
     */
    CNC_MediaPlayer_RCode_Success                   = 0,
    /**
     *  SDK正在初始化
     */
    CNC_MediaPlayer_RCode_Com_SDK_Doing_Init        = 1000,
    /**
     *  无法解析url
     */
    CNC_MediaPlayer_RCode_Player_Unresolved_URL     = 1108,
    /**
     *  url解析失败
     */
    CNC_MediaPlayer_RCode_Parse_URL_Failed          = 1109,
    /**
     *  服务器连接失败
     */
    CNC_MediaPlayer_RCode_Player_Connect_Server_Failed = 1105,
    /**
     *  代理接口连接失败 Proxy port connect failed
     */
    CNC_MediaPlayer_RCode_Proxy_Port_Connect_Failed = 1116,
    
    //用户鉴权 错误级别返回码
    /**
     *   正在鉴权中…
     */
    CNC_MediaPlayer_RCode_Auth_Authorizing          = 2001,
    /**
     *  过期
     */
    CNC_MediaPlayer_RCode_Auth_OutOfDate            = 2101,
    /**
     *  SDK版本过低
     */
    CNC_MediaPlayer_RCode_Auth_Ver_OutOfDate        = 2102,
    /**
     *  SDK类型不匹配
     */
    CNC_MediaPlayer_RCode_Auth_SDK_Not_Match        = 2103,
    /**
     *  AppID类型不匹配
     */
    CNC_MediaPlayer_RCode_Auth_AppID_Not_Match      = 2104,
    /**
     *   authKey不匹配
     */
    CNC_MediaPlayer_RCode_Auth_AuthKey_Failed       = 2105,
    /**
     *  鉴权服务器响应错误
     */
    CNC_MediaPlayer_RCode_Auth_Srv_Response_Error   = 2151,
    /**
     *  未知鉴权错误
     */
    CNC_MediaPlayer_RCode_Auth_Unknown_Error        = 2199,
    /**
     *  请求成功
     */
    CNC_MediaPlayer_RCode_Player_Request_Success    = 5401,
    /**
     *  切换至软解码器
     */
    CNC_MediaPlayer_RCode_Player_SW_Decoder_Switched_on = 5441,
    /**
     *  播放器初始失败
     */
    CNC_MediaPlayer_RCode_Player_Initialization_Failed  = 3401,
    /**
     *  请求数据超时
     */
    CNC_MediaPlayer_RCode_Player_Runtime_request_For_Media_Data = 3403,
    /**
     * 硬解初始化失败
     */
    CNC_MediaPlayer_RCode_Decode_HW_Decoder_Initialization_Failed = 3441,
    /**
     *  软解初始化失败
     */
    CNC_MediaPlayer_RCode_Decode_SW_Decoder_Initialization_Failed = 3442,
    /**
     *   视频解码失败
     */
    CNC_MediaPlayer_RCode_Decode_Video_Decoding_Failed = 3443,
    /**
     * 音频解码失败
     */
    CNC_MediaPlayer_RCode_Decode_Audio_Decoding_Failed = 3444,
    /**
     *  录制结束附带录制时长
     */
    CNC_MediaPlayer_Rcode_Record_Complete = 1002,
    /**
     *  录制成功
     */
    CNC_MediaPlayer_Rcode_Record_Succeed = 1003,
    /**
     *  录制失败
     */
    CNC_MediaPlayer_Rcode_Record_Failed = 1110,
    /**
     *   录制视频空间不够
     */
    CNC_MediaPlayer_Rcode_Not_Enough_Freedisk = 1114,
    /**
     * 存储路径无效
     */
    CNC_MediaPlayer_Rcode_Invalid_Storage_Path = 1501,
    /**
     *  截图失败
     */
    CNC_MediaPlayer_Rcode_Screenshot_failed = 1113
    
    
    /// 录制时间低于阈值
//    CNC_MediaPlayer_Rcode_Record_Lessthan_Min_Time = 1111,//录制时间低于阈值
    /// 录制超过最大阈值
//    CNC_MediaPlayer_Rcode_Record_over_Max_Time = 1112,//录制时间超过阈值
    
    
//    /// 录制期间进程异常
//    CNC_MediaPlayer_Rcode_Record_UNEXCEPTION = 1203,
//    /// 录制期间网络中断
//    CNC_MediaPlayer_Rcode_Record_network_interrupt = 1204,
//    /// 录制异常结束 收到stop packet
//    CNC_MediaPlayer_Rcode_Recording_Stop_Packet = 1208,
//    /// 录制异常结束 时间戳错误
//    CNC_MediaPlayer_Rcode_Recording_TS_Err = 1209,
//    /// 录制异常结束 时间戳修正错误
//    CNC_MediaPlayer_Rcode_Recording_TS_Discontiguous_Err = 1210,
//    /// 录制异常结束 帧写入失败
//    CNC_MediaPlayer_Rcode_Recording_Frame_write_fail = 1211,
//    /// 录制异常结束 队列读取帧失败
//    CNC_MediaPlayer_Rcode_Recording_Frame_Queue_fail = 1212,
//    /// 录制异常结束 时间戳修正失败或者帧写入失败
//    CNC_MediaPlayer_Rcode_Recording_TS_Discontiguous_Err_Or_Frame_write_fail = 1213,
    // 未定义错误码
    
    
    
    /// 没有该文件
//    CNC_MediaPlayer_Rcode_Player_URL_Error = 1
};

/**
 *  日志状态返回码
 */
typedef NS_ENUM(NSUInteger, CNC_MediaPlayer_LogSystem_Err_code) {
    /**
     *  日志写入成功
     */
    CNC_MediaPlayer_LogSystem_Success = 0,
    /**
     *  日志写入失败，空间已满
     */
    CNC_MediaPlayer_LogSystem_Err_Disk_Not_Enough = 1,
    /**
     *  日志写入失败，未知错误
     */
    CNC_MediaPlayer_LogSystem_Err_Unknown
};


/**
 *   log等级状态码
 */
typedef NS_ENUM(NSUInteger, CNC_MediaPlayer_Loglevel) {
    /**
     *  debug模式
     */
    CNC_MediaPlayer_Loglevel_Debug = 0,
    /**
     *  warn模式
     */
    CNC_MediaPlayer_Loglevel_Warn    = 1,
    /**
     *  silent模式
     */
    CNC_MediaPlayer_Loglevel_SILENT  = 2
};


typedef NS_ENUM(NSUInteger, CNC_MediaPlayer_Screen_Record_Type) {
    CNC_MediaPlayer_Screen_Record_Type_AVS = 0,           录屏模式
};


/**
 *   录制/录屏结束原因
 */
typedef NS_ENUM(NSUInteger, CNC_MediaPlayer_Record_Info) {
    /**
     *  正常录制成功
     */
    CNC_MediaPlayer_Record_Info_Normal = 0,
    /**
     *  后台挂起导致录制结束
     */
    CNC_MediaPlayer_Record_Info_Suspend,
    /**
     *  超过录制最长时间上限
     */
    CNC_MediaPlayer_Record_Info_Period_Exceeds,
    /**
     *  IO错误
     */
    CNC_MediaPlayer_Record_Info_IO_Error,
    /**
     *  磁盘空间已满
     */
    CNC_MediaPlayer_Record_Info_Disk_Full,
    /**
     *  小于录制最短时间下限
     */
    CNC_MediaPlayer_Record_Info_Period_Not_Enough,
    /**
     *  播放结束
     */
    CNC_MediaPlayer_Record_Info_Play_End,
    /**
     *  播放器关闭
     */
    CNC_MediaPlayer_Record_Info_Player_Close,
    /**
     *  参数错误
     */
    CNC_MediaPlayer_Record_Info_Parameter_Error,
    /**
     *  未知错误
     */
    CNC_MediaPlayer_Record_Info_Unknown
};


/**
 *   停止录制原因
 */
typedef NS_ENUM(NSUInteger, CNC_MediaPlayer_Stop_Record_Type) {
    /**
     *  正常停止
     */
    CNC_MediaPlayer_Stop_Record_Type_Normal = 0,
    /**
     *  播放器重载
     */
    CNC_MediaPlayer_Stop_Record_Type_Reload
};

#endif /* CNCMediaPlayerComDef_h */
