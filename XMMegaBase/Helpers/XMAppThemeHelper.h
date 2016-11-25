//
//  XMThemeHelper.h
//  LianWei
//
//  Created by marco on 7/19/16.
//  Copyright © 2016 marco. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XMAppThemeHelper : NSObject

+ (instancetype)defaultTheme;

// default to white
@property (nonatomic, strong) UIColor *mainThemeColor;

// default to black
@property (nonatomic, strong) UIColor *mainThemeContrastColor;

// default to white
@property (nonatomic, strong) UIColor *navigationBarBackgroundColor;

// default to black
@property (nonatomic, strong) UIColor *navigationBarTintColor;

// default to black
@property (nonatomic, strong) UIColor *navigationBarBackColor;

// default to black
@property (nonatomic, strong) UIColor *navigationBarButtonColor;

// default to light gray
@property (nonatomic, strong) UIColor *navigationBarBottomColor;

// default to black
@property (nonatomic, strong) UIColor *navigationBarTitleColor;


// default to Color_Red6
@property (nonatomic, strong) UIColor *searchHeadBackgroundColor;

// default to Color_Red6
// 适用于个人页面顶部,搜索顶部等
@property (nonatomic, strong) UIColor *bannerBackgroundColor;

// default to Color_Red6
@property (nonatomic, strong) UIColor *tabbarBackgroundColor;
// default to Color_Gray216
@property (nonatomic, strong) UIColor *tabbarTopColor;


// 返回按钮icon，如果不指定，将使用模块内预置的返回图片
@property (nonatomic, strong) NSString *backButtonIconName;


// Button样式,适用于设置白字的button
@property (nonatomic, strong) UIColor *longButtonBackgroundColor;
@property (nonatomic, strong) UIColor *shortButtonBackgroundColor;

// check button图片，如果不指定，将使用模块内预置的选中为紫色的图片
@property (nonatomic, strong) NSString *checkButtonNormalIconName;
@property (nonatomic, strong) NSString *checkButtonSelectedIconName;
@property (nonatomic, strong) NSString *checkButtonDisableIconName;


@end