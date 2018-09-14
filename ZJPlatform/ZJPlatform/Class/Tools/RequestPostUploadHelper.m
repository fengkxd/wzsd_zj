//
//  RequestPostUploadHelper.m
//  tea
//
//  Created by fengke on 16/2/26.
//  Copyright © 2016年 com.xhhc. All rights reserved.
//

#import "RequestPostUploadHelper.h"
#import "AFHTTPSessionManager.h"

@implementation RequestPostUploadHelper


+ (NSURLSessionDataTask *)postRequestWithURL: (NSString *)url  // IN
                                  postParems: (NSDictionary *)postParems // IN 提交参数据集合
                                     picFile: (UIImage *)picFile  // IN 上传图片
                                 picFileName: (NSString *)picFileName  // IN 上传图片名称
                                     success:(void (^)(id responseObject))success
                                     failure:(void (^)(NSError *error))failure
{
    
    
    
    
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    session.requestSerializer = [AFHTTPRequestSerializer serializer];
    session.responseSerializer = [AFHTTPResponseSerializer serializer];
//    if ([Utility isNotBlank:[Utility getObjectForkey:MYTOKEN]]) {
//        [session.requestSerializer setValue:[Utility getObjectForkey:MYTOKEN] forHTTPHeaderField:@"token"];
//    }
    return [session POST:url parameters:postParems constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        // 获得要上传文件的二进制数据
        NSData *fileData = UIImagePNGRepresentation(picFile);

//    NSData *fileData = UIImageJPEGRepresentation([Utility resetSizeOfImageData:picFile maxSize:MAX_PIC *2],1.0);
//        NSData *fileData = [NSData dataWithContentsOfFile:pic]
        /**
         参数1:文件的二进制数据
         参数2:对应服务器接收文件数据的字段
         参数3:保存的文件名
         参数4:告诉服务器上传的文件类型
         */
        
        [formData appendPartWithFileData:fileData name:picFileName fileName:@"file" mimeType:@"image/png"];
    } progress:^(NSProgress *uploadProgress) {
        
    } success:^(NSURLSessionDataTask *task, id responseObject) {
        success(responseObject);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        failure(error);
    }];
    
}

+ (NSURLSessionDataTask *)postRequestWithURL: (NSString *)url  // IN
                      postParems: (NSDictionary *)postParems // IN 提交参数据集合
                     picFilePath: (NSString *)picFilePath  // IN 上传图片路径
                     picFileName: (NSString *)picFileName  // IN 上传图片名称
                         success:(void (^)(id responseObject))success
                         failure:(void (^)(NSError *error))failure
{
    
    
    
    
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    
//    if ([Utility isNotBlank:[Utility getObjectForkey:MYTOKEN]]) {
//        [session.requestSerializer setValue:[Utility getObjectForkey:MYTOKEN] forHTTPHeaderField:@"token"];
//    }
//
    return [session POST:url parameters:postParems constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
//        // 获得要上传文件的二进制数据
//        UIImage *img  = [UIImage imageWithContentsOfFile:picFilePath];
//
//        NSData *fileData = UIImageJPEGRepresentation([Utility resetSizeOfImageData:img maxSize:MAX_PIC * 2.0],1.0);
//
        NSData *fileData = [NSData dataWithContentsOfFile:picFilePath];
        /**
         参数1:文件的二进制数据
         参数2:对应服务器接收文件数据的字段
         参数3:保存的文件名
         参数4:告诉服务器上传的文件类型
         */
        
        [formData appendPartWithFileData:fileData name:picFileName fileName:@"1.png" mimeType:@"image/png"];
    } progress:^(NSProgress *uploadProgress) {
        NSLog(@"-----%f",uploadProgress.fractionCompleted);
    } success:^(NSURLSessionDataTask *task, id responseObject) {
        success(responseObject);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
    
        failure(error);
    }];

}
//
//[session POST:url parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
//    
//    // 获得要上传文件的二进制数据
//    NSData *fileData = [NSData dataWithContentsOfFile:url];
//    /**
//     参数1:文件的二进制数据
//     参数2:对应服务器接收文件数据的字段
//     参数3:保存的文件名
//     参数4:告诉服务器上传的文件类型
//     */
//    [formData appendPartWithFileData:fileData name:@"file" fileName:@"oooo.png" mimeType:@"image/png"];
//} progress:^(NSProgress * _Nonnull uploadProgress) {
//    
//} success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//    
//} failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//    
//}];

/**
 * 修发图片大小
 */
+ (UIImage *) imageWithImageSimple:(UIImage*)image scaledToSize:(CGSize) newSize{
    newSize.height=image.size.height*(newSize.width/image.size.width);
    UIGraphicsBeginImageContext(newSize);
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage=UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return  newImage;
    
}

/**
 * 保存图片
 */
+ (NSString *)saveImage:(UIImage *)tempImage WithName:(NSString *)imageName{
//    NSData* imageData;
    
//    //判断图片是不是png格式的文件
//    if (UIImagePNGRepresentation(tempImage)) {
//        //返回为png图像。
//        NSLog(@"png");
//        imageData = UIImagePNGRepresentation(tempImage);
//    }else {
//        //返回为JPEG图像。
//        imageData = UIImageJPEGRepresentation(tempImage, 1.0);
//        NSLog(@"jpg");
//    }

    
    NSData *fileData = [Utility zipNSDataWithImage:tempImage];

    NSArray* paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString* documentsDirectory = [paths objectAtIndex:0];
    NSString* fullPathToFile = [documentsDirectory stringByAppendingPathComponent:imageName];
    

    
    [fileData writeToFile:fullPathToFile atomically:NO];
    return fullPathToFile;
}




@end
