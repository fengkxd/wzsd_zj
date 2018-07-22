//
//  Utility.h
//  meibo
//
//  Created by fengke on 14/12/16.
//  Copyright (c) 2014年 com.szcomtop. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


#define UILABEL_LINE_SPACE 5


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

+(void)setLabelSpace:(UILabel*)label withValue:(NSString*)str withFont:(UIFont*)font;
//计算UILabel的高度(带有行间距的情况)
+(CGFloat)getSpaceLabelHeight:(NSString*)str withFont:(UIFont*)font withWidth:(CGFloat)width ;

//左字右图
+(void)changeImageTitleForBtn:(UIButton *)btn;

+ (NSString *)decodeURL:(NSString *)str;
+(void)registerAPNS;
+(UIImage *)resetSizeOfImageData:(UIImage *)source_image maxSize:(NSInteger)maxSize;

+(void)saveObject:(id)object withKey:(NSString *)key;
+(id)objectForKey:(NSString *)key;



+ (BOOL)isLogined;

+ (UIColor *) colorWithHexString: (NSString *)color;
+(BOOL)isNotBlank: (NSString *)str;
+(BOOL)isBlank: (NSString *)str;
+(BOOL)CheckPhoneNumInput:(NSString *)_text;

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


//将 &lt 等类似的字符转化为HTML中的“<”等
+ (NSString *)htmlEntityDecode:(NSString *)string;
//将HTML字符串转化为NSAttributedString富文本字符串
+ (NSAttributedString *)attributedStringWithHTMLString:(NSString *)htmlString;
//去掉 HTML 字符串中的标签
+ (NSString *)filterHTML:(NSString *)html;

@end



