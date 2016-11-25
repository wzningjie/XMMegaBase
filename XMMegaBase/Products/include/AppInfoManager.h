//
//  AppInfoManager.h
//  LianWei
//
//  Created by marco on 8/11/16.
//  Copyright © 2016 marco. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AppInfoManager : NSObject

// for example, "1.0"
+ (NSString *)shortVersionString;

// for example, "1"
+ (NSString *)bundleVersion;

// for example, "com.xiaoma.zbh"
+ (NSString *)identifierKey;

// for example, "wx1939392200202"
+ (NSString*)urlSchemeForIdentifier:(NSString*)identifier;

@end
