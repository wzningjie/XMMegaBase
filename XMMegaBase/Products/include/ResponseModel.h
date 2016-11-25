//
//  ResponseModel.h
//  HongBao
//
//  Created by Ivan on 16/1/24.
//  Copyright © 2016年 ivan. All rights reserved.
//

#import "BaseModel.h"
#import "StatusModel.h"

@interface ResponseModel : BaseModel

@property (strong, nonatomic) StatusModel* status;
@property (strong, nonatomic) NSDictionary<Optional>* result;

@end