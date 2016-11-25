//
//  BaseRefreshView.h
//  HongBao
//
//  Created by Ivan on 16/1/21.
//  Copyright © 2016年 ivan. All rights reserved.
//

#import "SVPullToRefresh.h"
#import "CommonMacro.h"

@interface BaseRefreshView : UIView

@property (nonatomic, assign) LoadingType loadingType;

@property (nonatomic, readwrite) SVPullToRefreshState pullToRefreshState;

@property (nonatomic, readwrite) SVInfiniteScrollingState infiniteScrollingState;

- (void)startAnimation;

- (void)loadingAnimation;

- (void)triggeredAnimation;

- (void)stoppedAnimation;

@end
