//
//  Utility.m
//  meibo
//
//  Created by fengke on 14/12/16.
//  Copyright (c) 2014年 com.szcomtop. All rights reserved.
//

#import "Utility.h"
#import "AppDelegate.h"
#import <CommonCrypto/CommonDigest.h>
//#import <ShareSDK/ShareSDK.h>
//#import <ShareSDKUI/ShareSDKUI.h>
#import <objc/runtime.h>
//#import "JPUSHService.h"




@implementation UIColor (Hex)

+ (UIColor *)colorWithHexString:(NSString *)color alpha:(CGFloat)alpha
{
    
    //删除字符串中的空格
    NSString *cString = [[color stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    // String should be 6 or 8 characters
    if ([cString length] < 6)
    {
        return [UIColor clearColor];
    }
    // strip 0X if it appears
    //如果是0x开头的，那么截取字符串，字符串从索引为2的位置开始，一直到末尾
    if ([cString hasPrefix:@"0X"])
    {
        cString = [cString substringFromIndex:2];
    }
    //如果是#开头的，那么截取字符串，字符串从索引为1的位置开始，一直到末尾
    if ([cString hasPrefix:@"#"])
    {
        cString = [cString substringFromIndex:1];
    }
    if ([cString length] != 6)
    {
        return [UIColor clearColor];
    }
    
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    //r
    NSString *rString = [cString substringWithRange:range];
    //g
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    //b
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    return [UIColor colorWithRed:((float)r / 255.0f) green:((float)g / 255.0f) blue:((float)b / 255.0f) alpha:alpha];
}

//默认alpha值为1
+ (UIColor *)colorWithHexString:(NSString *)color
{
    return [self colorWithHexString:color alpha:1.0f];
}

@end

@implementation NSDictionary (MyDelete)

- (NSMutableDictionary *)deleteAllNullValue{
    NSMutableDictionary *mutableDic = [[NSMutableDictionary alloc] init];
    for (NSString *keyStr in self.allKeys) {
        if ([[self objectForKey:keyStr] isEqual:[NSNull null]]) {
            [mutableDic setObject:@"" forKey:keyStr];
        }
        else{
            [mutableDic setObject:[self objectForKey:keyStr] forKey:keyStr];
        }
    }
    return mutableDic;
}
@end

@implementation Utility


+(void)changeImageTitleForBtn:(UIButton *)btn{
    [btn setTitleEdgeInsets:UIEdgeInsetsMake(0, -btn.imageView.bounds.size.width - 2, 0, btn.imageView.bounds.size.width + 2)];
    [btn setImageEdgeInsets:UIEdgeInsetsMake(0, btn.titleLabel.bounds.size.width + 2, 0, -btn.titleLabel.bounds.size.width -2)];
    
    btn.layer.masksToBounds = YES;
    btn.layer.cornerRadius = 2;
}





+ (BOOL)isLogined
{
    NSString * uidStr = [Utility objectForKey:KUID];
    
    if (uidStr && ![uidStr isEqualToString:@""]) {
        return YES;
    }
    return NO;
}


+ (void)initialize
{
    // 获取到UILabel中setText对应的method
    Method setText = class_getInstanceMethod([UILabel class], @selector(setText:));
    Method setTextMySelf = class_getInstanceMethod([self class], @selector(setTextHooked:));
    
    // 将目标函数的原实现绑定到setTextOriginalImplemention方法上
    IMP setTextImp = method_getImplementation(setText);
    class_addMethod([UILabel class], @selector(setTextOriginal:), setTextImp, method_getTypeEncoding(setText));
    
    // 然后用我们自己的函数的实现，替换目标函数对应的实现
    IMP setTextMySelfImp = method_getImplementation(setTextMySelf);
    class_replaceMethod([UILabel class], @selector(setText:), setTextMySelfImp, method_getTypeEncoding(setText));
    
}



- (void)setTextHooked:(NSString *)string
{
    if ([string isKindOfClass:[NSNull class]]) {
        string = @"null";
    }
    
    [self performSelector:@selector(setTextOriginal:) withObject:string];

}




+(NSString *)userAttributeFileWithName:(NSString *)fileAttributeName{
    NSString *result = nil;
    NSString *curUserRoorDir = [Utility currentUserDocument];
    if([Utility isBlank:curUserRoorDir] || [Utility isBlank:fileAttributeName]){
        return result;
    }
    result = [NSString stringWithFormat:@"%@/%@", curUserRoorDir, fileAttributeName];
    return result;
    
}



/*
 *  返回当前用户的根目录
 **/
+(NSString *) currentUserDocument
{
    
     return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0];
}
 

+ (UIColor *) colorWithHexString: (NSString *)color
{
    NSString *cString = [[color stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    // String should be 6 or 8 characters
    if ([cString length] < 6) {
        return [UIColor clearColor];
    }
    
    // strip 0X if it appears
    if ([cString hasPrefix:@"0X"])
        cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"])
        cString = [cString substringFromIndex:1];
    if ([cString length] != 6)
        return [UIColor clearColor];
    
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    
    //r
    NSString *rString = [cString substringWithRange:range];
    
    //g
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    
    //b
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f) green:((float) g / 255.0f) blue:((float) b / 255.0f) alpha:1.0f];
}


//是否为空    为空返回YES  否则返回NO
+(BOOL)isBlank: (NSString *)str
{
    if ([str isKindOfClass:[NSNumber class]]) {
        if ([str integerValue] != 0) {
            return NO;
        }else{
            return YES;
        }
    }
    if ([str isKindOfClass:[NSNull class]]) {
        return YES;
    }
    str = [str stringByReplacingOccurrencesOfString:@" " withString:@""];
    if(!str || ![str isKindOfClass:[NSString class]] || [[NSNull null] isEqual:str] || [@"" isEqualToString:str] || [@"<NULL>" isEqualToString:[str uppercaseString]] || [@"(NULL)" isEqualToString:[str uppercaseString]]){
        return YES;
    }else{
        return  NO;
    }
}

//是否不为空 如果不为空返回YES, 否则返回NO
+(BOOL)isNotBlank: (NSString *)str
{
    if([self isBlank:str])
    {
        return NO;
    }else
    {
        return YES;
    }
}


+(void)saveObject:(id)object withKey:(NSString *)key{
    [[NSUserDefaults standardUserDefaults] setObject:object forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+(id)objectForKey:(NSString *)key{
    return [[NSUserDefaults standardUserDefaults] objectForKey:key];
}


+(void)removeForkey:(NSString *)key{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}




+(void)deleteCookies{
    NSArray *cookies = [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookiesForURL: [NSURL URLWithString:ProxyUrl]];
    for (NSHTTPCookie *cookie in cookies)
    {
        [[NSHTTPCookieStorage sharedHTTPCookieStorage] deleteCookie:cookie];
    }
}


+(UIImage *)resetSizeOfImageData:(UIImage *)source_image maxSize:(NSInteger)maxSize {
    //先判断当前质量是否满足要求，不满足再进行压缩
    __block NSData *finallImageData = UIImageJPEGRepresentation(source_image,1.0);
    NSUInteger sizeOrigin   = finallImageData.length;
    NSUInteger sizeOriginKB = sizeOrigin / 1024;
    
    if (sizeOriginKB <= maxSize) {
        return source_image;
    }
    
    NSLog(@"压缩比例：%f",(maxSize * 1.0)/sizeOriginKB);

    UIImage *img = [Utility imageCompressForWidth:source_image targetWidth:(maxSize * 1.0)/sizeOriginKB * source_image.size.width];
    return img;//压缩
}




+(UIImage *) imageCompressForWidth:(UIImage *)sourceImage targetWidth:(CGFloat)defineWidth{
    UIImage *newImage = nil;
    CGSize imageSize = sourceImage.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    CGFloat targetWidth = defineWidth;
    CGFloat targetHeight = height / (width / targetWidth);
    CGSize size = CGSizeMake(targetWidth, targetHeight);
    CGFloat scaleFactor = 0.0;
    CGFloat scaledWidth = targetWidth;
    CGFloat scaledHeight = targetHeight;
    CGPoint thumbnailPoint = CGPointMake(0.0, 0.0);
    if(CGSizeEqualToSize(imageSize, size) == NO){
        CGFloat widthFactor = targetWidth / width;
        CGFloat heightFactor = targetHeight / height;
        if(widthFactor > heightFactor){
            scaleFactor = widthFactor;
        }
        else{
            scaleFactor = heightFactor;
        }
        scaledWidth = width * scaleFactor;
        scaledHeight = height * scaleFactor;
        if(widthFactor > heightFactor){
            thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5;
        }else if(widthFactor < heightFactor){
            thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5;
        }
    }
    UIGraphicsBeginImageContext(size);
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.origin = thumbnailPoint;
    thumbnailRect.size.width = scaledWidth;
    thumbnailRect.size.height = scaledHeight;
    
    [sourceImage drawInRect:thumbnailRect];
    
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    if(newImage == nil){
        NSLog(@"scale image fail");
    }
    
    UIGraphicsEndImageContext();
    return newImage;
}





#pragma mark 调整图片分辨率/尺寸（等比例缩放）
+ (UIImage *)newSizeImage:(CGSize)size image:(UIImage *)source_image {
    CGSize newSize = CGSizeMake(source_image.size.width, source_image.size.height);
    
    CGFloat tempHeight = newSize.height / size.height;
    CGFloat tempWidth = newSize.width / size.width;
    
    if (tempWidth > 1.0 && tempWidth > tempHeight) {
        newSize = CGSizeMake(source_image.size.width / tempWidth, source_image.size.height / tempWidth);
    }
    else if (tempHeight > 1.0 && tempWidth < tempHeight){
        newSize = CGSizeMake(source_image.size.width / tempHeight, source_image.size.height / tempHeight);
    }
    
    UIGraphicsBeginImageContext(newSize);
    [source_image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

#pragma mark 二分法
+ (NSData *)halfFuntion:(NSArray *)arr image:(UIImage *)image sourceData:(NSData *)finallImageData maxSize:(NSInteger)maxSize {
    NSData *tempData = [NSData data];
    NSUInteger start = 0;
    NSUInteger end = arr.count - 1;
    NSUInteger index = 0;
    
    NSUInteger difference = NSIntegerMax;
    while(start <= end) {
        index = start + (end - start)/2;
        
        finallImageData = UIImageJPEGRepresentation(image,[arr[index] floatValue]);
        
        NSUInteger sizeOrigin = finallImageData.length;
        NSUInteger sizeOriginKB = sizeOrigin / 1024;
        NSLog(@"当前降到的质量：%ld", (unsigned long)sizeOriginKB);
        NSLog(@"%lu----%lf", (unsigned long)index, [arr[index] floatValue]);
        
        if (sizeOriginKB > maxSize) {
            start = index + 1;
        } else if (sizeOriginKB < maxSize) {
            if (maxSize-sizeOriginKB < difference) {
                difference = maxSize-sizeOriginKB;
                tempData = finallImageData;
            }
            end = index - 1;
        } else {
            break;
        }
    }
    return tempData;
}





//
//+(void)registerAPNS{
//    if ([JPUSHService registrationID] && [Utility getObjectForkey:KUID]) {
//        NSString *url = [NSString stringWithFormat:@"%@%@",kNetworkBaseURLString,kNetworkRegisterPush];
//        [[NetworkManager shareNetworkingManager] requestWithMethod:@"POST"
//                                                     headParameter:nil
//                                                     bodyParameter:@{@"registrationId":[JPUSHService registrationID]}
//                                                      relativePath:url success:^(id responseObject) {
//                                                      } failure:^(NSError *error) {
//                                                      }];
//        
//    }
//}






//+(void)clearAPNS{
//    if ([JPUSHService registrationID] && [Utility getObjectForkey:KUID]) {
//        
//
//        MBProgressHUD *HUD =   [MBProgressHUD showHUDAddedTo:[[[[AppDelegate shareInstance] window] rootViewController] view] animated:YES];
//        HUD.removeFromSuperViewOnHide = YES;
//        
//        NSString *url = [NSString stringWithFormat:@"%@%@",kNetworkBaseURLString,kNetworkClearPush];
//        [[NetworkManager shareNetworkingManager] requestWithMethod:@"POST"
//                                                     headParameter:nil
//                                                     bodyParameter:@{@"registrationId":[JPUSHService registrationID]}
//                                                      relativePath:url success:^(id responseObject) {
//                                                          
//                                                          [[User defaultInstance] releaseUser];
//                                                          [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationShowLogin object:nil];
//                                                          
//                                                      } failure:^(NSError *error) {
//                                                          [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationShowLogin object:nil];
//                                                      }];
//    }
//}
//
//
+(UIImage *) getImageUserType:(NSInteger)type{
    if (type == 1) {
        return [UIImage imageNamed:@"Athletes_normal.png"];
    }else if(type == 2){
        return [UIImage imageNamed:@"coach_normal.png"];

    }
    return [UIImage imageNamed:@"referee.png"];

}


+(BOOL)CheckPhoneNumInput:(NSString *)_text{
    //手机号以13， 15，18开头，八个 \d 数字字符
     NSString *phoneRegex = @"^((13[0-9])|(15[^4,\\D])|(18[0,0-9]))\\d{8}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    
    return [phoneTest evaluateWithObject:_text];
}

+(NSString *)dateWithTimeInterval:(NSTimeInterval)secs{
    NSDate *currentSystemDate = [NSDate dateWithTimeIntervalSinceReferenceDate:secs];
    //实例化一个NSDateFormatter对象
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
     [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    return  [dateFormatter stringFromDate:currentSystemDate];
}



// 定义成方法方便多个label调用 增加代码的复用性
+ (CGSize)sizeWithString:(NSString *)string font:(UIFont *)font
{
    if ([Utility isBlank:string]) {
        string = @"null";
    }
    CGRect rect = [string boundingRectWithSize:CGSizeMake(MainScreenWidth - 30, MAXFLOAT)//限制最大的宽度和高度
                                       options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesFontLeading  |NSStringDrawingUsesLineFragmentOrigin//采用换行模式
                                    attributes:@{NSFontAttributeName: font}//传人的字体字典
                                       context:nil];
    
    return rect.size;
}

+ (NSString *) md5:(NSString *)str{

    const char *cStr = [str UTF8String];
    unsigned char result[16];
     CC_MD5(cStr, (CC_LONG)strlen(cStr), result);

    return [NSString stringWithFormat:@"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
}

+(void)setLabelSpace:(UILabel*)label withValue:(NSString*)str withFont:(UIFont*)font {
    NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
    paraStyle.lineBreakMode = NSLineBreakByCharWrapping;
    paraStyle.alignment = NSTextAlignmentLeft;
    paraStyle.lineSpacing = UILABEL_LINE_SPACE; //设置行间距
    paraStyle.hyphenationFactor = 1.0;
    paraStyle.firstLineHeadIndent = 0.0;
    paraStyle.paragraphSpacingBefore = 0.0;
    paraStyle.headIndent = 0;
    paraStyle.tailIndent = 0;
    //设置字间距 NSKernAttributeName:@1.5f
    NSDictionary *dic = @{NSFontAttributeName:font, NSParagraphStyleAttributeName:paraStyle, NSKernAttributeName:@1.5f
                          };
    NSAttributedString *attributeStr = [[NSAttributedString alloc] initWithString:str attributes:dic];
    label.attributedText = attributeStr;
}


//计算UILabel的高度(带有行间距的情况)

+(CGFloat)getSpaceLabelHeight:(NSString*)str withFont:(UIFont*)font withWidth:(CGFloat)width {
    NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
    paraStyle.lineBreakMode = NSLineBreakByCharWrapping;
    paraStyle.alignment = NSTextAlignmentLeft;
    paraStyle.lineSpacing = UILABEL_LINE_SPACE;
    paraStyle.hyphenationFactor = 1.0;
    paraStyle.firstLineHeadIndent = 0.0;
    paraStyle.paragraphSpacingBefore = 0.0;
    paraStyle.headIndent = 0;
    paraStyle.tailIndent = 0;
    NSDictionary *dic = @{NSFontAttributeName:font, NSParagraphStyleAttributeName:paraStyle, NSKernAttributeName:@1.5f};
    CGSize size = [str boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size;
    return size.height;
}


 

+(void)share:(NSString*)url withText:(NSString *)text{

//
//    //1、创建分享参数（必要）
//    NSArray* imageArray = @[[UIImage imageNamed:@"120x120.png"]];
//
////     NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
////    [shareParams SSDKEnableUseClientShare];
////
////    [shareParams SSDKSetupShareParamsByText:text
////                                     images:img
////                                        url:[NSURL URLWithString:url]
////                                      title:@"龙情狮义"
////                                       type:SSDKContentTypeWebPage];
////
////    [shareParams SSDKSetupWeChatParamsByText:text title:@"龙情狮义" url:[NSURL URLWithString:url] thumbImage:img image:img musicFileURL:nil extInfo:nil fileData:nil emoticonData:nil type:SSDKContentTypeWebPage forPlatformSubType:SSDKPlatformSubTypeWechatSession];
////    [shareParams SSDKSetupWeChatParamsByText:text title:@"龙情狮义" url:[NSURL URLWithString:url] thumbImage:img image:img musicFileURL:nil extInfo:nil fileData:nil emoticonData:nil type:SSDKContentTypeWebPage forPlatformSubType:SSDKPlatformSubTypeWechatTimeline];
//
//
//
//    NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
//    [shareParams SSDKSetupShareParamsByText:text
//                                     images:imageArray
//                                        url:[NSURL URLWithString:url]
//                                      title:@"龙情狮义"
//                                       type:SSDKContentTypeAuto];
//
//    //有的平台要客户端分享需要加此方法，例如微博
//    [shareParams SSDKEnableUseClientShare];
//
//
//     [ShareSDK showShareActionSheet:nil //要显示菜单的视图, iPad版中此参数作为弹出菜单的参照视图，只有传这个才可以弹出我们的分享菜单，可以传分享的按钮对象或者自己创建小的view 对象，iPhone可以传nil不会影响
//                             items:@[@(SSDKPlatformSubTypeWechatSession), @(SSDKPlatformSubTypeWechatTimeline),@(SSDKPlatformSubTypeQQFriend),@(SSDKPlatformTypeSinaWeibo)]
//                       shareParams:shareParams
//               onShareStateChanged:^(SSDKResponseState state, SSDKPlatformType platformType, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error, BOOL end) {
//
//                   switch (state) {
//                       case SSDKResponseStateSuccess:
//                       {
//                           UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"分享成功"
//                                                                               message:nil
//                                                                              delegate:nil
//                                                                     cancelButtonTitle:@"确定"
//                                                                     otherButtonTitles:nil];
//                           [alertView show];
//                           break;
//                       }
//                       case SSDKResponseStateFail:
//                       {
////                           UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"分享失败"
////                                                                           message:[NSString stringWithFormat:@"%@",error]
////                                                                          delegate:nil
////                                                                 cancelButtonTitle:@"OK"
////                                                                 otherButtonTitles:nil, nil];
////                           [alert show];
//                           break;
//                       }
//                       default:
//                           break;
//                   }
//               }
//     ];
}


+ (NSString *)decodeURL:(NSString *)str{
    NSMutableString *s = [NSMutableString string];
    for (NSUInteger i= str.length; i>0; i--) {
        [s appendString:[str substringWithRange:NSMakeRange(i-1, 1)]];
    }
    NSData *data = [[NSData alloc] initWithBase64EncodedString:s options:NSDataBase64DecodingIgnoreUnknownCharacters];
    NSString *decodeURL = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"播放地址：：：%@",decodeURL);
    return decodeURL;
}

+(void)registerAPNS{
//    if ([JPUSHService registrationID] && [Utility getObjectForkey:KUID]) {
//        NSString *url = [NSString stringWithFormat:@"%@%@",ProxyUrl,kRequest_AppResgistrationSet];
//        [[NetworkManager shareNetworkingManager] requestWithMethod:@"POST"
//                                                     headParameter:nil
//                                                     bodyParameter:@{@"data":@{@"registrationId":[JPUSHService registrationID]}}
//                                                      relativePath:url success:^(id responseObject) {
//                                                      } failure:^(NSString *errorMsg) {
//                                                      }];
//        
//    }
}


// 获取当前处于activity状态的view controller
+(UIViewController *)getCurrentRootViewController {
    
    
    UIViewController *result;
    
    UIWindow *topWindow = [[UIApplication sharedApplication] keyWindow];
    
    
    if (topWindow.windowLevel != UIWindowLevelNormal)
    {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(topWindow in windows)
        {
            if (topWindow.windowLevel == UIWindowLevelNormal)
                break;
        }
    }
    
    
    UIView *rootView = [[topWindow subviews] objectAtIndex:0];
    id nextResponder = [rootView nextResponder];
    if ([nextResponder isKindOfClass:[UIViewController class]])
        result = nextResponder;
    else if ([topWindow respondsToSelector:@selector(rootViewController)] && topWindow.rootViewController != nil)
        result = topWindow.rootViewController;
    else
        NSAssert(NO, @"ShareKit: Could not find a root view controller.  You can assign one manually by calling [[SHK currentHelper] setRootViewController:YOURROOTVIEWCONTROLLER].");
  
    
    while (result.presentedViewController) {
        result = result.presentedViewController;
    }
    return result;

    
}

+(NSData *)reSizeImageData:(UIImage *)sourceImage maxImageSize:(CGFloat)maxImageSize maxSizeWithKB:(CGFloat) maxSize
{
    
    if (maxSize <= 0.0) maxSize = 1024.0;
    if (maxImageSize <= 0.0) maxImageSize = 1024.0;
    
    //先调整分辨率
    CGSize newSize = CGSizeMake(sourceImage.size.width, sourceImage.size.height);
    
    CGFloat tempHeight = newSize.height / maxImageSize;
    CGFloat tempWidth = newSize.width / maxImageSize;
    
    if (tempWidth > 1.0 && tempWidth > tempHeight) {
        newSize = CGSizeMake(sourceImage.size.width / tempWidth, sourceImage.size.height / tempWidth);
    }
    else if (tempHeight > 1.0 && tempWidth < tempHeight){
        newSize = CGSizeMake(sourceImage.size.width / tempHeight, sourceImage.size.height / tempHeight);
    }
    
    UIGraphicsBeginImageContext(newSize);
    [sourceImage drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    //调整大小
    NSData *imageData = UIImageJPEGRepresentation(newImage,1.0);
    CGFloat sizeOriginKB = imageData.length / 1024.0;
    
    CGFloat resizeRate = 0.9;
    while (sizeOriginKB > maxSize && resizeRate > 0.1) {
        imageData = UIImageJPEGRepresentation(newImage,resizeRate);
        sizeOriginKB = imageData.length / 1024.0;
        resizeRate -= 0.1;
    }
    
    return imageData;
}

+(NSData *)zipNSDataWithImage:(UIImage *)sourceImage{
    //进行图像尺寸的压缩
    CGSize imageSize = sourceImage.size;//取出要压缩的image尺寸
    CGFloat width = imageSize.width;    //图片宽度
    CGFloat height = imageSize.height;  //图片高度
    //1.宽高大于1280(宽高比不按照2来算，按照1来算)
    if (width>1280||height>1280) {
        if (width>height) {
            CGFloat scale = height/width;
            width = 1280;
            height = width*scale;
        }else{
            CGFloat scale = width/height;
            height = 1280;
            width = height*scale;
        }
        //2.宽大于1280高小于1280
    }else if(width>1280||height<1280){
        CGFloat scale = height/width;
        width = 1280;
        height = width*scale;
        //3.宽小于1280高大于1280
    }else if(width<1280||height>1280){
        CGFloat scale = width/height;
        height = 1280;
        width = height*scale;
        //4.宽高都小于1280
    }else{
    }
    UIGraphicsBeginImageContext(CGSizeMake(width, height));
    [sourceImage drawInRect:CGRectMake(0,0,width,height)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    //进行图像的画面质量压缩
    NSData *data=UIImageJPEGRepresentation(newImage, 1.0);
    if (data.length>100*1024) {
        if (data.length>1024*1024) {//1M以及以上
            data=UIImageJPEGRepresentation(newImage, 0.7);
        }else if (data.length>512*1024) {//0.5M-1M
            data=UIImageJPEGRepresentation(newImage, 0.8);
        }else if (data.length>200*1024) {
            //0.25M-0.5M
            data=UIImageJPEGRepresentation(newImage, 0.9);
        }
    }
    return data;
}


+(UIImage*) createImageWithColor:(UIColor*) color
{
    CGRect rect=CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}


//将 &lt 等类似的字符转化为HTML中的“<”等
+ (NSString *)htmlEntityDecode:(NSString *)string
{
    string = [string stringByReplacingOccurrencesOfString:@"&quot;" withString:@"\""];
    string = [string stringByReplacingOccurrencesOfString:@"&apos;" withString:@"'"];
    string = [string stringByReplacingOccurrencesOfString:@"&lt;" withString:@"<"];
    string = [string stringByReplacingOccurrencesOfString:@"&gt;" withString:@">"];
    string = [string stringByReplacingOccurrencesOfString:@"&amp;" withString:@"&"];
    return string;
}

//将HTML字符串转化为NSAttributedString富文本字符串
+ (NSAttributedString *)attributedStringWithHTMLString:(NSString *)htmlString
{
    NSDictionary *options = @{ NSDocumentTypeDocumentAttribute : NSHTMLTextDocumentType,
                               NSCharacterEncodingDocumentAttribute :@(NSUTF8StringEncoding) };
    
    NSData *data = [htmlString dataUsingEncoding:NSUTF8StringEncoding];
    
    return [[NSAttributedString alloc] initWithData:data options:options documentAttributes:nil error:nil];
}

//去掉 HTML 字符串中的标签
+ (NSString *)filterHTML:(NSString *)html
{
    NSScanner * scanner = [NSScanner scannerWithString:html];
    NSString * text = nil;
    while([scanner isAtEnd]==NO)
    {
        //找到标签的起始位置
        [scanner scanUpToString:@"<" intoString:nil];
        //找到标签的结束位置
        [scanner scanUpToString:@">" intoString:&text];
        //替换字符
        html = [html stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%@>",text] withString:@""];
    }
    //    NSString * regEx = @"<([^>]*)>";
    //    html = [html stringByReplacingOccurrencesOfString:regEx withString:@""];
    return html;
}

@end
