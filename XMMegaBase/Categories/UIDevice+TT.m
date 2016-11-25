
#import "UIDevice+TT.h"
#import "NSString+TT.h"
#import "AFNetworking.h"
#import <AdSupport/AdSupport.h>
#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#import <CoreTelephony/CTCarrier.h>

@implementation UIDevice (TT)

+ (NSString *)TT_deviceName
{
    static NSString *deviceName = nil;
    
    if (!deviceName) {
        size_t size;
        sysctlbyname("hw.machine", NULL, &size, NULL, 0);
        char *name = malloc(size);
        sysctlbyname("hw.machine", name, &size, NULL, 0);
        
        deviceName = [NSString stringWithCString:name encoding:NSUTF8StringEncoding];
        free(name);
        
        if( [@"i386" isEqualToString:deviceName] || [@"x86_64" isEqualToString:deviceName] ) {
            deviceName = @"iOS_Simulator";
        }
    }
    
    return deviceName;
}

+ (NSString *)TT_uniqueID
{
    static NSString *kTTUniqueIDKey = @"TT_unique_key";
    NSString *uniqueId = @"";
    
    if (NSClassFromString(@"ASIdentifierManager")) {
        if ([ASIdentifierManager sharedManager].isAdvertisingTrackingEnabled) {
            uniqueId = [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
        }
    }
    
    if (!uniqueId) {//不存在说明用户关闭了广告跟踪
        uniqueId = [[NSUserDefaults standardUserDefaults] objectForKey:kTTUniqueIDKey];
        if (!uniqueId) {
            NSString *timeString = [NSString stringWithFormat:@"%.5f",[[NSDate date] timeIntervalSince1970]];
            NSString *randomString = [NSString stringWithFormat:@"%d", arc4random() % 10000/*0-9999*/];
            
            uniqueId = [[timeString stringByAppendingString:randomString] md5];
            
            [[NSUserDefaults standardUserDefaults] setObject:uniqueId forKey:kTTUniqueIDKey];
            [[NSUserDefaults standardUserDefaults] synchronize];
        }
    }
    
    return uniqueId;
}

@end
