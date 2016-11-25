//
//  UIButton+TT.m
//  HongBao
//
//  Created by Ivan on 16/1/21.
//  Copyright © 2016年 ivan. All rights reserved.
//

#import "UIButton+TT.h"
#import "ColorMarco.h"
#import "UIImage+TT.h"
#import "XMAppThemeHelper.h"

@implementation UIButton (TT)

+ (UIButton *)backButtonWithTarget:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents {
    UIImage *backImage = [UIImage imageNamed:@"btn_back" module:ModuleName];
    if ([XMAppThemeHelper defaultTheme].backButtonIconName) {
        backImage = [UIImage imageNamed:[XMAppThemeHelper defaultTheme].backButtonIconName];
    }
	return [self leftBarButtonWithImage:[backImage imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] highlightedImage:[backImage imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] target:target action:action forControlEvents:UIControlEventTouchUpInside];
}

+ (UIButton *)leftBarButtonWithImage:(UIImage*)image highlightedImage:(UIImage*)highlightedImage target:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents {
    UIButton *barButton = [UIButton buttonWithType:UIButtonTypeCustom];
    barButton.frame = CGRectMake(0.0f, 0.0f, 44, 44);
    barButton.imageEdgeInsets = UIEdgeInsetsMake(0, -3, 0, 0);
	[barButton setImage:image forState:UIControlStateNormal];
    [barButton setImage:highlightedImage forState:UIControlStateHighlighted];
	[barButton addTarget:target action:action forControlEvents:controlEvents];
    [barButton setExclusiveTouch:YES];
	return barButton;
}

+ (UIButton *)rightBarButtonWithImage:(UIImage*)image highlightedImage:(UIImage*)highlightedImage target:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents {
    UIButton *barButton = [UIButton buttonWithType:UIButtonTypeCustom];
    barButton.frame = CGRectMake(0.0f, 0.0f, 44, 44);
    barButton.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 4);
	[barButton setImage:image forState:UIControlStateNormal];
    [barButton setImage:highlightedImage forState:UIControlStateHighlighted];
	[barButton addTarget:target action:action forControlEvents:controlEvents];
    [barButton setExclusiveTouch:YES];
	return barButton;
}

+ (UIButton *)buttonWithImage:(UIImage*)image highlightedImage:(UIImage*)highlightedImage target:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents {
    
    return [self buttonWithTitle:nil image:image highlightedImage:highlightedImage backgroundImage:nil highlightedBackgroundImage:nil target:target action:action forControlEvents:controlEvents];
    
}

+ (UIButton *)buttonWithTitle:(NSString *)title image:(UIImage *)image highlightedImage:(UIImage *)highlightedImage backgroundImage:(UIImage *)backgroundImage highlightedBackgroundImage:(UIImage *)highlightedBackgroundImage target:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    CGSize size = CGSizeZero;
    if (backgroundImage) {
        size = backgroundImage.size;
    }
    else if (image) {
        size = image.size;
    }
    button.frame = CGRectMake(0.0f, 0.0f, size.width < 44.0f ? 44.0f : size.width, size.height);
    
    [button setTitle:title forState:UIControlStateNormal];
    
    [button setImage:image forState:UIControlStateNormal];
    [button setImage:highlightedImage forState:UIControlStateHighlighted];
    
    [button setBackgroundImage:backgroundImage forState:UIControlStateNormal];
    
    [button setBackgroundImage:highlightedBackgroundImage forState:UIControlStateHighlighted];
    
	[button addTarget:target action:action forControlEvents:controlEvents];
    
    [button setExclusiveTouch:YES];
    
    return button;
}

+(UIButton*)buttonWithTitle:(NSString *)title frame:(CGRect)frame target:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    UIFont   *titleFont   = FONT(15.f);
    button.frame  = frame;
    button.titleLabel.font = titleFont;
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:Color_Red forState:UIControlStateNormal];
    [button addTarget:target action:action forControlEvents:controlEvents];
    
    return button;
}

+ (UIButton *)buttonWithTitle:(NSString *)title backgroundImage:(UIImage *)backgroundImage highlightedBackgroundImage:(UIImage *)highlightedBackgroundImage target:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents {
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    UIFont   *titleFont   = FONT(14.f);
    button.frame  = CGRectMake(0.0f, 0.0f, backgroundImage.size.width, backgroundImage.size.height);
    button.titleLabel.font = titleFont;
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button setBackgroundImage:backgroundImage forState:UIControlStateNormal];
    [button setBackgroundImage:highlightedBackgroundImage forState:UIControlStateHighlighted];
    [button addTarget:target action:action forControlEvents:controlEvents];
    
    return button;
}

+ (UIButton *)navigationButtonWithTitle:(NSString *)title target:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents
{
    UIButton *button = [UIButton buttonWithTitle:title backgroundImage:nil highlightedBackgroundImage:nil target:target action:action forControlEvents:controlEvents];
    
    button.titleLabel.font = FONT(15);
    
    [button setTitleColor:RGB(243, 73, 67) forState:UIControlStateNormal];
    return button;
}

+ (UIButton *)custom37OrangeButtonWithTitle:(NSString *)title target:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents
{
    UIImage *backgroundImage = [[UIImage imageNamed:@"btn_orange_bg_37"] resizableImageWithCapInsets:UIEdgeInsetsMake(10.f, 20.f, 10.f, 20.f)];
    UIImage *hightlightBackgroundImage = [[UIImage imageNamed:@"btn_orange_bg_37"] resizableImageWithCapInsets:UIEdgeInsetsMake(10.f, 20.f, 10.f, 20.f)];
    
    UIButton *btn = [UIButton buttonWithTitle:title backgroundImage:backgroundImage highlightedBackgroundImage:hightlightBackgroundImage target:target action:action forControlEvents:UIControlEventTouchUpInside];
    btn.titleLabel.font = FONT(16);
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn setTitleColor:RGBA(255, 255, 255, 0.5f) forState:UIControlStateHighlighted];
    return btn;
}

+ (UIButton *)custom37redButtonWithTitle:(NSString *)title target:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents
{
    UIImage *backgroundImage = [[UIImage imageNamed:@"btn_red_bg_37"] resizableImageWithCapInsets:UIEdgeInsetsMake(10.f, 20.f, 10.f, 20.f)];
    UIImage *hightlightBackgroundImage = [[UIImage imageNamed:@"btn_red_bg_37"] resizableImageWithCapInsets:UIEdgeInsetsMake(10.f, 20.f, 10.f, 20.f)];
    
    UIButton *btn = [UIButton buttonWithTitle:title backgroundImage:backgroundImage highlightedBackgroundImage:hightlightBackgroundImage target:target action:action forControlEvents:UIControlEventTouchUpInside];
    btn.titleLabel.font = FONT(16);
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn setTitleColor:RGBA(255, 255, 255, 0.5f) forState:UIControlStateHighlighted];
    return btn;
}

+ (UIButton *)custom37grayButtonWithTitle:(NSString *)title target:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents
{
    UIImage *backgroundImage = [[UIImage imageNamed:@"btn_gray_bg_37"] resizableImageWithCapInsets:UIEdgeInsetsMake(10.f, 20.f, 10.f, 20.f)];
    UIImage *hightlightBackgroundImage = [[UIImage imageNamed:@"btn_gray_bg_37"] resizableImageWithCapInsets:UIEdgeInsetsMake(10.f, 20.f, 10.f, 20.f)];
    
    UIButton *btn = [UIButton buttonWithTitle:title backgroundImage:backgroundImage highlightedBackgroundImage:hightlightBackgroundImage target:target action:action forControlEvents:UIControlEventTouchUpInside];
    btn.titleLabel.font = FONT(16);
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn setTitleColor:RGBA(255, 255, 255, 0.5f) forState:UIControlStateHighlighted];
    return btn;
}

+ (UIButton *)custom37WhiteButtonWithTitle:(NSString *)title target:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents
{
    UIImage *backgroundImage = [[UIImage imageNamed:@"btn_white_bg_37"] resizableImageWithCapInsets:UIEdgeInsetsMake(10.f, 20.f, 10.f, 20.f)];
    UIImage *hightlightBackgroundImage = [[UIImage imageNamed:@"btn_white_bg_37"] resizableImageWithCapInsets:UIEdgeInsetsMake(10.f, 20.f, 10.f, 20.f)];
    
    UIButton *btn = [UIButton buttonWithTitle:title backgroundImage:backgroundImage highlightedBackgroundImage:hightlightBackgroundImage target:target action:action forControlEvents:UIControlEventTouchUpInside];
    btn.titleLabel.font = FONT(16);
    [btn setTitleColor:Color_Gray26 forState:UIControlStateNormal];
    [btn setTitleColor:RGBA(26, 26, 26, 0.5f) forState:UIControlStateHighlighted];
    return btn;
}

+ (UIButton *)buttonWithImage:(NSString *)image imageEdgeInsets:(UIEdgeInsets)imageEdgeInsets title:(NSString *)title titleEdgeInsets:(UIEdgeInsets)titleEdgeInsets font:(UIFont *)font target:(id)target action:(SEL)action frame:(CGRect)frame {
    
    UIButton *button = [[UIButton alloc] initWithFrame:frame];
    button.backgroundColor = [UIColor clearColor];
    
    [button setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:image] forState:UIControlStateHighlighted];
    button.imageEdgeInsets = imageEdgeInsets;
    
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    button.titleLabel.font = font;
    button.titleEdgeInsets = titleEdgeInsets;
    
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    [button setExclusiveTouch:YES];
    return button;
    
}
@end
