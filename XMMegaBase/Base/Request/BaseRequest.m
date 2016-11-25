//
//  BaseRequest.m
//  HongBao
//
//  Created by Ivan on 16/1/31.
//  Copyright © 2016年 ivan. All rights reserved.
//

#import "BaseRequest.h"

#define BASE_IMAGE_UPLOAD_REQUEST_URL          @"/upload/img"


@implementation BaseRequest


+ (void)uploadImageWithParams:(NSDictionary *)params image:(UIImage *)image success:(void(^)(ImageUploadResultModel *resultModel))success failure:(void(^)(StatusModel *status))failure
{
    [[TTNetworkManager sharedInstance] postImageWithUrl:BASE_IMAGE_UPLOAD_REQUEST_URL image:image parameters:params progress:^(NSProgress *uploadProgress) {
        
    } success:^(NSDictionary *result) {
        
        NSError *err = [[NSError alloc] init];
        
        ImageUploadResultModel *addImageResult = [[ImageUploadResultModel alloc] initWithDictionary:result error:&err];
        
        if (success) {
            success(addImageResult);
        }
        
    } failure:^(StatusModel *status) {
        if (failure) {
            failure(status);
        }
    }];
}
@end
