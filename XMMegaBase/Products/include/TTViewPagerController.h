//
//  TTViewPagerController.h
//  HongBao
//
//  Created by Ivan on 16/3/6.
//  Copyright © 2016年 ivan. All rights reserved.
//

#import "BaseViewController.h"

@class TTViewPagerController;
@protocol TTViewPagerDelegate <NSObject>

- (NSUInteger)numberOfTabsForViewPager:(TTViewPagerController *)viewPager;

- (UILabel *)viewPager:(TTViewPagerController *)viewPager tabForTabAtIndex:(NSUInteger)index;

//- (NSString *)viewPager:(TTViewPagerController *)viewPager titleForTabAtIndex:(NSUInteger)index;

@optional

- (UIViewController *)viewPager:(TTViewPagerController *)viewPager contentViewControllerForTabAtIndex:(NSUInteger)index;

- (UIView *)viewPager:(TTViewPagerController *)viewPager contentViewForTabAtIndex:(NSUInteger)index;

@end

@interface TTViewPagerController : BaseViewController

@property (nonatomic, weak) id<TTViewPagerDelegate> delegate;

@property (nonatomic, assign) BOOL noScroll;

@property (nonatomic, assign) BOOL noSelectBold;

@property (nonatomic, assign) BOOL hideNavigationBar;

@property (nonatomic, strong) UIColor *choosedColor;

- (void)reloadData;

- (void)reloadContents;

- (void)selectTabAtIndex:(NSUInteger)index;

@end
