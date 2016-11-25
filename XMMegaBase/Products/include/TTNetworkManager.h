//
//  TTNetworkManager.h
//  HongBao
//
//  Created by Ivan on 16/1/21.
//  Copyright © 2016年 ivan. All rights reserved.
//


#import "AFHTTPSessionManager.h"
#import "StatusModel.h"

@interface TTNetworkConfig : NSObject
@property (nonatomic, strong) NSString *baseURL;
@property (nonatomic, assign) NSTimeInterval timeoutInterval;
@end

@interface TTNetworkManager : AFHTTPSessionManager

+ (void)startWithConfigure:(TTNetworkConfig*)configure;

+ (TTNetworkManager *)sharedInstance;

- (void)getWithUrl:(NSString *)URLString
        parameters:(NSDictionary *)parameters
           success:(void (^)(NSDictionary *result))success
           failure:(void (^)(StatusModel *status))failure;

- (void)getWithUrl:(NSString *)URLString
        parameters:(NSDictionary *)parameters
          progress:(void (^)(NSProgress *))progress
           success:(void (^)(NSDictionary *result))success
           failure:(void (^)(StatusModel *status))failure;

- (void)postWithUrl:(NSString *)URLString
         parameters:(NSDictionary *)parameters
            success:(void (^)(NSDictionary *result))success
            failure:(void (^)(StatusModel *status))failure;

- (void)postWithUrl:(NSString *)URLString
         parameters:(NSDictionary *)parameters
           progress:(void (^)(NSProgress *))progress
            success:(void (^)(NSDictionary *result))success
            failure:(void (^)(StatusModel *status))failure;

- (void)postFormDataWithUrl:(NSString *)URLString
                 parameters:(NSDictionary *)parameters
  constructingBodyWithBlock:(void(^)(id<AFMultipartFormData> formData))constructingBlock
                   progress:(void (^)(NSProgress *))progress
                    success:(void (^)(NSDictionary *result))success
                    failure:(void (^)(StatusModel *status))failure;

- (void)postImageWithUrl:(NSString *)URLString
                      image:(UIImage *)image
                 parameters:(NSDictionary *)parameters
                   progress:(void (^)(NSProgress *))progress
                    success:(void (^)(NSDictionary *result))success
                    failure:(void (^)(StatusModel *status))failure;

- (void)postImagesWithUrl:(NSString *)URLString
                   images:(NSArray<UIImage *> *)images
               parameters:(NSDictionary *)parameters
                 progress:(void (^)(NSProgress *))progress
                  success:(void (^)(NSDictionary *result))success
                  failure:(void (^)(StatusModel *status))failure;

@end
