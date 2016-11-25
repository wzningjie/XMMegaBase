//
//  WXApiManager.h
//  SDKSample
//
//  Created by Jeason on 16/07/2015.
//
//

#import <Foundation/Foundation.h>
#import "WXApi.h"

typedef NS_ENUM(NSUInteger, WeChatShareType) {
    WeChatShareSession,
    WeChatShareTimeline,
};

@protocol WXApiManagerDelegate <NSObject>

@optional

- (void)managerDidRecvGetMessageReq:(GetMessageFromWXReq *)request;

- (void)managerDidRecvShowMessageReq:(ShowMessageFromWXReq *)request;

- (void)managerDidRecvLaunchFromWXReq:(LaunchFromWXReq *)request;

- (void)managerDidRecvMessageResponse:(SendMessageToWXResp *)response;

- (void)managerDidRecvAuthResponse:(SendAuthResp *)response;

- (void)managerDidRecvAddCardResponse:(AddCardToWXCardPackageResp *)response;

- (void)managerDidRecvPayResponse:(PayResp *)response;

@end

@interface WXApiManager : NSObject<WXApiDelegate>

@property (nonatomic, weak) id<WXApiManagerDelegate> delegate;

+ (instancetype)sharedManager;

+ (BOOL)isWXAppInstalled;

+ (BOOL)sharedMessageToWeChat:(NSString *)title
                  description:(NSString *)description
                    detailUrl:(NSString *)detailUrl
                        image:(UIImage *)image
                    shareType:(WeChatShareType)sharedType;
@end
