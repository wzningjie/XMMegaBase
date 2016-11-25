//
//  MCPlistHelper.m
//  LianWei
//
//  Created by marco on 8/11/16.
//  Copyright © 2016 marco. All rights reserved.
//

#import "AppInfoManager.h"

@implementation AppInfoManager

//+(instancetype)sharedManager {
//    static dispatch_once_t onceToken;
//    static AppInfoManager *instance;
//    dispatch_once(&onceToken, ^{
//        instance = [[AppInfoManager alloc] init];
//    });
//    return instance;
//}

+ (NSString*)shortVersionString
{
    return [[NSBundle mainBundle] infoDictionary][@"CFBundleShortVersionString"];
}

+ (NSString*)bundleVersion
{
    return [[NSBundle mainBundle] infoDictionary][(__bridge NSString *)kCFBundleVersionKey];
}

+ (NSString*)identifierKey
{
    return [[NSBundle mainBundle] infoDictionary][(__bridge NSString *)kCFBundleIdentifierKey];
}

+ (NSString*)urlSchemeForIdentifier:(NSString*)identifier
{
    NSString *urlSchema = nil;
    NSDictionary * result = [[NSBundle mainBundle] infoDictionary];
    NSArray* cfBundleURLTypes = [result objectForKey:@"CFBundleURLTypes"];
    if ([cfBundleURLTypes isKindOfClass:[NSArray class]] && [cfBundleURLTypes lastObject]) {
        for (NSDictionary *urlType in cfBundleURLTypes) {
            NSString *cfBundleURLName = [urlType objectForKey:@"CFBundleURLName"];
            if ([cfBundleURLName isEqualToString:identifier]) {
                NSArray* cfBundleURLSchemes = [urlType objectForKey:@"CFBundleURLSchemes"];
                if ([cfBundleURLSchemes isKindOfClass:[NSArray class]]) {
                    urlSchema = [cfBundleURLSchemes firstObject];
                }
            }
            
        }
    }
    return urlSchema;
}

+ (AppBundleState)appBundleState;
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *lastVersion = [defaults objectForKey:@"lastVersion"];
    NSString *nowVersion = [AppInfoManager shortVersionString];
    if (!lastVersion) {
        [defaults setObject:nowVersion forKey:@"lastVersion"];
        [defaults synchronize];
        //新装
        return AppBundleNewInstalled;
    }else{
        NSComparisonResult updated = [lastVersion compare:nowVersion options:NSNumericSearch];
        AppBundleState result;
        switch (updated) {
            case NSOrderedAscending:
                result = AppBundleUpdated;
                break;
            case NSOrderedSame:
                result = AppBundleNormal;
                break;
            case NSOrderedDescending:
                result = AppBundleDowngrade;
            default:
                break;
        }
        [defaults setObject:nowVersion forKey:@"lastVersion"];
        [defaults synchronize];
        return result;
    }
}
@end
