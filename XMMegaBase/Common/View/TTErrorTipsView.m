//
//  TTErrorTipsView.m
//  HongBao
//
//  Created by Ivan on 16/1/21.
//  Copyright © 2016年 ivan. All rights reserved.
//

#import "TTErrorTipsView.h"
#import "UIView+TT.h"
#import "UIButton+TT.h"
#import "UILabel+TT.h"
#import "ColorMarco.h"

@interface TTErrorTipsView()

@property (nonatomic, strong) UIButton *refreshButton;
@property (nonatomic, strong) UIActivityIndicatorView *activityIndicator;

@end

@implementation TTErrorTipsView
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setBackgroundColor:[UIColor whiteColor]];
        
        
        UILabel *lblErrow = [UILabel labelWithText:@"您的手机网络不太顺畅哦" color:Color_OrderGrayExpectButtonColor align:NSTextAlignmentCenter font:FONT(14.f) background:[UIColor clearColor] frame:CGRectMake(0, 0, 200, 16)];
        lblErrow.centerX = self.width/2.0;
        lblErrow.top = 150.f;
        [self addSubview:lblErrow];
        
        UILabel *lblMessage = [UILabel labelWithText:@"再刷新试试。" color:Color_OrderGrayExpectButtonColor align:NSTextAlignmentCenter font:FONT(14.f) background:[UIColor clearColor] frame:CGRectMake(0, 0, self.width, 16)];
        lblMessage.centerX = self.width/2.0;
        lblMessage.top = lblErrow.bottom + 7.f;
        [self addSubview:lblMessage];
                
        self.refreshButton = [UIButton custom37OrangeButtonWithTitle:@"点击刷新" target:self action:@selector(refresh) forControlEvents:UIControlEventTouchUpInside];
        [self.refreshButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.refreshButton.height = 32.f;
        self.refreshButton.width = 160.f;
        self.refreshButton.top = lblMessage.bottom + 12.f;
        self.refreshButton.centerX = self.width/2.0;
        [self addSubview:self.refreshButton];
    }
    
    return self;
}

- (void)beginRefresh
{
    [self refresh];
}

- (void)refresh
{
    if ([self.delegate respondsToSelector:@selector(errorTipsViewBeginRefresh:)]) {
        [self addActivityIndicator];
        [self performSelector:@selector(callDelegate) withObject:nil afterDelay:0.5];
    }
}

- (void)callDelegate
{
    [self.delegate errorTipsViewBeginRefresh:self];
}

- (void)addActivityIndicator
{
    [self.refreshButton setTitle:@" " forState:UIControlStateNormal];
    if (!self.activityIndicator) {
        self.activityIndicator = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
        self.activityIndicator.center = CGPointMake(self.refreshButton.width / 2, self.refreshButton.height / 2);
        self.activityIndicator.color = RGB(153, 153, 153);
    }
    if (!self.activityIndicator.superview) {
        [self.refreshButton addSubview:self.activityIndicator];
        [self.activityIndicator startAnimating];
    }
    self.refreshButton.enabled = NO;
}

- (void)removeActivityIndicator
{
    [self.activityIndicator stopAnimating];
    [self.activityIndicator removeFromSuperview];
    [self.refreshButton setTitle:@"重新加载" forState:UIControlStateNormal];
    self.refreshButton.enabled = YES;
}

- (void)didFinishLoading
{
    [self removeActivityIndicator];
}
@end
