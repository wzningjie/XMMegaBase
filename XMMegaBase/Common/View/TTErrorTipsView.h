//
//  TTErrorTipsView.h
//  HongBao
//
//  Created by Ivan on 16/1/21.
//  Copyright © 2016年 ivan. All rights reserved.
//
#import <UIKit/UIKit.h>

@protocol TTErrorTipsViewDelegate;

@interface TTErrorTipsView : UIView

@property (nonatomic, weak) id<TTErrorTipsViewDelegate> delegate;

- (void)didFinishLoading;

- (void)beginRefresh;

@end

@protocol TTErrorTipsViewDelegate <NSObject>

@optional

- (void)errorTipsViewBeginRefresh:(TTErrorTipsView *)tipsView;

@end