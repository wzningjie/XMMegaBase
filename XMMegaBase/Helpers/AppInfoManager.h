//
//  AppInfoManager.h
//  LianWei
//
//  Created by marco on 8/11/16.
//  Copyright © 2016 marco. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, AppBundleState) {
    AppBundleNewInstalled  = 0,
    AppBundleNormal        = 1,
    AppBundleUpdated       = 2,
    AppBundleDowngrade     = 3,
};

@interface AppInfoManager : NSObject

// for example, "1.0"
+ (NSString *)shortVersionString;

// for example, "1"
+ (NSString *)bundleVersion;

// for example, "com.xiaoma.zbh"
+ (NSString *)identifierKey;

// for example, "wx1939392200202"
+ (NSString*)urlSchemeForIdentifier:(NSString*)identifier;

// get current app bundle State, it will automatically update
// appBundleState after invocation.
+ (AppBundleState)appBundleState;

@end
