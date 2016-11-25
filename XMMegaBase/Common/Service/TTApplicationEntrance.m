//
//  ApplicationEntrance.m
//  HongBao
//
//  Created by Ivan on 16/1/21.
//  Copyright © 2016年 ivan. All rights reserved.
//

#import "TTApplicationEntrance.h"
#import "TTNavigationController.h"

@interface TTApplicationEntrance ()

@end

@implementation TTApplicationEntrance

+ (TTApplicationEntrance*)shareEntrance
{
    static TTApplicationEntrance *entrance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        entrance = [[TTApplicationEntrance alloc] init];
    });
    return entrance;
}

- (UIWindow*)backendWindow
{
    if (!_window) {
        
        if([[UIApplication sharedApplication].delegate respondsToSelector:@selector(window)])
        {
            _window = [[UIApplication sharedApplication].delegate performSelector:@selector(window)];
        }else{
            _window = [[UIApplication sharedApplication].windows firstObject];
        }
    }

    return _window;

}

- (TTNavigationController *)currentNavigationController
{
    UIViewController *rootController = [UIApplication sharedApplication].keyWindow.rootViewController;
    
    if (self.currentNavController) {
        return self.currentNavController;
    }
    
    TTNavigationController *nav;
    if ([rootController isKindOfClass:[TTNavigationController class]]) {
        nav = (TTNavigationController *)rootController;
        self.currentNavController = nav;
    } else if ([rootController isKindOfClass:[UITabBarController class]]) {
        UITabBarController *tabbarController = (UITabBarController *)rootController;
        if ([tabbarController.selectedViewController isKindOfClass:[TTNavigationController class]]) {
            nav = (TTNavigationController *)tabbarController.selectedViewController;
            self.currentNavController = nav;
        }
    }
    return nav;
}

@end
