
#import <UIKit/UIKit.h>
#import "AFNetworkReachabilityManager.h"

#include <sys/sysctl.h>
#include <net/if.h>
#include <net/if_dl.h>
#include <ifaddrs.h>
#include <arpa/inet.h>

@interface UIDevice (TT)

+ (NSString *)TT_deviceName;

/**
 *  小世界设备唯一识别码 iOS 6 及以下用 MAC 地址，iOS 7 以后用 IDFA，IDFA 取不到的情况下使用时间戳（精确到小数点后5位）+ 随机数（0-9999）
 */
+ (NSString *)TT_uniqueID;

@end
