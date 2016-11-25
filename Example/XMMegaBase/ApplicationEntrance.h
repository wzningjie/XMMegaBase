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

@interface ApplicationEntrance : NSObject<TTTabbarControllerDelegate>

@property(nonatomic, strong) TTTabbarController *tabbarController;
@property(nonatomic, strong) UIWindow *window;
@property(nonatomic, strong) TTNavigationController *currentNavController;

+ (ApplicationEntrance*)shareEntrance;

- (void)applicationEntrance:(UIWindow *)mainWindow launchOptions:(NSDictionary *)launchOptions;
- (void)applicationDidEnterBackground:(UIApplication *)application;
- (void)applicationActive;
- (void)applicationEnterBackground;
- (void)handleOpenURL:(NSString *)aUrl;
- (void)applicationRegisterDeviceToken:(NSData*)deviceToken;
- (void)applicationFailToRegisterDeviceToken:(NSError*)error;
- (void)applicationReceiveNotifaction:(NSDictionary*)userInfo;


- (BOOL)applicationOpenURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation;
- (BOOL)applicationHandleOpenURL:(NSURL *)url;
- (TTNavigationController *)currentNavigationController;

@end
