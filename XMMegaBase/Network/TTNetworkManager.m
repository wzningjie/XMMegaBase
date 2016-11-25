//
//  TTNetworkManager.m
//  HongBao
//
//  Created by Ivan on 16/1/21.
//  Copyright © 2016年 ivan. All rights reserved.
//

#import "TTNetworkManager.h"

#import "ResponseModel.h"

#import "UserService.h"
#import "ShortcutMacro.h"
#import "SystemMacro.h"
#import "TTNavigationService.h"
#import "NSMutableDictionary+NullCheck.h"
#import "UIDevice+TT.h"
#import "AppInfoManager.h"


@implementation TTNetworkConfig

@end


@interface TTNetworkManager ()

@end

@implementation TTNetworkManager

static TTNetworkManager *_manager = nil;


+ (void)startWithConfigure:(TTNetworkConfig*)configure
{
    NSAssert(configure&&configure.baseURL.length>0, @"Param can not be nil,baseURL property is required.");
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        //        NSURL *baseURL = [NSURL URLWithString:@"http://coffeecup.misscat.coffee/"];
        
        //NSURL *baseURL = [NSURL URLWithString:@"http://112.124.27.182:8091"];
        NSURL *baseURL = [NSURL URLWithString:configure.baseURL];
        
        _manager = [[TTNetworkManager alloc] init];
        
        NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
        
        //        [config setHTTPAdditionalHeaders:@{ @"User-Agent" : @"TuneStore iOS 1.0"}];
        
        //设置我们的缓存大小 其中内存缓存大小设置10M  磁盘缓存5M
        //        NSURLCache *cache = [[NSURLCache alloc] initWithMemoryCapacity:10 * 1024 * 1024
        //                                                          diskCapacity:50 * 1024 * 1024
        //                                                              diskPath:nil];
        
        //        [config setURLCache:cache];
        
        _manager = [[TTNetworkManager alloc] initWithBaseURL:baseURL
                                        sessionConfiguration:config];
        if (configure.timeoutInterval > 0) {
            _manager.requestSerializer.timeoutInterval = configure.timeoutInterval;
        }
        _manager.responseSerializer.acceptableContentTypes =  [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", nil];
        
    });

}


+ (TTNetworkManager *)sharedInstance {
    if (!_manager) {
        NSLog(@"Configure TTNetwork with +startWithConfigure: first.");
    }
    return _manager;
}

- (void)getWithUrl:(NSString *)URLString
        parameters:(NSDictionary *)parameters
           success:(void (^)(NSDictionary *result))success
           failure:(void (^)(StatusModel *status))failure {
    
    [self getWithUrl:URLString parameters:parameters progress:nil success:success failure:failure];
    
}

- (void)getWithUrl:(NSString *)URLString
        parameters:(NSDictionary *)parameters
          progress:(void (^)(NSProgress *))progress
           success:(void (^)(NSDictionary *result))success
           failure:(void (^)(StatusModel *status))failure {
    
    
    parameters = [self addSystemParameters:parameters];
    DBG(@"GET URL:%@",URLString);
    DBG(@"Parameters:%@",parameters);
    NSURLSessionDataTask *task =
    [self GET:URLString parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
        
        DBG(@"downloadProgress:%@", downloadProgress);
        if (progress) {
            progress(downloadProgress);
        }
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if ( success && failure ) {
            [self requestSuccess:success failure:failure data:responseObject];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if (failure) {
            [self requestFailure:failure data:error];
        }
        
    }];
    DBG(@"Full path:%@",task.originalRequest.URL);
}

- (void)postWithUrl:(NSString *)URLString
         parameters:(NSDictionary *)parameters
            success:(void (^)(NSDictionary *result))success
            failure:(void (^)(StatusModel *status))failure {
    
    #ifdef DEBUG
        [self getWithUrl:URLString parameters:parameters progress:nil success:success failure:failure];
    #else
        [self postWithUrl:URLString parameters:parameters progress:nil success:success failure:failure];
    #endif
}

- (void)postWithUrl:(NSString *)URLString
         parameters:(NSDictionary *)parameters
           progress:(void (^)(NSProgress *))progress
            success:(void (^)(NSDictionary *result))success
            failure:(void (^)(StatusModel *status))failure {
    
    parameters = [self addSystemParameters:parameters];
    DBG(@"POST URL:%@",URLString);
    DBG(@"Parameters:%@",parameters);
    
    [self POST:URLString parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
        
        DBG(@"downloadProgress:%@", downloadProgress);
        if (progress) {
            progress(downloadProgress);
        }
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if ( success && failure ) {
            [self requestSuccess:success failure:failure data:responseObject];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if (failure) {
            [self requestFailure:failure data:error];
        }
        
    }];
    
}

- (void)postFormDataWithUrl:(NSString *)URLString
                 parameters:(NSDictionary *)parameters
  constructingBodyWithBlock:(void(^)(id<AFMultipartFormData> formData))constructingBlock
                   progress:(void (^)(NSProgress *))progress
                    success:(void (^)(NSDictionary *result))success
                    failure:(void (^)(StatusModel *status))failure {
    
    parameters = [self addSystemParameters:parameters];
    DBG(@"POST URL:%@",URLString);
    DBG(@"Parameters:%@",parameters);
    
    [self POST:URLString parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        if (constructingBlock) {
            constructingBlock(formData);
        }
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
        DBG(@"downloadProgress:%@", uploadProgress);
        if (progress) {
            progress(uploadProgress);
        }
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if ( success && failure ) {
            [self requestSuccess:success failure:failure data:responseObject];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
       
        if (failure) {
            [self requestFailure:failure data:error];
        }
        
    }];
}

- (void)postImageWithUrl:(NSString *)URLString
                   image:(UIImage *)image
              parameters:(NSDictionary *)parameters
                progress:(void (^)(NSProgress *))progress
                 success:(void (^)(NSDictionary *result))success
                 failure:(void (^)(StatusModel *status))failure {
    
    if (IS_IOS8) {
        
        parameters = [self addSystemParameters:parameters];
        DBG(@"POST URL:%@",URLString);
        DBG(@"Parameters:%@",parameters);
        
        [self postFormDataWithUrl:URLString parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
            
            if (image) {
                NSData *imageData = UIImageJPEGRepresentation(image, 1);
                
                [formData appendPartWithFileData:imageData
                                            name:@"image"
                                        fileName:@"image.jpg" mimeType:@"image/jpeg"];
            }

            
        } progress:^(NSProgress *uploadProgress) {
            
            DBG(@"upload Progress:%@", uploadProgress);
            if (progress) {
                progress(uploadProgress);
            }
            
        } success:^(NSDictionary *result) {
            
            if (success) {
                success(result);
            }
            
        } failure:^(StatusModel *status) {
            
            if (failure) {
                failure(status);
            }
            
        }];
        
    } else {
        parameters = [self addSystemParameters:parameters];
        DBG(@"POST URL:%@",URLString);
        DBG(@"Parameters:%@",parameters);
        NSString* tmpFilename = [NSString stringWithFormat:@"%f", [NSDate timeIntervalSinceReferenceDate]];
        NSURL* tmpFileUrl = [NSURL fileURLWithPath:[NSTemporaryDirectory() stringByAppendingPathComponent:tmpFilename]];
        
        // Create a multipart form request.
        NSMutableURLRequest *multipartRequest = [[AFHTTPRequestSerializer serializer] multipartFormRequestWithMethod:@"POST"
                                                                                                           URLString:[NSString stringWithFormat:@"%@%@", self.baseURL,URLString]
                                                                                                          parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData> formData)
                                                 {
                                                     if (image) {
                                                         NSData *imageData = UIImageJPEGRepresentation(image, 1);
                                                         [formData appendPartWithFileData:imageData
                                                                                     name:@"image"
                                                                                 fileName:@"image.jpg" mimeType:@"image/jpeg"];
                                                     }
                                                   
                                                 } error:nil];
        
        // Dump multipart request into the temporary file.
        [[AFHTTPRequestSerializer serializer] requestWithMultipartFormRequest:multipartRequest
                                                  writingStreamContentsToFile:tmpFileUrl
                                                            completionHandler:^(NSError *error) {
                           
                                                                AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
                                                                manager.responseSerializer = self.responseSerializer;
                                                                NSURLSessionUploadTask *uploadTask = [manager uploadTaskWithRequest:multipartRequest
                                                                                                                           fromFile:tmpFileUrl
                                                                                                                           progress:progress
                                                                                                                  completionHandler:^(NSURLResponse *response, id responseObject, NSError *error)
                                                                                                      {
                                                                                                          // Cleanup: remove temporary file.
                                                                                                          [[NSFileManager defaultManager] removeItemAtURL:tmpFileUrl error:nil];
                                                                                                          
                                                                                                          // Do something with the result.
                                                                                                          if (error) {
                                                                                                              
                                                                                                              if (failure) {
                                                                                                                  [self requestFailure:failure data:error];
                                                                                                              }
                                                                                                              
                                                                                                          } else {
                                                                                                             
                                                                                                              if ( success && failure ) {
                                                                                                                  [self requestSuccess:success failure:failure data:responseObject];
                                                                                                              }
                                                                                                          }
                                                                                                      }];
                                                                
                                                                [uploadTask resume];
                                                            }];
        
    }
}

- (void)postImagesWithUrl:(NSString *)URLString
                   images:(NSArray<UIImage *> *)images
               parameters:(NSDictionary *)parameters
                 progress:(void (^)(NSProgress *))progress
                  success:(void (^)(NSDictionary *result))success
                  failure:(void (^)(StatusModel *status))failure {
    
    parameters = [self addSystemParameters:parameters];
    DBG(@"POST URL:%@",URLString);
    DBG(@"Parameters:%@",parameters);
    
    if (IS_IOS8) {
        
        [self postFormDataWithUrl:URLString parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
            
            int index = 1;
            for (UIImage *image in images) {
                
                NSData *imageData = UIImageJPEGRepresentation(image, 1);
                
                [formData appendPartWithFileData:imageData
                                            name:@"image[]"//[NSString stringWithFormat:@"image%d",index]
                                        fileName:[NSString stringWithFormat:@"image%d.jpg",index]
                                        mimeType:@"image/jpeg"];
                index++;
            }
            
        } progress:^(NSProgress *uploadProgress) {
            
            DBG(@"downloadProgress:%@", uploadProgress);
            if (progress) {
                progress(uploadProgress);
            }
            
        } success:^(NSDictionary *result) {
            
            if (success) {
                success(result);
            }
            
        } failure:^(StatusModel *status) {
            
            if (failure) {
                failure(status);
            }
            
        }];
    }else{
        parameters = [self addSystemParameters:parameters];
        DBG(@"POST URL:%@",URLString);
        DBG(@"Parameters:%@",parameters);
        NSString* tmpFilename = [NSString stringWithFormat:@"%f", [NSDate timeIntervalSinceReferenceDate]];
        NSURL* tmpFileUrl = [NSURL fileURLWithPath:[NSTemporaryDirectory() stringByAppendingPathComponent:tmpFilename]];
        
        // Create a multipart form request.
        NSMutableURLRequest *multipartRequest = [[AFHTTPRequestSerializer serializer] multipartFormRequestWithMethod:@"POST"
                                                                                                           URLString:[NSString stringWithFormat:@"%@%@",self.baseURL,URLString]
                                                                                                          parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData> formData)
                                                 {
                                                     int index = 1;
                                                     for (UIImage *image in images) {
                                                         
                                                         NSData *imageData = UIImageJPEGRepresentation(image, 1);
                                                         
                                                         [formData appendPartWithFileData:imageData
                                                                                     name:@"image[]"//[NSString stringWithFormat:@"image%d",index]
                                                                                 fileName:[NSString stringWithFormat:@"image%d.jpg",index]
                                                                                 mimeType:@"image/jpeg"];
                                                         index++;
                                                     }
                                                     
                                                 } error:nil];
        
        // Dump multipart request into the temporary file.
        [[AFHTTPRequestSerializer serializer] requestWithMultipartFormRequest:multipartRequest
                                                  writingStreamContentsToFile:tmpFileUrl
                                                            completionHandler:^(NSError *error) {
                                                                
                                                                AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
                                                                manager.responseSerializer = self.responseSerializer;
                                                                NSURLSessionUploadTask *uploadTask = [manager uploadTaskWithRequest:multipartRequest
                                                                                                                           fromFile:tmpFileUrl
                                                                                                                           progress:progress
                                                                                                                  completionHandler:^(NSURLResponse *response, id responseObject, NSError *error)
                                                                                                      {
                                                                                                          // Cleanup: remove temporary file.
                                                                                                          [[NSFileManager defaultManager] removeItemAtURL:tmpFileUrl error:nil];
                                                                                                          
                                                                                                          // Do something with the result.
                                                                                                          if (error) {
                                                                                                              
                                                                                                              if (failure) {
                                                                                                                  [self requestFailure:failure data:error];
                                                                                                              }
                                                                                                              
                                                                                                          } else {
                                                                                                              
                                                                                                              if ( success && failure ) {
                                                                                                                  [self requestSuccess:success failure:failure data:responseObject];
                                                                                                              }
                                                                                                          }
                                                                                                      }];
                                                                
                                                                [uploadTask resume];
                                                            }];
        
    }
    
}

#pragma mark - Private Methods

- (void)requestSuccess:(void (^)(NSDictionary *result))success failure:(void (^)(StatusModel *status))failure data:(id) data {
    
    NSDictionary *responseDictionary = [data copy];
    ResponseModel *responseModel = [[ResponseModel alloc] initWithDictionary:responseDictionary error:nil];
    
    if ( responseModel && responseModel.status && 1001 == responseModel.status.code){
        if (success)
        {
            success(responseModel.result);
        }
    } else {
        
        if ( responseModel && responseModel.status && 1002 == responseModel.status.code ) {
            [[TTNavigationService sharedService] openUrl:@"xiaoma://login"];
            return;
        }
        
        if (failure) {
            
            if ( !responseModel || !responseModel.status) {
                StatusModel *status = [[StatusModel alloc] init];
                
                status.code = 404;
                status.msg = @"网络异常";
                
                failure(status);
            } else {
                failure(responseModel.status);
            }
        }
    }

}

- (void)requestFailure:(void (^)(StatusModel *status))failure data:(NSError *)error {
    
    StatusModel *status = [[StatusModel alloc] init];
    
    status.code = 404;
    status.msg = @"网络异常";
    failure(status);
}

- (NSDictionary *)addSystemParameters:(NSDictionary *)parameters {
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    if ( [UserService sharedService].isLogin ) {
        [params setSafeObject:[UserService sharedService].sign forKey:@"sign"];
    }
    
#if DEBUG
    
//    [params setSafeObject:@"CAb-ncibgvYCzWlyBUVQIA" forKey:@"sign"];
    
#endif
    [params setSafeObject:@"ios" forKey:@"platform"];
    [params setSafeObject:[AppInfoManager shortVersionString] forKey:@"versionName"];

    [params setSafeObject:[UIDevice TT_uniqueID] forKey:@"did"];
    
    if (parameters) {
        [params addEntriesFromDictionary:parameters];
    }
    
    return params;
    
}

@end
