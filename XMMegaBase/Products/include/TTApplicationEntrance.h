//
//  ApplicationEntrance.h
//  HongBao
//
//  Created by Ivan on 16/1/21.
//  Copyright © 2016年 ivan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TTTabbarController.h"
#import "TTNavigationController.h"

/**
 *  TTApplicationEntrance 被用于模块识别应用结构，例如跳转，增加视图等操作。你应当设置对应的属性。
    如果不设置，TTApplicationEntrance将自动完成识别window和currentNavigationController。
 */

@interface TTApplicationEntrance : NSObject

@property(nonatomic, strong) TTTabbarController *tabbarController;
@property(nonatomic, strong) UIWindow *window;
@property(nonatomic, strong) TTNavigationController *currentNavController;

+ (TTApplicationEntrance*)shareEntrance;

- (UIWindow*)backendWindow;

- (TTNavigationController *)currentNavigationController;

@end
