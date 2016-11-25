//
//  XMThemeHelper.m
//  LianWei
//
//  Created by marco on 7/19/16.
//  Copyright © 2016 marco. All rights reserved.
//

#import "XMAppThemeHelper.h"
#import "ColorMarco.h"

@implementation XMAppThemeHelper


+ (instancetype)defaultTheme
{
    static dispatch_once_t onceToken;
    static XMAppThemeHelper *instance = nil;
    dispatch_once(&onceToken, ^{
        instance = [[XMAppThemeHelper alloc] init];
    });
    return instance;
}

- (instancetype)init {
    
    self = [super init];
    
    if ( self ) {
        _mainThemeColor = [UIColor whiteColor];
        _mainThemeContrastColor = [UIColor blackColor];
        
        _navigationBarBackgroundColor = [UIColor whiteColor];
        _navigationBarTintColor = [UIColor blackColor];
        _navigationBarBackColor = [UIColor blackColor];
        _navigationBarButtonColor = [UIColor blackColor];
        _navigationBarBottomColor = [UIColor lightGrayColor];
        _navigationBarTitleColor = [UIColor blackColor];
        
        _shortButtonBackgroundColor = Color_Red6;
        _longButtonBackgroundColor = Color_Red6;
        
        _searchHeadBackgroundColor = Color_Red6;
        _bannerBackgroundColor = Color_Red6;
        _tabbarTopColor = Color_Gray216;
        _tabbarBackgroundColor = Color_Gray245;
    }
    
    return self;
}

@end
