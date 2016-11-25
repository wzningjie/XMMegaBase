//
//  UserInfoModel.h
//  HongBao
//
//  Created by Ivan on 16/3/5.
//  Copyright © 2016年 ivan. All rights reserved.
//

#import "BaseModel.h"

@protocol UserInfoModel

@end

@interface UserInfoModel : BaseModel

@property (nonatomic, strong) NSString *phone;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *userId;
@property (nonatomic, strong) NSString<Optional> *avatar;
@property (nonatomic, strong) NSString *sign;
@property (nonatomic, strong) NSString<Optional> *gender;
// IM
@property (nonatomic, strong) NSString<Optional> *token;
@property (nonatomic, strong) NSString<Optional> *account;

@end
