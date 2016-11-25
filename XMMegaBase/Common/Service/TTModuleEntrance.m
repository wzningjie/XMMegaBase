//
//  TTModuleEntrance.m
//  HongBao
//
//  Created by Ivan on 16/1/21.
//  Copyright © 2016年 ivan. All rights reserved.
//

#import "TTModuleEntrance.h"

@implementation TTModuleEntrance

+ (id)sharedEntrance {
    return nil;
}

- (id)init
{
    self = [super init];
    if (self) {
        [self addNotifications];
    }
    return self;
}

- (void)addNotifications
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationDidEnterBackground:) name:UIApplicationDidEnterBackgroundNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationWillEnterForeground:) name:UIApplicationWillEnterForegroundNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationDidFinishLaunching:) name:UIApplicationDidFinishLaunchingNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationDidBecomeActive:) name:UIApplicationDidBecomeActiveNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationWillResignActive:) name:UIApplicationWillResignActiveNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationDidReceiveMemoryWarning:) name:UIApplicationDidReceiveMemoryWarningNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationWillTerminate:) name:UIApplicationWillTerminateNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationSignificantTimeChange:) name:UIApplicationSignificantTimeChangeNotification object:nil];
}

- (BOOL)canOpenUrl:(NSString *)urlString userInfo:(NSDictionary *)userInfo from:(id)from
{
    return YES;
}

- (void)handleOpenUrl:(NSString *)urlString userInfo:(NSDictionary *)userInfo from:(id)from complete:(void (^)())complete
{
   
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - notifications

- (void)applicationDidEnterBackground:(NSNotification *)notification
{
    
}

- (void)applicationWillEnterForeground:(NSNotification *)notification
{
    
}

- (void)applicationDidFinishLaunching:(NSNotification *)notification
{
    
}

- (void)applicationDidBecomeActive:(NSNotification *)notification
{
    
}

- (void)applicationWillResignActive:(NSNotification *)notification
{
    
}

- (void)applicationDidReceiveMemoryWarning:(NSNotification *)notification
{
    
}

- (void)applicationWillTerminate:(NSNotification *)notification
{
    
}

- (void)applicationSignificantTimeChange:(NSNotification *)notification
{
    
}

@end
