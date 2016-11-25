//
//  BaseWebViewController.m
//  HongBao
//
//  Created by Ivan on 16/2/8.
//  Copyright © 2016年 ivan. All rights reserved.
//

#import "BaseWebViewController.h"
#import "TTActivityIndicatorView.h"
#import "TTNavigationService.h"
#import "TTUrlHelper.h"
#import "Macros.h"
#import "UIView+TT.h"
#import "UserService.h"
#import "NSMutableDictionary+NullCheck.h"
#import "TTApplicationEntrance.h"
#import "SDWebImageManager.h"
#import "WXApiManager.h"
#import "XMAppThemeHelper.h"
#import "AppInfoManager.h"
#import "UIImage+TT.h"


@interface BaseWebViewController ()<UIActionSheetDelegate>

@property (nonatomic, strong) UIButton* closeButton;
@property (nonatomic, strong) UIButton* shareButton;

@property (nonatomic, assign) BOOL hasClose;

@end

@implementation BaseWebViewController

-(void)viewDidLoad{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self addWebView];
    [self loadRequest];
    [self addNavigationBar];

    [self addShareButton];
    
}

#pragma mark - Custom Methods

- (void)addShareButton {
    
    if ( IsEmptyString(self.shareUrl) || IsEmptyString(self.shareDesc) || IsEmptyString(self.shareImage) || IsEmptyString(self.shareTitle) ) {
        return;
    }
   
    self.shareButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.shareButton.frame = CGRectMake(0, 0, 50, 20);
    [self.shareButton setTitle:@"分享" forState:UIControlStateNormal];
    [self.shareButton setTitleColor:[XMAppThemeHelper defaultTheme].navigationBarButtonColor forState:UIControlStateNormal];
    self.shareButton.titleLabel.font = FONT(14);
    [self.shareButton addTarget:self action:@selector(handleShareButton) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationBar.rightBarButton = self.shareButton;
    
}

- (void)addWebView{
    
    self.webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, NAVBAR_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT - NAVBAR_HEIGHT)];
    self.webView.backgroundColor = Color_White;
    [self.view addSubview:self.webView];
    self.webView.scalesPageToFit = YES;
    self.webView.delegate = self;
}

- (void)addNavigationBar
{
    [super addNavigationBar];
    self.navigationBar.titleLabel.centerY = self.navigationBar.leftBarButton.height / 2;
}

-(void)loadRequest{
    
    if (self.url) {
        
        NSString *strUrl = [_url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSURL *url = [NSURL URLWithString:strUrl];
        
        if (IsEmptyString(url.scheme) && !IsEmptyString(_url)) {
            if (![_url hasPrefix:@"http://"]) {
                NSString *preUrl = @"http://";
                _url = [NSString stringWithFormat:@"%@%@", preUrl, _url];
            }
        }
        
        if ( [UserService sharedService].isLogin ) {
            
            NSMutableDictionary *params = [NSMutableDictionary dictionary];
            [params setSafeObject:[UserService sharedService].sign forKey:@"sign"];
            
            _url = [TTUrlHelper addParamsToUrl:_url fromDictionary:params];
        }
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        [params setSafeObject:@"ios" forKey:@"platform"];
        [params setSafeObject:[AppInfoManager shortVersionString] forKey:@"versionName"];
        _url = [TTUrlHelper addParamsToUrl:_url fromDictionary:params];

        NSMutableURLRequest *requestObj = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[_url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];
        
        [self.webView loadRequest:requestObj];
    }
    
}

#pragma mark - Private Methods

- (void)clickback{

    if ([self.webView canGoBack]) {
        [self.webView goBack];
        if (!self.hasClose && [self.webView canGoBack] && [self canGoBack]) {
            [self addCloseButton];
        }
        [self adjustTitle];
    }
    else {
        self.hasClose = NO;
        [self close];
    }
    
}

- (void)close{
    [super clickback];
}

-(void)adjustTitle{
    
    if(self.hasClose){
        self.navigationBar.titleLabel.width = SCREEN_WIDTH - (self.closeButton.left + 40)*2;
        self.navigationBar.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.navigationBar.titleView.width = SCREEN_WIDTH - (self.closeButton.left + 40)*2;
        self.navigationBar.titleView.left = self.closeButton.left + 40;
    }
    
}

- (void)addCloseButton {
    
    self.closeButton = [[UIButton alloc] init];
    [self.closeButton setTitle:@"关闭" forState:UIControlStateNormal];
    [self.closeButton setTitleColor:[XMAppThemeHelper defaultTheme].navigationBarButtonColor forState:UIControlStateNormal];
    self.closeButton.titleLabel.font = FONT(16);
    self.closeButton.width = 32;
    self.closeButton.height = 20;
    self.closeButton.centerY = self.navigationBar.leftBarButton.height/2;
    [self.closeButton addTarget:self action:@selector(close) forControlEvents:UIControlEventTouchUpInside];
    self.closeButton.left = self.navigationBar.leftBarButton.right;
    [self.navigationBar.containerView addSubview:self.closeButton];
    
    self.hasClose = YES;
}

- (BOOL)canGoBack {
    UINavigationController *navigationController = [[TTApplicationEntrance shareEntrance] currentNavigationController];
    return navigationController.viewControllers.count > 1 && self == navigationController.viewControllers.lastObject;
}

- (void)webViewLoadTime
{
    [TTActivityIndicatorView hideActivityIndicatorForView:self.view animated:YES];
}

#pragma mark - UIWebViewDelegate

-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    
    NSString *strUrl = [request.URL.absoluteString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *url = [NSURL URLWithString:strUrl];
    
    if ( [APP_SCHEME isEqualToString:url.scheme] || (0 < [url.scheme length]
                                                     && (![@"http" isEqualToString:url.scheme])
                                                     && (![@"https" isEqualToString:url.scheme]))) {
        
        [[TTNavigationService sharedService] openUrl:request.URL.absoluteString];
        
        return NO;
        
    }
    
    return YES;
}

-(void)webViewDidStartLoad:(UIWebView *)webView{
    [TTActivityIndicatorView showInView:self.view animated:YES];
    [self setTitle:@"加载中..."];
    
    [NSTimer scheduledTimerWithTimeInterval:10 target:self selector:@selector(webViewLoadTime) userInfo:nil repeats:NO];
}

-(void)webViewDidFinishLoad:(UIWebView *)webView{
    
    [TTActivityIndicatorView hideActivityIndicatorForView:self.view animated:YES];
    
    NSString *title = [self.webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    [self setTitle:title];
    
}

-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    
    [TTActivityIndicatorView hideActivityIndicatorForView:self.view animated:YES];
    
    NSString *title = [self.webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    [self setTitle:title];
    
}

#pragma mark - Event Response

- (void)handleShareButton{
    
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"分享" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"微信好友", @"微信朋友圈", nil];
    [actionSheet showInView:self.view];
    
}

#pragma mark - UIActionSheetDelegate

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex) {
        case 0: // 微信好友
        {
            
            NSURL *shareImageUrl = [NSURL URLWithString:self.shareImage];
            
            [[SDWebImageManager sharedManager] downloadImageWithURL:shareImageUrl options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
                
            } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
                
                UIImage *compressedImage = [image imageWithFileSize:32*1024 scaledToSize:CGSizeMake(300, 300)];

                WXMediaMessage *message = [WXMediaMessage message];
                
                message.title = self.shareTitle;
                
                message.description = self.shareDesc;
                
                [message setThumbImage:compressedImage];
                
                WXWebpageObject *webpageObject = [WXWebpageObject object];
                
                webpageObject.webpageUrl = self.shareUrl;
                
                message.mediaObject = webpageObject;
                
                SendMessageToWXReq *req = [[SendMessageToWXReq alloc] init];
                
                req.bText= NO;
                
                req.message = message;
                
                req.scene = WXSceneSession;
                                
                [WXApi sendReq:req];
                
            }];
            
        }
            break;
        case 1: // 微信朋友圈
        {
            
            NSURL *shareImageUrl = [NSURL URLWithString:self.shareImage];
            
            [[SDWebImageManager sharedManager] downloadImageWithURL:shareImageUrl options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
                
            } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
                
                UIImage *compressedImage = [image imageWithFileSize:32*1024 scaledToSize:CGSizeMake(300, 300)];

                WXMediaMessage *message = [WXMediaMessage message];
                
                message.title = self.shareTitle;
                
                message.description = self.shareDesc;
                
                [message setThumbImage:compressedImage];
                
                WXWebpageObject *webpageObject = [WXWebpageObject object];
                
                webpageObject.webpageUrl = self.shareUrl;
                
                message.mediaObject = webpageObject;
                
                SendMessageToWXReq *req = [[SendMessageToWXReq alloc] init];
                
                req.bText= NO;
                
                req.message = message;
                
                req.scene = WXSceneTimeline;
                
                [WXApi sendReq:req];
                
            }];
            
        }
            break;
        default:
            break;
    }
}

@end
