//
//  CNCPlayerCommonFunc.h
//  CNCMediaPlayerDemo
//
//  Created by Hjf on 2017/12/25.
//  Copyright © 2017年 CNC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#define Min_Screen_Record_Time 3000
#define Max_Screen_Record_Time 60000

#define IOS_CELLULAR    @"pdp_ip0"
#define IOS_WIFI        @"en0"
#define IOS_VPN         @"utun0"
#define IP_ADDR_IPv4    @"ipv4"
#define IP_ADDR_IPv6    @"ipv6"

#define CNC_VOLUME_RANGE        0.03
#define CNC_BRIGHTNESS_RANGE    0.05

#define CNC_QUESTION_COUNTDOWN  10

#define CNC_TIME @"time"
#define CNC_TYPE @"type"
#define CNC_CONTENT @"content"

#define CNC_USERTYPE @"userType"
#define CNC_QUESTIONLIST @"questionList"

#define CNC_QUESTION    @"question"
#define CNC_ANSWER  @"answer"
#define CNC_CORRECT @"correct"
#define CNC_QUESTION_TYPE @"type"

/* 手势方向 */
typedef NS_ENUM(NSInteger, WSGestureDirection){
    WS_GESTURE_DIRECTIOIN_HORIZONTAL = 0,
    WS_GESTURE_DIRECTIOIN_VERTICAL
};


@interface CNCPlayerCommonFunc : NSObject


+ (NSString *) getVideoRecord:(NSString *) filename;

+ (NSString *) getGifRecord:(NSString *) filename;

+ (NSString *) getLog:(NSString *) filename;

+ (NSString *)getTimeNow;

+ (NSString *)getTimeNowWithMilliSecond;

+ (NSString *)getIPAddress:(BOOL)preferIPv4;

+ (UIImage *)OriginImage:(UIImage *)image scaleToSize:(CGSize)size;

+ (void)writeLogAtFilePath:(NSString *)filePath withLog:(NSString *)log;

+ (NSString *)obj_to_jsonstr:(NSObject *)obj;
@end
