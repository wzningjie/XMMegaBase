//
//  CustomUserInfoModel.h
//  XMMegaBase
//
//  Created by marco on 8/22/16.
//  Copyright © 2016 marco. All rights reserved.
//

#import "BaseModel.h"

@interface CustomUserInfoModel : BaseModel


@property (nonatomic, strong) NSString *nickName;
@property (nonatomic, assign) NSUInteger age;
@property (nonatomic, strong) NSString *phone;
@property (nonatomic, strong) NSString *avatar;
@property (nonatomic, strong) NSString *gender;



@end
