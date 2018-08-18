//
//  RequestPostUploadHelper.h
//  tea
//
//  Created by fengke on 16/2/26.
//  Copyright © 2016年 com.xhhc. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface RequestPostUploadHelper : NSObject

+ (NSURLSessionDataTask *)postRequestWithURL: (NSString *)url  // IN
                      postParems: (NSDictionary *)postParems // IN 提交参数据集合
                     picFilePath: (NSString *)picFilePath  // IN 上传图片路径
                     picFileName: (NSString *)picFileName  // IN 上传图片名称
                         success:(void (^)(id responseObject))success
                         failure:(void (^)(NSError *error))failure;


+ (NSURLSessionDataTask *)postRequestWithURL: (NSString *)url  // IN
                                  postParems: (NSDictionary *)postParems // IN 提交参数据集合
                                     picFile: (UIImage *)picFile  // IN 上传图片
                                 picFileName: (NSString *)picFileName  // IN 上传图片名称
                                     success:(void (^)(id responseObject))success
                                     failure:(void (^)(NSError *error))failure;

/**
 * 修发图片大小
 */
+ (UIImage *) imageWithImageSimple:(UIImage*)image scaledToSize:(CGSize) newSize;
/**
 * 保存图片
 */
+ (NSString *)saveImage:(UIImage *)tempImage WithName:(NSString *)imageName;



@end
