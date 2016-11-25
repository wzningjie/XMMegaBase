//
//  UserService.m
//  HongBao
//
//  Created by Ivan on 16/3/4.
//  Copyright © 2016年 ivan. All rights reserved.
//

#import "UserService.h"
#import "KeyMarco.h"
#import "TTNavigationService.h"

#define KEY_EXTRA   @"com.xiaoma.modules.megabase.userService.extraParams"
#define KEY_USERID  @"com.xiaoma.modules.megabase.userService.userId"
#define KEY_ISLOGIN @"com.xiaoma.modules.megabase.userService.isLogin"
#define KEY_NAME    @"com.xiaoma.modules.megabase.userService.name"
#define KEY_PHONE   @"com.xiaoma.modules.megabase.userService.phone"
#define KEY_AVATAR  @"com.xiaoma.modules.megabase.userService.avatar"
#define KEY_SIGN    @"com.xiaoma.modules.megabase.userService.sign"
#define KEY_GENDER  @"com.xiaoma.modules.megabase.userService.gender"
#define KEY_ACCOUNT @"com.xiaoma.modules.megabase.userService.account"
#define KEY_TOKEN   @"com.xiaoma.modules.megabase.userService.token"



@implementation UserService

+ (UserService *)sharedService {
    static dispatch_once_t onceToken;
    static UserService *service = nil;
    dispatch_once(&onceToken, ^{
        service = [[UserService alloc] init];
    });
    return service;
}

- (instancetype)init {
    
    self = [super init];
    
    if ( self ) {
        
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        self.isLogin = [defaults boolForKey:KEY_ISLOGIN];
        
        if ( self.isLogin ) {
            
            self.name = [defaults stringForKey:KEY_NAME];
            self.userId = [defaults stringForKey:KEY_USERID];
            self.phone = [defaults stringForKey:KEY_PHONE];
            self.avatar = [defaults stringForKey:KEY_AVATAR];
            self.sign = [defaults stringForKey:KEY_SIGN];
            self.gender = [defaults stringForKey:KEY_GENDER];
            self.account = [defaults stringForKey:KEY_ACCOUNT];
            self.token = [defaults stringForKey:KEY_TOKEN];
            self.extraParams = [defaults dictionaryForKey:KEY_EXTRA];
        }
        
    }
    
    return self; 
}

- (void)updateInfo:(id)value for:(NSString *)key {
    
    NSString *moduleKey = [NSString stringWithFormat:@"com.xiaoma.modules.megabase.userService.%@",key];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:value forKey:moduleKey];
    [defaults synchronize];
    
    self.isLogin = [defaults boolForKey:KEY_ISLOGIN];
    self.name = [defaults stringForKey:KEY_NAME];
    self.userId = [defaults stringForKey:KEY_USERID];
    self.phone = [defaults stringForKey:KEY_PHONE];
    self.avatar = [defaults stringForKey:KEY_AVATAR];
    self.sign = [defaults stringForKey:KEY_SIGN];
    self.gender = [defaults stringForKey:KEY_GENDER];
    self.account = [defaults stringForKey:KEY_ACCOUNT];
    self.token = [defaults stringForKey:KEY_TOKEN];
    self.extraParams = [defaults dictionaryForKey:KEY_EXTRA];
}

//登录注册存储用户信息
- (void)saveLoginInfo{
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    [defaults setObject:self.name forKey:KEY_NAME];
    [defaults setObject:self.userId forKey:KEY_USERID];
    [defaults setObject:self.phone forKey:KEY_PHONE];
    [defaults setObject:self.avatar forKey:KEY_AVATAR];
    [defaults setObject:self.sign forKey:KEY_SIGN];
    [defaults setObject:self.gender forKey:KEY_GENDER];
    [defaults setObject:self.account forKey:KEY_ACCOUNT];
    [defaults setObject:self.token forKey:KEY_TOKEN];
    [defaults setObject:self.extraParams forKey:KEY_EXTRA];
    [defaults setBool:YES forKey:KEY_ISLOGIN];
    [defaults synchronize];
    self.isLogin = YES;
    
    [[NSNotificationCenter defaultCenter] postNotificationName:kNOTIFY_USER_LOGIN_COMPLETED object:nil];
}

//退出登录清除信息
- (void)logout {
    
    [self clearLoginInfo];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:kNOTIFY_USER_LOGOUT_COMPLETED object:nil];
        
    [[TTNavigationService sharedService] openUrl:@"xiaoma://index"];
    
}

- (void)clearLoginInfo
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    [defaults removeObjectForKey:KEY_NAME];
    [defaults removeObjectForKey:KEY_USERID];
    [defaults removeObjectForKey:KEY_PHONE];
    [defaults removeObjectForKey:KEY_AVATAR];
    [defaults removeObjectForKey:KEY_SIGN];
    [defaults removeObjectForKey:KEY_GENDER];
    [defaults removeObjectForKey:KEY_TOKEN];
    [defaults removeObjectForKey:KEY_ACCOUNT];
    [defaults setBool:NO forKey:KEY_ISLOGIN];
    [defaults removeObjectForKey:KEY_EXTRA];
    [defaults synchronize];
    
    self.name = @"";
    self.userId = @"";
    self.phone = @"";
    self.avatar = @"";
    self.sign = @"";
    self.gender = @"";
    self.token = @"";
    self.account = @"";
    self.extraParams = nil;
    self.isLogin = NO;
}

@end
