//
//  StatusModel.h
//  HongBao
//
//  Created by Ivan on 16/1/24.
//  Copyright © 2016年 ivan. All rights reserved.
//

#import "BaseModel.h"

@protocol StatusModel
@end

@interface StatusModel : BaseModel

@property (nonatomic, assign) NSInteger code;
@property (strong, nonatomic) NSString* msg;

@end