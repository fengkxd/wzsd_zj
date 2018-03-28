//
//  Utility.h
//  meibo
//
//  Created by fengke on 14/12/16.
//  Copyright (c) 2014年 com.szcomtop. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface UIColor (Hex)
+ (UIColor *)colorWithHexString:(NSString *)color;
+ (UIColor *)colorWithHexString:(NSString *)color alpha:(CGFloat)alpha;
@end
@interface UIImage (Color)
+(UIImage*) ImageWithColor:(UIColor*) color;
@end


@interface NSDictionary (MyDelete)
- (NSMutableDictionary *)deleteAllNullValue;
@end




#define UUID_KEY  @"UUID"
#define Identifier   @"CF5GR8SZF9.com.Dortor.hb"


@interface Utility : NSObject{}

//左字右图
+(void)changeImageTitleForBtn:(UIButton *)btn;



+ (NSString *)decodeURL:(NSString *)str;
+(void)registerAPNS;
+(UIImage *)resetSizeOfImageData:(UIImage *)source_image maxSize:(NSInteger)maxSize;


+ (BOOL)isLogined;

+ (UIColor *) colorWithHexString: (NSString *)color;
+(BOOL)isNotBlank: (NSString *)str;
+(BOOL)isBlank: (NSString *)str;
+(BOOL)CheckPhoneNumInput:(NSString *)_text;

+(void)saveObject:(id)object withKey:(NSString *)key;
+(id)getObjectForkey:(NSString *)key;
+(void)removeForkey:(NSString *)key;

+(void)deleteCookies;

+(NSString *)dateWithTimeInterval:(NSTimeInterval)secs;


+ (CGSize)sizeWithString:(NSString *)string font:(UIFont *)font;



+ (NSString *) md5:(NSString *)str;
+(void)share:(NSString*)url withText:(NSString *)text withImgUrl:(NSString *)ImgUrl;


+(NSString *)userAttributeFileWithName:(NSString *)fileAttributeName;
+(NSString *) currentUserDocument;

+(UIImage *) createImageWithColor:(UIColor*) color;

+(UIImage *) getImageUserType:(NSInteger)type;


+(void)share:(NSString*)url withText:(NSString *)text;


+(UIViewController *)getCurrentRootViewController;


@end



