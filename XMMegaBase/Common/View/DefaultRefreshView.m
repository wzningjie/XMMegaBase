//
//  DefaultRefreshView.m
//  HongBao
//
//  Created by Ivan on 16/1/23.
//  Copyright © 2016年 ivan. All rights reserved.
//

#import "DefaultRefreshView.h"
#import "UIView+TT.h"
#import "UIImage+TT.h"
#import "Macros.h"

@interface DefaultRefreshView ()

@property (nonatomic, strong) UILabel *stateLabel;

@property (nonatomic, strong) UIImageView *circleView;

@end


@implementation DefaultRefreshView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.stateLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
        _stateLabel.font = FONT(12);
        _stateLabel.textColor = Color_Gray153;
        self.stateLabel.text = @"上拉加载更多";
        [self.stateLabel sizeToFit];
        self.stateLabel.centerX = self.width/2;
        self.stateLabel.centerY = self.height/2.0f;
        [self addSubview:_stateLabel];
        
        self.circleView = [[UIImageView alloc] init];
        self.circleView.width = 20.f;
        self.circleView.height = 20.f;
        
        [self.circleView setImage:[UIImage imageNamed:@"loading_circle" module:ModuleName]];
        
        self.circleView.center = CGPointMake(self.width/2.0f - 50, self.height/2.0f);
        
        [self addSubview:self.circleView];
    }
    return self;
}

- (void)labelTextChanged
{
    NSString *text = @"";
    
    if ( kRefresh == self.loadingType) {
        switch (self.pullToRefreshState) {
            case SVPullToRefreshStateAll:
            case SVPullToRefreshStateTriggered:
                text = @"下拉可更新";
                break;
            case SVPullToRefreshStateLoading:
                text = @"加载中...";
                break;
            case SVPullToRefreshStateStopped:
                text = @"松开以更新";
                break;
        }
    }
    
    if ( kLoadMore == self.loadingType ) {
        switch (self.infiniteScrollingState) {
            case SVInfiniteScrollingStateAll:
            case SVInfiniteScrollingStateTriggered:
                text = @"下拉可更新";
                break;
            case SVInfiniteScrollingStateLoading:
                text = @"下拉可更新";
                break;
            case SVInfiniteScrollingStateStopped:
                text = @"下拉可更新";
                break;
        }
    }
    
    _stateLabel.text = text;
    [_stateLabel sizeToFit];
    _stateLabel.width = self.width;
    _stateLabel.top = ( NAVBAR_HEIGHT - _stateLabel.height ) / 2;
    _stateLabel.centerX = SCREEN_WIDTH/2;
    _stateLabel.textAlignment = NSTextAlignmentCenter;
    
//    _stateLabel.text = text;
//    _stateLabel.font = FONT(12);
//    _stateLabel.textColor = Color_Gray153;
//    [_stateLabel sizeToFit];
//    _stateLabel.width = self.width;
//    _stateLabel.top = ( NAVBAR_HEIGHT - _stateLabel.height ) / 2;
//    _stateLabel.textAlignment = NSTextAlignmentCenter;

}

- (void)loadingAnimation
{
    [self labelTextChanged];
    
    self.circleView.hidden = NO;
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform"];
    animation.delegate = self;
    animation.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeRotation(M_PI/2 , 0, 0, 1.0)];
    animation.duration = 0.4f;
    animation.cumulative = YES;
    animation.repeatCount = INT_MAX;
    [self.circleView.layer addAnimation:animation forKey:@"rotate"];
    
}


- (void)triggeredAnimation
{
    [self labelTextChanged];
    self.circleView.hidden = YES;
}


- (void)stoppedAnimation
{
    [self labelTextChanged];
    self.circleView.hidden = YES;
    [self.circleView.layer removeAllAnimations];
}

@end
