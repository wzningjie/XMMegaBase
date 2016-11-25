//
//  RootScrollViewController.h
//  HongBao
//
//  Created by Ivan on 16/1/21.
//  Copyright © 2016年 ivan. All rights reserved.
//


#import "BaseViewController.h"

@interface RootScrollViewController : BaseViewController <UIScrollViewDelegate>

@property (nonatomic, assign) BOOL      isBackToTop;
@property (nonatomic, strong) UIButton  *backToTopButton;
@property (nonatomic, assign) CGFloat   lastPosition;
@property (nonatomic, strong) NSString  *wp;

/**
 *  是否不加载导航条
 */
@property(nonatomic, assign) BOOL hideNavigationBar;

- (void)doRefresh;

- (void)doReload;

- (void)doLoadMore;

- (void)startRefresh;

- (void)finishRefresh;

- (void)finishLoadMore;

- (void)loadData;

@end
