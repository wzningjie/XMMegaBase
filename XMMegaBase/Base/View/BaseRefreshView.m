//
//  BaseRefreshView.m
//  HongBao
//
//  Created by Ivan on 16/1/21.
//  Copyright © 2016年 ivan. All rights reserved.
//

#import "BaseRefreshView.h"

@interface BaseRefreshView ()

@end

@implementation BaseRefreshView


- (void)startAnimation
{
    
    if ( kRefresh == self.loadingType) {
        switch (self.pullToRefreshState) {
            case SVPullToRefreshStateAll:
            case SVPullToRefreshStateTriggered:
                [self triggeredAnimation];
                break;
            case SVPullToRefreshStateLoading:
                [self loadingAnimation];
                break;
            case SVPullToRefreshStateStopped:
                [self stoppedAnimation];
                break;
        }
    }
    
    if ( kLoadMore == self.loadingType ) {
        switch (self.infiniteScrollingState) {
            case SVInfiniteScrollingStateAll:
            case SVInfiniteScrollingStateTriggered:
                [self triggeredAnimation];
                break;
            case SVInfiniteScrollingStateLoading:
                [self loadingAnimation];
                break;
            case SVInfiniteScrollingStateStopped:
                [self stoppedAnimation];
                break;
        }
    }

}

- (void)loadingAnimation
{
    
}


- (void)triggeredAnimation
{
    
}


- (void)stoppedAnimation
{
    
}


@end
