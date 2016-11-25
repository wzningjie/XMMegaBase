//
//  TTNavigationBar.h
//  HongBao
//
//  Created by Ivan on 16/1/21.
//  Copyright © 2016年 ivan. All rights reserved.
//
#import <UIKit/UIKit.h>

@interface TTNavigationBar : UIView

/**
 *  标题文字
 */
@property(nonatomic, strong) NSString *title;

/**
 *  titleview
 */
@property(nonatomic, strong) UIView *titleView;

/**
 *  标题的 label
 */
@property(nonatomic, readonly) UILabel *titleLabel;

/**
 *  左侧按钮
 */
@property(nonatomic, strong) UIView *leftBarButton;
@property(nonatomic, strong) UIView *backBarButton;

/**
 *  右侧按钮
 */
@property(nonatomic, strong) UIView *rightBarButton;

/**
 *  放置内容的 view，不包含状态栏
 */
@property(nonatomic, strong) UIView *containerView;

/**
 *  用于毛玻璃效果
 */
@property(nonatomic, strong) UIVisualEffectView *effectView;

/**
 *  设置标题颜色
 *
 *  @param color 标题颜色
 */
- (void)setTitleColor:(UIColor *)color;

/**
 *  创建 navigation bar
 *
 *  @param frame          frame
 *  @param needBlurEffect 是否需要模糊效果 (iOS 8 以上支持)
 *
 *  @return
 */
- (id)initWithFrame:(CGRect)frame needBlurEffect:(BOOL)needBlurEffect;


/**
 *  设置navigation bar的border
 *
 *  @param color navigation bar的border的色值
 */
- (void)setBottomBorderColor:(UIColor*)color;


@end
