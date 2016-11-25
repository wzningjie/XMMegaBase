//
//  TTActivityIndicatorView.m
//  HongBao
//
//  Created by Ivan on 16/1/21.
//  Copyright © 2016年 ivan. All rights reserved.
//

#import "TTActivityIndicatorView.h"
#import "UIView+TT.h"
#import "UIImage+TT.h"

@interface TTActivityIndicatorView () {
    UIImageView *_circleView;
}
@end

@implementation TTActivityIndicatorView

+ (TTActivityIndicatorView *)showInView:(UIView *)view animated:(BOOL)animated {
    
    TTActivityIndicatorView *acitivityIndView = nil;
    
    for (UIView *subview in view.subviews) {
        if ([subview isKindOfClass:[self class]]) {
            acitivityIndView = (TTActivityIndicatorView *)subview;
            break;
        }
    }
    
    if (!acitivityIndView) {
        acitivityIndView = [[TTActivityIndicatorView alloc] initWithView:view];
        acitivityIndView.alpha = 0.0f;
        [view addSubview:acitivityIndView];
        [view bringSubviewToFront:acitivityIndView];
        [acitivityIndView show:animated];
    }
    
    return acitivityIndView;
}

+ (BOOL)hideActivityIndicatorForView:(UIView *)view animated:(BOOL)animated {
    
    TTActivityIndicatorView *activityIndicator = [TTActivityIndicatorView XSJActivityIndicatorForView:view];
    if (activityIndicator != nil) {
        if (animated) {
            [view bringSubviewToFront:activityIndicator];
        }
        [activityIndicator hide:animated];
        return YES;
    }
    return NO;
}

+ (TTActivityIndicatorView *)XSJActivityIndicatorForView:(UIView *)view
{
    TTActivityIndicatorView *activityIndicator = nil;
    NSArray *subviews = view.subviews;
    Class aiClass = [TTActivityIndicatorView class];
    NSInteger count = 1;
    for (UIView *aView in subviews) {
        if ([aView isKindOfClass:aiClass]) {
            if (count > 1) {
                [aView removeFromSuperview];
            }
            else{
                activityIndicator = (TTActivityIndicatorView *)aView;
            }
            count ++;
        }
    }
    
    return activityIndicator;
}

- (id)initWithView:(UIView *)view {
    NSAssert(view, @"View must not be nil.");
    id me = [self initWithFrame:view.bounds];
    return me;
}


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        _circleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"loading_circle" module:ModuleName]];
//        [_circleView setImage:[UIImage imageNamed:@"loading_circle"]];
        _circleView.center = CGPointMake(self.width/2.0f, self.height/2.0f);
        [self addSubview:_circleView];
        self.userInteractionEnabled = YES;
    }
  
    
    return self;
}

#pragma mark - show & hide method
- (void)show:(BOOL)animated {
    
    if (animated) {
        [self addAnimation];
    }
    
    [UIView animateWithDuration:0.2f
                     animations:^{
                         self.alpha = 1.0f;
                     } completion:^(BOOL finished) {
                         
                     }];
}

- (void)addAnimation
{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform"];
    animation.delegate = self;
    animation.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeRotation(M_PI/2 , 0, 0, 1.0)];
    animation.duration = 0.4f;
    animation.cumulative = YES;
    animation.repeatCount = INT_MAX;
    [_circleView.layer addAnimation:animation forKey:@"rotate"];
}

- (void)hide:(BOOL)animated {
    
    if (animated) {
        
        [UIView animateWithDuration:0.2f
                         animations:^{
                             self.alpha = 0.0f;
                         } completion:^(BOOL finished) {
                             [_circleView.layer removeAllAnimations];
                             [self removeFromSuperview];
                             [[NSNotificationCenter defaultCenter] removeObserver:self];
                         }];
    }else {
        [_circleView.layer removeAllAnimations];
        [self removeFromSuperview];
    }
}

@end
