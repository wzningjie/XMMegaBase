//
//  TTAlertView.h
//  HongBao
//
//  Created by Ivan on 16/1/21.
//  Copyright © 2016年 ivan. All rights reserved.
//
#import <UIKit/UIKit.h>

@protocol TTAlertViewDelegate;

@interface TTAlertView : UIView

@property (nonatomic, strong) UIWindow  *window;
@property (nonatomic, strong) UIView    *overlayView;
@property (nonatomic, strong) UILabel   *titleLabel;
@property (nonatomic, strong) UILabel   *messageLabel;
@property (nonatomic, strong) UIView    *containerView;
@property (nonatomic, weak) id<TTAlertViewDelegate> delegate;


- (id)initWithTitle:(NSString *)title message:(NSString *)message containerView:(UIView *)containerView delegate:(id <TTAlertViewDelegate>)delegate confirmButtonTitle:(NSString *)confirmButtonTitle otherButtonTitles:(NSArray *)otherButtonTitles;

- (void)show;

@end


@protocol TTAlertViewDelegate<NSObject>

@optional

// Called when a button is clicked. The view will be automatically dismissed after this call returns
- (void)alertView:(TTAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex;

- (void)alertView:(TTAlertView *)alertView willDismissWithButtonIndex:(NSInteger)buttonIndex; // before animation and hiding view
- (void)alertView:(TTAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex;  // after animation


@end