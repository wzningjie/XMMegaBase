//
//  SystemMacro.h
//  HongBao
//
//  Created by Ivan on 16/1/21.
//  Copyright © 2016年 ivan. All rights reserved.
//

#ifndef SystemMacro_h
#define SystemMacro_h
#import "UIMacro.h"
#define SYSTEM_VERSION        [[[UIDevice currentDevice] systemVersion] floatValue]

#define IS_IOS9                     (SYSTEM_VERSION >= 9)
#define IS_IOS8                     (SYSTEM_VERSION >= 8)
#define IS_IOS7                     (SYSTEM_VERSION >= 7)
#define IS_IPHONE4                  (SCREEN_HEIGHT < 568)
#define IS_IPHONE5                  (SCREEN_HEIGHT == 568)
#define IS_IPHONE6                  (SCREEN_HEIGHT == 667)
#define IS_IPHONE6Plus              (SCREEN_HEIGHT == 736)

//#define APP_SCHEME @"jump"
#define APP_SCHEME @"xiaoma"

#endif /* SystemMacro_h */
