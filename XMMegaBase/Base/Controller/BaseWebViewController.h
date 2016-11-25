//
//  BaseWebViewController.h
//  HongBao
//
//  Created by Ivan on 16/2/8.
//  Copyright © 2016年 ivan. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseWebViewController : BaseViewController <UIWebViewDelegate>

@property (nonatomic, strong) NSString *url;
@property (nonatomic, strong) NSString *shareUrl;
@property (nonatomic, strong) NSString *shareTitle;
@property (nonatomic, strong) NSString *shareImage;
@property (nonatomic, strong) NSString *shareDesc;

@property (nonatomic,strong) UIWebView* webView;

- (void)loadRequest;

- (void)addWebView;

@end
