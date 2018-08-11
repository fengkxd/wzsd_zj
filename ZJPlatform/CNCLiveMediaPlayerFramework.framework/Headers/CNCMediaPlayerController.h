//
//  CNCMediaPlayerController.h
//  CNCMediaPlayer
//
//  Created by Hjf on 16/9/22.
//  Copyright © 2016年 Chinanetcenter. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "CNCMediaPlayerComDef.h"



@interface CNCMediaPlayerController : NSObject


/**
 *  初始化 只能通过此方法创建播放器对象
 *
 *  @param url 播放的视频地址
 *  @return CNCMediaPlayerController对象
 */
- (instancetype _Nonnull )initWithContentURL:(NSURL *_Nonnull)url NS_DESIGNATED_INITIALIZER;

/**
 *  预准备播放
 *
 *  异步操作，成功则发出CNCMediaPlayerLoadDidPrepareNotification通知，也可通过isPrepareToPlay进行判断
 */
- (void)prepareToPlay;

/**
 *  播放
 */
- (void)play;

/**
 *  暂停
 */
- (void)pause;

/**
 *  停止
 */
- (void)stop;

/**
 *  销毁播放器
 */
- (void)shutdown;

/**
 *  重新拉流
 *
 *  @param contentURL 为nil时则默认为当前播放的contentURL
 *  @param fromstart  YES从头开始播放，NO继续播放
 */
- (void)reloadWithContentURL:(NSURL *)contentURL fromStart:(BOOL)fromstart;

/**
 *  是否开启秒开
 *
 *  @param  isopen      YES/NO， 需要在prepare之前设置
 */
- (void)accelerateOpen:(BOOL)isopen;

/**
 *  是否开启超级秒开
 *
 *  @param  isopen      YES/NO， 需要在prepare之前设置
 */
- (void)superAccelerate:(BOOL)isopen;

/**
 *  参数设置
 *
 *  暂不提供使用
 */
- (void)setOptionIntValue:(int64_t)value forKey:(NSString *)key;

/**
 *  日志控制
 *
 *  @param loglevel 详见CNC_MediaPlayer_Loglevel定义
 */
- (void)setLogLevel:(CNC_MediaPlayer_Loglevel)loglevel;

/**
 *  播放器view，渲染数据的载体
 */
@property (nonatomic, readonly) UIView  * _Nullable view;

/**
 *  播放状态，详见播放状态CNCMediaPlayerbackState定义
 */
@property (nonatomic, readonly) CNCMediaPlayerbackState   playbackState;

/**
 *  加载状态，详见加载状态CNCMediaLoadstate定义
 */
@property (nonatomic, readonly) CNCMediaLoadstate       loadState;

/**
 *  自动播放
 *
 *  1）YES：加载后自动开始播放 2）NO：加载后不播放，暂停状态
 */
@property (nonatomic) BOOL  shouldAutoPlay;

/**
 *  视频比例， 详见视频比例CncMpVideoScalingMode定义
 */
@property (nonatomic) CncMpVideoScalingMode   scalingMode;

/**
 *  当前播放视频时间点
 */
@property (nonatomic) NSTimeInterval    currentPlaybackTime;

/**
 *  视频时长
 *
 *  点播视频总时长，直播无该值
 */
@property (nonatomic, readonly) NSTimeInterval  duration;

/**
 *  可播放时长
 *
 *  该值永远小于等于duration
 */
@property (nonatomic, readonly) NSTimeInterval  playableDuration;

/**
 *  延时追赶
 *
 *  1）YES：当缓存大于maxCacheTime时，会清除内存临时缓存，以播放最新的数据 2）NO：关闭该功能
 */
@property (nonatomic, assign) BOOL shouldAutoClearCache;

/**
 *  低延时模式，仅供测试
 *
 *  暂不提供使用
 */
@property (nonatomic, assign) BOOL shouldLowLatencyMode;

/**
 *  可播放缓存时长
 *
 *  该值取视频和音频的最小缓存
 */
@property (nonatomic, readonly) NSTimeInterval  cacheDuration;

/**
 *  可播放视频缓存时长
 */
@property (nonatomic, readonly) NSTimeInterval  videoDuration;

/**
 *  可播放音频缓存时长
 */
@property (nonatomic, readonly) NSTimeInterval  audioDuration;

/**
 *  直播时的延时追赶时间
 *
 *  本地缓存cacheDuration超过maxCacheTime后，播放最新视频信息，单位是毫秒
 */
@property (nonatomic) NSTimeInterval    maxCacheTime;

/**
 *  缓冲时长
 *
 *  最低播放时长，即至少加载minBufferTime可进行播放，单位是毫秒
 */
@property (nonatomic) NSTimeInterval    minBufferTime;

/**
 *  缓存数据上限
 *
 *  视频本地临时缓存上限（位于内存），即加载至maxBufferSize达到饱和状态，单位是MB
 */
@property (nonatomic) NSTimeInterval    maxBufferSize;

/**
 *  解码方式，详见CNCMediaVideoDecoderMode定义
 */
@property (nonatomic) CNCMediaVideoDecoderMode  videoDecoderMode;

/**
 *  后台播放
 *
 *  1）YES允许后台播放  2）NO禁止后台播放
 */
@property (nonatomic) BOOL  ableVideoPlayingInBackground;

/**
 *  后台解码
 *
 *  允许后台播放下设置该变量生效，只针对软解，1）YES：程序在后台时，只进行音频解码，不进行视频解码 2）进入后台，音视频仍旧在解码
 */
@property (nonatomic) BOOL  disableVideoDecodeInBackground;


/**
 *  是否正在播放
 */
@property (nonatomic, readonly) BOOL    isPlaying;


/**
 *  是否停止播放
 */
@property (nonatomic, readonly) BOOL    isStop;

/**
 *  是否准备好播放
 */
@property (nonatomic, readonly) BOOL    isPrepareToPlay;

#pragma mark - 视频信息

/**
 *  视频格式
 */
@property (nonatomic, readonly) NSString *videoFormat;

/**
 *  视频编码格式
 */
@property (nonatomic, readonly) NSString *vcodec;

/**
 *  音频编码格式
 */
@property (nonatomic, readonly) NSString *acodec;

/**
 *  视频宽度
 */
@property (nonatomic, readonly) int      width;

/**
 *  视频高度
 */
@property (nonatomic, readonly) int      height;

/**
 *  视频头信息中的帧率
 */
@property (nonatomic, readonly) float    fpsInMeta;

/**
 *  实时帧率
 */
@property (nonatomic, readonly) float    fpsInOutput;

/**
 *  视频平均帧率
 */
@property (nonatomic, readonly) float    avgFpsInOutput;

/**
 *  声道（当前识别Mono和stereo，其他声道输出数字）
 */
@property (nonatomic, readonly) NSString *channels;

/**
 *  传输速度，仅限tcp协议
 */
@property (nonatomic, readonly) NSString *tcpTransportSpeed;

/**
 *  音频采样率
 */
@property (nonatomic, readonly) int      sampleRate;

/**
 *  码率
 */
@property (nonatomic, readonly) float   bitrate;

/**
 *  首屏时间
 */
@property (nonatomic, readonly) float      prepareDuraion;

/**
 *  系统音频兼容
 *  是否兼容其他后台播放器，如其他音乐播放器等
 *  NO：其他播放器在后台时能够在启用播放器时使其他app的播放器暂停，但是此时后台播放打开时，正在后台播放的播放器可能在受到来电或者Siri干扰后，无法重启播放。
 *  YES:其他播放器在后台时能够在启用播放器时不会暂停，会同时播放，但是此时后台播放打开时，正在后台播放的播放器可能在受到来电或者Siri干扰后，能正常重启播放。
 */
@property (nonatomic) BOOL  mixOtherPlayer;

/**
 *  播放速率 精确到小数点后一位 范围0.5~2.0
 */
@property (nonatomic) float playBackRate;

/**
 *  获取播放模式
 *  @return     CNC_MEDIA_PLAYER_MODE_VOD 点播， CNC_MEDIA_PLAYER_MODE_VOD 直播
 */
- (CNCMediaPlayerMode) getPlayMode;

/**
 *  设置播放模式
 *  @param playMode CNC_MEDIA_PLAYER_MODE_VOD|CNC_MEDIA_PLAYER_MODE_LIVE
 *  @return    YES:设置成功 NO:设置失败
 */
- (BOOL) setPlayMode:(CNCMediaPlayerMode)playMode;


/**
 *  获取硬解是否正常开启
 *  @return YES 硬解开启成功|NO硬解开启失败
 */
- (BOOL) is_vtb_open;




#pragma mark- 录制/截屏相关
/**
 开始录制视频
 @param filename    录制输出文件名称
 @param format      录制输出文件格式目前支持gif/MP4/FLV
 @param maxTime     录屏的最长时间单位(ms)是、GIF最大不超过3000ms MP4/FLV最大不超过60000ms
 @param minTime     录屏的最短时间单位(ms)是、GIF最小低于100ms MP4/FLV最大小不低于30000ms
 @return -1         开始失败 其他值表示成功
 */
- (int)startRecordingWithFilename:(NSString *)filename format:(NSString *)format minTime:(int) minTime maxTime:(int)maxTime;

/**
 开始录制视频
 @param filename    录制输出文件名称
 @param format      录制输出文件格式目前支持gif/MP4/FLV
 @param maxTime     录屏的最长时间单位(ms)是、GIF最大不超过3000ms MP4/FLV最大不超过60000ms
 @param minTime     录屏的最短时间单位(ms)是、GIF最小低于100ms MP4/FLV最大小不低于30000ms
 @param scale       format为@"gif"时有效，控制gif缩放比例 范围在270~480
 @return -1         开始失败 其他值表示成功
 */
- (int)startRecordingWithFilename:(NSString *)filename format:(NSString *)format minTime:(int) minTime maxTime:(int)maxTime gifScale:(int)scale;

/**
 结束录制视频
 @return YES 结束录制成功，也可通过通知CNCMediaPlayerStatusCodeNotification异步获取
 */
- (BOOL) stopRecording;

/**
 删除录制异常中存在的临时文件
 */
+ (void) clearTmpRecordingfiles;

/**
 显示录屏控制视图

 @param recorderCtrlView 控制录屏的视图
 @param type 录屏类型
 @return 是否显示成功
 */
- (BOOL)showRecorderView:(nonnull UIView *) recorderCtrlView type:(CNC_MediaPlayer_Screen_Record_Type) type;

/**
 开始录制屏幕
 @param filename            录屏输出文件名称
 @param format              录制输出文件格式目前支持mov
 @param minTime             录屏的最长时间单位(ms)最大不超过6000ms
 @param minTime             录屏的最短时间单位(ms)最大小不低于3000ms
 @param handler             录屏开始的回调,正常开始error为nil，若为SDK自动结束录制，handle中的error会附带录制成功或录制失败的信息
 @param exceptionHandler    录屏过程中的异常回调,例如磁盘空间不足/录制时间不足/超出时限/异常中断等回调
 @return                    -1 开始失败 其他值表示成功
 */
- (int)startScreenRecordWithFilename:(NSString *_Nonnull)filename  format:(NSString *_Nonnull)format minTime:(int) minTime maxTime:(int)maxTime handler:(nullable void(^)(NSError * __nullable error))handler exceptionHandler:(nullable void(^)(NSDictionary * __nullable object,NSError * __nullable error))exceptionHandler;

/**
 结束录制屏幕
 @para handle 主动调用stopScreenRecord后，若是录制失败，handle中的error参数会附带错误信息
 @return dictionary有值 结束录制成功  dictionary为nil则结束录制失败
 */
- (NSDictionary *_Nonnull)stopScreenRecordWithHandler:(nullable void(^)(NSDictionary * __nullable object, NSError * __nullable error))handler;

/**
 取消录制屏幕
 @para handle handle中的error参数会附带错误信息
 @return YES 结束录制成功
 */
- (int)discardScreenRecordWithHandler:(nullable void(^)(NSError * __nullable error))handler;


/**
 重新录屏,取消之前录制的结果,录制文件及产生的临时文件被删除,录制界面恢复开始录制之前的界面.可重新开始录制

 @param handler 异常回调
 @return 重置成功与否返回值 大于0成功
 */
-(int)resetScreenRecordWithHandler:(void (^_Nullable)(NSError * _Nullable))handler;



/**
 获取当前录屏的时间

 @return 录屏的时间单位毫秒
 */
-(CGFloat)screenRecordTime;

/**
 截屏
 @return 返回当前时刻的屏幕截图
 */
- (UIImage *_Nonnull) screenShot;

/**
 添加水印
 @param image   添加水印的图片
 @param watermark 水印图片
 @param rect    水印在图片中的位置
 @return 返回添加水印后的图片
 */
- (UIImage *_Nonnull) watermarkWithImage:(UIImage *_Nonnull)image watermark:(UIImage *_Nonnull)watermark inRect:(CGRect)rect;

/**
 当前录制的时长
 @return 返回当前录制的视频/GIF时长，单位毫秒
 */
- (int) recordingDuration;

/**
 *  是否处于录制状态
 */
@property (nonatomic, readonly) BOOL    isRecording;

#pragma mark- 时移功能
/**
 *  设置时移key和上限value    如果要加载其他URL或者重新设置key和maxtime，需要先调用closeTimeShift
 *  @param key  时移参数 nil为默认值
 *  @param maxtime  时移上限时间
 */
- (void)openTimeshiftWithKey:(NSString *_Nullable)key andMaxTime:(NSInteger)maxtime;

/**
 *  时移开启下调用生效，时移至time时间前
 *  @param time 要时移的时间
 */
- (void)timeshiftWithtime:(NSInteger)time;

/**
 *  关闭时移
 */
- (void)closeTimeShift;


#pragma mark -网络代理
/**
 打开socks5代理功能，代理互斥，开启socks5则关闭socks4及HTTP/HTTPS代理

 @param     user    用户名
 @param     pwd     密码
 @param     ip      ip地址
 @param     port    端口号
 @return 返回小于0为失败
         -1:ip为空
         -2:port为空
         -3:user为空
         -4:pwd为空
 */
- (int)enableSocks5:(NSString *_Nonnull) user pwd:(NSString *_Nonnull) pwd ip:(NSString *_Nonnull) ip port:(NSString *_Nullable)port;


/**
 打开socks4代理功能 开启socks4则关闭socks5及HTTP/HTTPS代理
 @param ip ip地址
 @param port 端口号
 @return 返回小于0为失败
         -1:ip为空
         -2:port为空
 */
- (int)enableSocks4WithIP:(NSString *_Nonnull) ip port:(NSString *_Nonnull)port;



/**
 开启HTTP/HTTPS 代理 开启HTTP/HTTPS 则关闭socks4及socks5代理

 @param user 用户名
 @param pwd 密码
 @param ip ip地址
 @param port 端口号
 @param https BOOL 是否HTTPS
 @return 返回小于0为失败
         -1:ip为空
         -2:port为空
 
 */
- (int)enableHttpProxyWithUsername:(NSString *_Nullable) user pwd:(NSString *_Nullable) pwd IP:(NSString *_Nonnull) ip port:(NSString *_Nonnull)port isHtpps:(BOOL) https;

/**
 关闭socks5功能
 @return 关闭成功与否返回小于0为失败
 */
- (int)disableSocks5;


#pragma mark - hls码率自适应
/**
 是否开启hls码率自适应，与默认设置hls码率不冲突，但当手动设置一次后，自动适应失效
 */
@property (nonatomic, assign) BOOL HLSAdaptation;

/**
 设置默认播放的hls码率，需要知道多码率列表的具体码率值，设置才会生效
 */
@property (nonatomic) int64_t defaultHLSBitrate;

/**
 关闭hls码率自适应
 @return 关闭成功与否返回 小于0为失败
 */
- (BOOL)closeHLSAdaptation;

/**
 播放过程中手动设置hls播放码率
 @param bitrate 设置的码率
 @return 设置成功与否返回 小于0为失败
 */
- (BOOL)selectBitrate:(int64_t)bitrate;


@end

