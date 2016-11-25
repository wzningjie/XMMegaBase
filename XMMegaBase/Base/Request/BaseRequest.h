//
//  BaseRequest.h
//  HongBao
//
//  Created by Ivan on 16/1/31.
//  Copyright © 2016年 ivan. All rights reserved.
//

#import "StatusModel.h"
#import "TTNetworkManager.h"
#import "ImageUploadResultModel.h"

@interface BaseRequest : NSObject


//通用上传图片接口
+ (void)uploadImageWithParams:(NSDictionary *)params image:(UIImage *)image success:(void(^)(ImageUploadResultModel *resultModel))success failure:(void(^)(StatusModel *status))failure;

@end
