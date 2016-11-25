//
//  TTNavigationService.m
//  HongBao
//
//  Created by Ivan on 16/1/21.
//  Copyright © 2016年 ivan. All rights reserved.
//


#import "TTNavigationService.h"
#import "TTModuleEntrance.h"
#import "Macros.h"
#import "NSString+TT.h"

@interface TTNavigationService ()

@property (nonatomic, strong) NSMutableDictionary *registeredModules;

@end

BOOL isPushing;

@implementation TTNavigationService

+ (TTNavigationService *)sharedService {
    static dispatch_once_t onceToken;
    static TTNavigationService *service = nil;
    dispatch_once(&onceToken, ^{
        service = [[TTNavigationService alloc] init];
    });
    return service;
}

#pragma mark - properties
- (NSMutableDictionary *)registeredModules {
    if (!_registeredModules) {
        _registeredModules = [NSMutableDictionary dictionary];
    }
    return _registeredModules;
}

#pragma mark - instance method
- (void)registerModule:(Class)moduleClass withScheme:(NSString *)scheme host:(NSString *)host {
    if (!scheme) {
        return;
    }
    
    if ([moduleClass isSubclassOfClass:[TTModuleEntrance class]]) {
        TTModuleEntrance *moduleEntrance = [moduleClass performSelector:@selector(sharedEntrance) withObject:nil];
        if (moduleEntrance) {
            NSMutableDictionary *hostDict = self.registeredModules[scheme];
            if (!hostDict) {
                hostDict = [NSMutableDictionary dictionary];
                [self.registeredModules setObject:hostDict forKey:scheme];
            }
            if (!host || [host.trim isEqualToString : @""]) {
                [hostDict setObject:moduleEntrance forKey:[NSNull null]];
            }
            else
            {
                [hostDict setObject:moduleEntrance forKey:host];
            }
            
        }
        else
        {
            DBG(@"error: 未实现 %@ 的 sharedEntrance 方法",moduleClass);
        }
    }
}

- (void)openUrl:(NSString *)urlString
{
    [self openUrl:urlString userInfo:nil];
}

- (void)openUrl:(NSString *)urlString userInfo:(NSDictionary *)userInfo {
    [self openUrl:urlString userInfo:userInfo from:nil complete:nil];
}

- (void)openUrl:(NSString *)urlString userInfo:(NSDictionary *)userInfo from:(id)from complete:(void (^)())complete {
    
    
    if (!IsEmptyString(urlString)) {
        
        NSString *resultUrlString = [urlString trim];
        
        NSString *strUrl = [resultUrlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSURL *url = [NSURL URLWithString:strUrl];
        
        
        if (IsEmptyString(url.scheme) && !IsEmptyString(resultUrlString)) {
            if (![resultUrlString hasPrefix:@"http://"]) {
                NSString *preUrl = @"http://";
                resultUrlString = [NSString stringWithFormat:@"%@%@", preUrl, resultUrlString];
                url = [NSURL URLWithString:resultUrlString];
            }
        }
        
        if (url) {
            
            TTModuleEntrance *moduleEntrance = self.registeredModules[url.scheme][[NSNull null]];
            if (!moduleEntrance) {
                moduleEntrance = self.registeredModules[url.scheme][url.host];
            }
            if (moduleEntrance) {
                
                [moduleEntrance handleOpenUrl:resultUrlString userInfo:userInfo from:from complete:complete];
                
            }
            else
            {
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:resultUrlString]];
            }
        }
    }
}

- (BOOL)canOpenUrl:(NSString *)urlString userInfo:(NSDictionary *)userInfo from:(id)from
{
    BOOL result = NO;
    
    NSString *resultUrlString = [urlString trim];
    
    NSURL *url = [NSURL URLWithString:resultUrlString];
    
    if (url) {
        TTModuleEntrance *moduleEntrance = self.registeredModules[url.scheme][[NSNull null]];
        if (!moduleEntrance) {
            moduleEntrance = self.registeredModules[url.scheme][url.host];
        }
        
        if (moduleEntrance) {
            result = [moduleEntrance canOpenUrl:resultUrlString userInfo:userInfo from:from];
        }
        
    }
    return result;
}
@end
