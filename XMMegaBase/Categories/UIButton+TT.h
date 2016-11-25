//
//  UIButton+TT.h
//  HongBao
//
//  Created by Ivan on 16/1/21.
//  Copyright © 2016年 ivan. All rights reserved.
//

/**
 *  UIButton 扩展
 */
#import <UIKit/UIKit.h>

@interface UIButton (TT)

/**
 *  返回按钮
 *
 *  @param target        target
 *  @param action        action
 *  @param controlEvents UIControlEvents
 *
 *  @return button
 */
+ (UIButton *)backButtonWithTarget:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents;

/**
 *  生成导航栏左侧按钮
 *
 *  @param image            image
 *  @param highlightedImage highlightedImage
 *  @param target           target
 *  @param action           action
 *  @param controlEvents    UIControlEvents
 *
 *  @return button
 */
+ (UIButton *)leftBarButtonWithImage:(UIImage*)image highlightedImage:(UIImage*)highlightedImage target:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents;

/**
 *  生成导航栏右侧按钮
 *
 *  @param image            image
 *  @param highlightedImage highlightedImage
 *  @param target           target
 *  @param action           action
 *  @param controlEvents    UIControlEvents
 *
 *  @return button
 */
+ (UIButton *)rightBarButtonWithImage:(UIImage*)image highlightedImage:(UIImage*)highlightedImage target:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents;

/**
 *  生成按钮，大小为图片大小，如果大小不足 44 * 44 ，则补全到 44 * 44
 *
 *  @param image            image
 *  @param highlightedImage highlightedImage
 *  @param target           target
 *  @param action           action
 *  @param controlEvents    controlEvents
 *
 *  @return button
 */
+ (UIButton *)buttonWithImage:(UIImage*)image highlightedImage:(UIImage*)highlightedImage target:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents;

/**
 *  生成按钮 先根据 backgroundImage 确定大小，没有的时候根据 image 确定大小。如果大小不足 44 * 44 ，则补全到 44 * 44
 *
 *  @param title                      标题
 *  @param image                      image
 *  @param highlightedImage           highlightedImage
 *  @param backgroundImage            backgroundImage
 *  @param highlightedBackgroundImage highlightedBackgroundImage
 *  @param target                     target
 *  @param action                     action
 *  @param controlEvents              controlEvents
 *
 *  @return button
 */
+ (UIButton *)buttonWithTitle:(NSString *)title image:(UIImage*)image highlightedImage:(UIImage*)highlightedImage backgroundImage:(UIImage *)backgroundImage highlightedBackgroundImage:(UIImage *)highlightedBackgroundImage target:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents;

+ (UIButton *)buttonWithTitle:(NSString *)title frame:(CGRect)frame target:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents;

+ (UIButton *)buttonWithTitle:(NSString *)title backgroundImage:(UIImage *)backgroundImage highlightedBackgroundImage:(UIImage *)highlightedBackgroundImage target:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents;

+ (UIButton *)navigationButtonWithTitle:(NSString *)title target:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents;

+ (UIButton *)custom37OrangeButtonWithTitle:(NSString *)title target:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents;

+ (UIButton *)custom37redButtonWithTitle:(NSString *)title target:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents;

+ (UIButton *)custom37grayButtonWithTitle:(NSString *)title target:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents;

+ (UIButton *)custom37WhiteButtonWithTitle:(NSString *)title target:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents;

+ (UIButton *)buttonWithImage:(NSString *)image imageEdgeInsets:(UIEdgeInsets)imageEdgeInsets title:(NSString *)title titleEdgeInsets:(UIEdgeInsets)titleEdgeInsets font:(UIFont *)font target:(id)target action:(SEL)action frame:(CGRect)frame;

@end
