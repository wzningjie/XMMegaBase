//
//  TTAppLaunchView.h
//  HongBao
//
//  Created by Ivan on 16/1/21.
//  Copyright © 2016年 ivan. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "TTSliderView.h"

/*
 LaunchImage which supports guide and ads. Because launch image is used only onece during
 app lifttime, it's better to place it in Resource folder. Guides or Ads are the same case,
 while it is up to you.
 */

typedef NS_ENUM(NSUInteger, TTAppLaunchType) {
    TTAppLaunchTypeNone,
    TTAppLaunchTypeGuide,
    TTAppLaunchTypeAds,
};

@class TTAppLaunchView;

@protocol TTAppLaunchViewDataSource <NSObject>

@required
- (NSInteger)numberOfSliderPages;
- (UIView *)viewForPageAtIndex:(NSInteger)index reusingView:(UIView *)view;

@end

@protocol TTAppLaunchViewDelegate <NSObject>

@optional
- (void)launchView:(TTAppLaunchView*)view didSelectViewAtIndex:(NSInteger)index;
- (void)launchView:(TTAppLaunchView*)view didSliderToIndex:(NSInteger)index;
@end

@interface TTAppLaunchView : UIView
@property (nonatomic, strong, readonly) TTSliderView *sliderView;
@property (nonatomic, strong, readonly) UIImageView *launchImageView;
@property (nonatomic, assign)TTAppLaunchType launchType;
@property (nonatomic, weak)id<TTAppLaunchViewDataSource> dataSource;
@property (nonatomic, weak)id<TTAppLaunchViewDelegate> delegate;

+ (TTAppLaunchView *)sharedInstance;

// You only call showLaunchView when you want to show Ads, simple launch image
// or guide are added or removed via kNOTIFY_APP_LAUNCH_LOADING or
// kNOTIFY_APP_LAUNCH_REMOVE notification.
- (void)showLaunchView;

// you call removeLaunchView to remove ads or guides
- (void)removeLaunchView;

// To reload guides or ads
- (void)reloadPages;

@end
