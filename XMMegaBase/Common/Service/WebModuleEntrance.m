//
//  WebModuleEntrance.m
//  HongBao
//
//  Created by Ivan on 16/2/8.
//  Copyright © 2016年 ivan. All rights reserved.
//

#import "WebModuleEntrance.h"

#import "TTNavigationService.h"
#import "TTNavigationController.h"
#import "TTApplicationEntrance.h"

#import "BaseWebViewController.h"
#import "SystemMacro.h"
#import "NSURL+TT.h"
#import "NSString+TT.h"

@implementation WebModuleEntrance

+ (id)sharedEntrance
{
    static dispatch_once_t onceToken;
    static WebModuleEntrance *moduleEntrance = nil;
    dispatch_once(&onceToken, ^{
        moduleEntrance = [[WebModuleEntrance alloc] init];
    });
    return moduleEntrance;
}

+ (void)load
{
    [[TTNavigationService sharedService] registerModule:self withScheme:@"http" host:nil];
    [[TTNavigationService sharedService] registerModule:self withScheme:@"https" host:nil];
    //webview
    [[TTNavigationService sharedService] registerModule:self withScheme:APP_SCHEME host:@"web"];
    
}

- (void)handleOpenUrl:(NSString *)urlString userInfo:(NSDictionary *)userInfo from:(id)from complete:(void (^)())complete
{
    TTNavigationController *navigationController = [[TTApplicationEntrance shareEntrance] currentNavigationController];

    NSString *strUrl = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *url = [NSURL URLWithString:strUrl];
    
    NSMutableDictionary *urlParams = [[url parameters] mutableCopy];
    
    if ([url.scheme isEqualToString:@"http"] || [url.scheme isEqualToString:@"https"]) {
        
        BaseWebViewController *vc = [[BaseWebViewController alloc] init];
        vc.url = urlString;
        [navigationController pushViewController:vc animated:YES];
        
    } else if( [url.scheme isEqualToString:APP_SCHEME] ){
        
        if([url.host isEqualToString:@"web"]) {
            
            BaseWebViewController *vc = [[BaseWebViewController alloc] init];
            
            vc.url = [urlParams[@"url"] urldecode];
            vc.shareUrl = urlParams[@"shareUrl"];
            vc.shareDesc = urlParams[@"shareDesc"];
            vc.shareImage = urlParams[@"shareImage"];
            vc.shareTitle = urlParams[@"shareTitle"];
            
            [navigationController pushViewController:vc animated:YES];
            
        }
        
    }
    
}

@end
