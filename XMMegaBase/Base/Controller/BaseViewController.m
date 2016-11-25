//
//  BaseViewController.m
//  HongBao
//
//  Created by Ivan on 16/1/21.
//  Copyright © 2016年 ivan. All rights reserved.
//

#import "BaseViewController.h"
#import "ShortcutMacro.h"
#import "UIView+TT.h"
#import "ColorMarco.h"
#import "UIButton+TT.h"
#import "UIMacro.h"
#import "XMAppThemeHelper.h"

@interface BaseViewController ()
{
    
}

@property (nonatomic, strong) UIImageView *defaultView;

@end

@implementation BaseViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    DBG(@"viewWillAppear %@", NSStringFromClass(self.class));
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    DBG(@"viewWillDisappear %@", NSStringFromClass(self.class));
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    self.view.top = 0;
    if (!CGRectIsEmpty(_defaultFrame)) {
        self.view.frame = _defaultFrame;
    }
    self.view.backgroundColor = Color_White;
    [self.navigationController.navigationBar setHidden:YES];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.needBlurEffect = YES;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - navigation bar

- (void)setTitle:(NSString *)title
{
    [super setTitle:title];
    if (_navigationBar) {
        [_navigationBar setTitle:title];
    }
}

- (void)addNavigationBar
{
    if (!_navigationBar) {
        
        _navigationBar = [[TTNavigationBar alloc] initWithFrame:CGRectMake(0, 0, self.view.width, NAVBAR_HEIGHT) needBlurEffect:self.needBlurEffect];
        _navigationBar.backgroundColor = [XMAppThemeHelper defaultTheme].navigationBarBackgroundColor;
        _navigationBar.tintColor = [XMAppThemeHelper defaultTheme].navigationBarTintColor;
        _navigationBar.title = self.title;
    }
    
    if (self.navigationController && self.navigationController.viewControllers.count > 1)
    {
        UIButton *backButton = [UIButton backButtonWithTarget:self action:@selector(clickback) forControlEvents:UIControlEventTouchUpInside];
        [_navigationBar setBackBarButton:backButton];
    }
    
    //设置shadow色值
    [_navigationBar setBottomBorderColor:[XMAppThemeHelper defaultTheme].navigationBarBottomColor];
    
    if (!_navigationBar.superview) {
        [self.view addSubview:_navigationBar];
    }
    
}

#pragma mark - Back
- (void)clickback
{
    if (self.navigationController) {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

#pragma mark - Notice view

- (void)showNotice:(NSString *)notice image:(UIImage *)image {
    [self hideNotice];
    
    _noticeView = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:_noticeView];
    _noticeView.userInteractionEnabled = NO;
    
    // Make the customViews 37 by 37 pixels for best results (those are the bounds of the build-in progress indicators)
    _noticeView.customView = [[UIImageView alloc] initWithImage:image];
    
    // Set custom view mode
    _noticeView.mode = MBProgressHUDModeCustomView;
    
//    _noticeView.yOffset = self.view.height / 3 - self.view.height / 2;
    _noticeView.centerY = self.view.centerY;
    _noticeView.labelText = notice;
    _noticeView.margin = 12.f;
    
    [_noticeView show:YES];
    [_noticeView hide:YES afterDelay:1.5f];
}

- (void)showNotice:(NSString *)notice {
    [self showNotice:notice image:nil];
}

- (void)showNoticeOnWindow:(NSString *)notice {
    [self showNoticeOnWindow:notice duration:0.7f];
}

- (void)showNoticeOnWindow:(NSString *)notice duration:(NSTimeInterval)duration{
//    [self hideDefaultView];
    [self hideNotice];
    
    _noticeView = [[MBProgressHUD alloc] initWithView:self.view.window];
    [self.view.window addSubview:_noticeView];
    
    _noticeView.customView = [[UIImageView alloc] initWithImage:nil];
    // Set custom view mode
    _noticeView.mode = MBProgressHUDModeCustomView;
    
//    _noticeView.yOffset = self.view.window.height / 3 - self.view.window.height / 2;
    _noticeView.centerY = self.view.centerY;
    _noticeView.labelText = notice;
    _noticeView.margin = 12.f;
    
    [_noticeView show:YES];
    [_noticeView hide:YES afterDelay:duration];
}

- (void)hideNotice {
    if (nil != _noticeView) {
        [_noticeView hide:YES afterDelay:0.f];
    }
}


#pragma mark -  网络不好的提示
- (void)showErrorTipsOnOwnerView:(UIView *)ownerView {
    
    if (!_errorTipsView) {
        _errorTipsView = [[TTErrorTipsView alloc] initWithFrame:ownerView.bounds];
        _errorTipsView.delegate = self;
        [ownerView addSubview:_errorTipsView];
    }
    else
    {
        [_errorTipsView didFinishLoading];
    }

}

- (void)showErrorTips {

    if (!_errorTipsView) {
        if (_navigationBar) {
            _errorTipsView = [[TTErrorTipsView alloc] initWithFrame:CGRectMake(0, NAVBAR_HEIGHT, self.view.width, self.view.height - NAVBAR_HEIGHT)];
            [self.view insertSubview:_errorTipsView belowSubview:_navigationBar];
        }
        else
        {
            _errorTipsView = [[TTErrorTipsView alloc] initWithFrame:self.view.bounds];
            [self.view addSubview:_errorTipsView];
        }
        _errorTipsView.delegate = self;
        
    }
    else
    {
        [_errorTipsView didFinishLoading];
    }

}

- (void)hideErrorTips {
    [_errorTipsView removeFromSuperview];
    _errorTipsView = nil;
}

#pragma mark - Empty Tips
- (void)showEmptyTips:(NSString *)tips {
    [self showEmptyTips:tips ownerView:self.view];
}

- (void)showEmptyTips:(NSString *)tips ownerView:(UIView *)ownerView {
    [self showEmptyTips:tips ownerView:ownerView offsetTop:0];
}

- (void)showEmptyTips:(NSString *)tips ownerView:(UIView *)ownerView offsetTop:(CGFloat)top{
    if (!_emptyTipsView) {
        _emptyTipsView = [[TTEmptyTipsView alloc] initWithFrame:ownerView.frame tips:tips];
        _emptyTipsView.top = top;
        [ownerView addSubview:_emptyTipsView];
    }
}

- (void)hideEmptyTips {
    _emptyTipsView.hidden = YES;
    [_emptyTipsView removeFromSuperview];
    _emptyTipsView = nil;
}

#pragma mark - Alert

- (void)showAlert:(NSString *)message {
    
    TTAlertView *alertView = [[TTAlertView alloc] initWithTitle:nil message:message containerView:nil delegate:self confirmButtonTitle:@"确定" otherButtonTitles:nil];
    [alertView show];
    
}

- (void)statusBarFrameDidChanged
{
    //    self.view.height = FULL_HEIGHT;
}

//- (void)requestNetworkFailed:(StatusEntity *)error
//{
//    if (error && !IsEmptyString(error.msg)) {
//        [self showNotice:error.msg];
//    }
//}

#pragma mark - Default View
//#warning 目前没有图片
//- (void)showDefaultView
//{
//    if(!self.defaultView){
//        self.defaultView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"twiitter_default"]];
//        self.defaultView.centerX = FULL_WIDTH/2.0f;
//        self.defaultView.centerY = FULL_HEIGHT/2.0f - 50;
//    }
//    if(!self.defaultView.superview){
//        [self.view insertSubview:self.defaultView atIndex:0];
//    }
//    [self.defaultView setHidden:NO];
//}
//
//- (void)hideDefaultView
//{
//    [self.defaultView setHidden:YES];
//}

@end
