//
//  BaseViewController.h
//  HongBao
//
//  Created by Ivan on 16/1/21.
//  Copyright © 2016年 ivan. All rights reserved.
//

#import "TTTabbarItem.h"
#import "TTNavigationBar.h"
#import "MBProgressHUD.h"
#import "TTEmptyTipsView.h"
#import "TTErrorTipsView.h"
#import "TTAlertView.h"
#import "CommonMacro.h"

@class TTTabbarController;
@class TTTabbarItem;

@interface BaseViewController : UIViewController <TTErrorTipsViewDelegate, TTAlertViewDelegate>

@property (nonatomic, strong) TTNavigationBar *navigationBar;
@property (nonatomic, assign) BOOL needBlurEffect;
@property (nonatomic, strong) MBProgressHUD *noticeView;
@property (nonatomic, assign) LoadingType loadingType;


/**
 *  如果在 TTTabBarController 中使用的 TabBarItem
 */
@property (nonatomic, strong) TTTabbarItem *tabbarItem;
/**
 *  当前 viewcontroller 所在的 TTTabBarController 的引用。如果为 nil，表示不在 TTTabBarController 中。
 */
@property (nonatomic, weak) TTTabbarController *tabBarController;
/**
 *  当前 ViewController 的 view 的 frame
 */
@property (nonatomic, assign) CGRect defaultFrame;

/**
 *  网络出错时显示的页面
 */
@property (nonatomic, strong) TTErrorTipsView *errorTipsView;

/**
 *  页面空时显示的页
 */
@property (nonatomic, strong) TTEmptyTipsView *emptyTipsView;

@property (nonatomic, strong) NSDictionary *extraParams;

- (void)clickback;

- (void)addNavigationBar;

// Empty Tips
- (void)showEmptyTips:(NSString *)tips;
- (void)showEmptyTips:(NSString *)tips ownerView:(UIView *)ownerView;
- (void)showEmptyTips:(NSString *)tips ownerView:(UIView *)ownerView offsetTop:(CGFloat) top;
- (void)hideEmptyTips;

//网络不好的提示
- (void)showErrorTipsOnOwnerView:(UIView *)ownerView;
- (void)showErrorTips;
- (void)hideErrorTips;

// Notice
- (void)showNotice:(NSString *)notice;
- (void)showNotice:(NSString *)notice image:(UIImage *)image;
- (void)showNoticeOnWindow:(NSString *)notice;
- (void)showNoticeOnWindow:(NSString *)notice duration:(NSTimeInterval)duration;

// Alert
- (void)showAlert:(NSString *)message;

@end
