//
//  ApplicationEntrance.m
//  HongBao
//
//  Created by Ivan on 16/1/21.
//  Copyright © 2016年 ivan. All rights reserved.
//

#import "ApplicationEntrance.h"

#import "TTAppLaunchView.h"
#import "TTNavigationService.h"

#import "XMViewController.h"
#import "XMBaseViewController.h"


#import "UserService.h"

#import "XMAppThemeHelper.h"
#import "ColorMarco.h"
#import "KeyMarco.h"

@interface ApplicationEntrance ()

@end

@implementation ApplicationEntrance

+ (ApplicationEntrance*)shareEntrance
{
    static ApplicationEntrance *entrance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        entrance = [[ApplicationEntrance alloc] init];
    });
    return entrance;
}

- (void)applicationEntrance:(UIWindow *)mainWindow launchOptions:(NSDictionary *)launchOptions
{
    
    self.window = mainWindow;
    
    [self configTheme];
    
    [self registerAPNs];
    
    //主页面初始化
    [self initViewControllers];
    
    //应用初始化
    [self appInit];
    
    
    
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
    
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
    //当程序被推送调起，处理推送
    NSDictionary *remoteNotification = [launchOptions objectForKey:UIApplicationLaunchOptionsRemoteNotificationKey];
    if (remoteNotification) {
        [self didReceiveRemoteNotification:remoteNotification];
    }
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    
}

- (void)applicationActive
{
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
}

- (void)applicationEnterBackground
{

}

- (void)handleOpenURL:(NSString *)aUrl
{
    [[TTNavigationService sharedService] openUrl:aUrl];
}

- (void)applicationRegisterDeviceToken:(NSData*)deviceToken
{

}

- (void)applicationFailToRegisterDeviceToken:(NSError*)error
{
    
}

- (void)applicationReceiveNotifaction:(NSDictionary*)userInfo
{
    [self didReceiveRemoteNotification:userInfo];

}

- (BOOL)applicationOpenURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    
    return NO;
}

- (BOOL)applicationHandleOpenURL:(NSURL *)url {
    
    
    return NO;
    
}

- (void)didReceiveRemoteNotification:(NSDictionary*)userInfo
{

}

- (void)configTheme
{
    XMAppThemeHelper *theme = [XMAppThemeHelper defaultTheme];
    theme.mainThemeColor = Color_Yellow;
    theme.mainThemeContrastColor = Color_White;
    theme.navigationBarBackgroundColor = Color_White;
    theme.navigationBarTintColor = Color_Yellow;
    theme.navigationBarBackColor = Color_Yellow;
    theme.navigationBarButtonColor = Color_Gray66;
    theme.navigationBarBottomColor = Color_Gray230;
    theme.navigationBarTitleColor = Color_Yellow;
    
    //theme.backButtonIconName = @"icon_selected";
}

// 初始化数据
- (void)appInit
{
    
    [TTAppLaunchView sharedInstance];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:kNOTIFY_APP_LAUNCH_LOADING object:nil];
    
}


- (void)registerAPNs
{
    
    if ([[UIApplication sharedApplication] respondsToSelector:@selector(registerForRemoteNotifications)])
    {
        UIUserNotificationType types = UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound | UIRemoteNotificationTypeAlert;
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:types
                                                                                 categories:nil];
        [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
        [[UIApplication sharedApplication] registerForRemoteNotifications];
    }
    else
    {
        UIRemoteNotificationType types = UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeSound | UIRemoteNotificationTypeBadge;
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:types];
    }
}

- (void)initViewControllers
{
    self.tabbarController = [[TTTabbarController alloc] initWithViewControllers:
                            @[
                              [[XMViewController alloc] initWithTitle:@"test"],

                              ]
                            ];
    
    self.tabbarController.tabBarControllerDelegate = self;
    
    TTNavigationController *navigationController = [[TTNavigationController alloc] initWithRootViewController:self.tabbarController];
    self.window.rootViewController = navigationController;
    [self.window makeKeyAndVisible];
    
    self.currentNavController = navigationController;
    
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

#pragma mark - TTTabBarDelegate
- (BOOL)tabBarController:(TTTabbarController *)tabBarController shouldSelectViewController:(BaseViewController *)viewController atIndex:(NSInteger)index
{

    
    return YES;
}

- (void)tabBarController:(TTTabbarController *)tabBarController didSelectViewController:(BaseViewController *)viewController atIndex:(NSInteger)index
{

}

@end
