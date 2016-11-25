//
//  TTAppLaunchView.h
//  HongBao
//
//  Created by Ivan on 16/1/21.
//  Copyright © 2016年 ivan. All rights reserved.
//

#import "TTAppLaunchView.h"
#import "UIView+TT.h"
#import "KeyMarco.h"
#import "SystemMacro.h"
#import "ColorMarco.h"
#import "AppInfoManager.h"

@interface TTAppLaunchView ()<TTSliderViewDataSource, TTSliderViewDelegate>
@property (nonatomic, strong) TTSliderView *sliderView;
@property (nonatomic, strong) UIImageView *launchImageView;
@property (nonatomic, assign) BOOL startImageRemove;
@end

@implementation TTAppLaunchView

+ (TTAppLaunchView *)sharedInstance
{
    static dispatch_once_t onceToken;
    static TTAppLaunchView *launchView = nil;
    dispatch_once(&onceToken, ^{
        launchView = [[TTAppLaunchView alloc] init];
    });
    
    return launchView;
}

- (instancetype)init
{
    self = [super init];
    
    self.bounds = [[UIScreen mainScreen] bounds];
    self.left = 0.f;
    self.top = 0.f;
    
    if (self) {
        self.backgroundColor = Color_White;
        [self loadContent];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showLaunchView) name:kNOTIFY_APP_LAUNCH_LOADING object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(removeLaunchImage) name:kNOTIFY_APP_LAUNCH_REMOVE object:nil];
        
    }
    
    return self;
}

- (TTSliderView *)sliderView {
    
    if (!_sliderView) {
        _sliderView = [[TTSliderView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:SliderViewPageControlStyleDot alignment:SliderViewPageControlAlignmentCenter];
        _sliderView.delegate = self;
        _sliderView.dataSource = self;
        _sliderView.autoScroll = NO;
        _sliderView.wrapEnabled = NO;
        _sliderView.currentPageColor = Color_Red12;
        _sliderView.pageControl.pageIndicatorTintColor = Color_Blue;
        _sliderView.userInteractionEnabled = YES;
    }
    
    return _sliderView;
}

- (UIImageView*)launchImageView
{
    if (!_launchImageView) {
        NSString *fileName;
        if (IS_IPHONE4) {
            fileName = @"app_loading_fg4";
        } else if (IS_IPHONE5) {
            fileName = @"app_loading_fg5";
        } else if (IS_IPHONE6) {
            fileName = @"app_loading_fg6";
        } else if (IS_IPHONE6Plus) {
            fileName = @"app_loading_fg6p";
        }
        NSString *filePath = [[NSBundle mainBundle] pathForResource:fileName ofType:@"png"];
        UIImage *image = [UIImage imageWithContentsOfFile:filePath];
        if (!image) {
            image = [UIImage imageNamed:fileName];
        }
        
        _launchImageView = [[UIImageView alloc] initWithImage:image];
        _launchImageView.frame = CGRectMake(0.f, 0.f, self.width, self.height);
        _launchImageView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _launchImageView;
}

#pragma mark - load methods
- (void)loadContent
{
    if (!_launchImageView) {
        self.startImageRemove = NO;
        [self addSubview:self.sliderView];
        [self addSubview:self.launchImageView];
    }
}

- (void)reloadPages
{
    [self.sliderView reloadData];
}

#pragma mark - TTSliderViewDataSource

- (NSInteger)numberOfItemsInSliderView:(TTSliderView *)sliderView {
    
    if ([self.dataSource respondsToSelector:@selector(numberOfSliderPages)]) {
        return [self.dataSource numberOfSliderPages];
    } else {
        return 0;
    }
}

- (UIView *)sliderView:(TTSliderView *)sliderView viewForItemAtIndex:(NSInteger)index reusingView:(UIView *)view
{
    
    if ([self.dataSource respondsToSelector:@selector(viewForPageAtIndex:reusingView:)]) {
        return [self.dataSource viewForPageAtIndex:index reusingView:view];
    }
    
    return nil;
}

#pragma mark - TTSliderViewDelegate

- (void)sliderView:(TTSliderView *)sliderView didSelectViewAtIndex:(NSInteger)index
{
    if ([self.delegate respondsToSelector:@selector(launchView:didSelectViewAtIndex:)]) {
        [self.delegate launchView:self didSelectViewAtIndex:index];
    }
}

- (void)sliderView:(TTSliderView *)sliderView didSliderToIndex:(NSInteger)index
{
    if ([self.delegate respondsToSelector:@selector(launchView:didSliderToIndex:)]) {
        [self.delegate launchView:self didSliderToIndex:index];
    }
}


#pragma mark - notification methods
- (void)showLaunchView
{
    self.alpha = 1.f;
    if (!_sliderView.superview) {
        [self addSubview:self.sliderView];
    }
    if (!self.startImageRemove) {
        [self addSubview:self.launchImageView];
    }
    UIWindow *window = [[[UIApplication sharedApplication] windows] lastObject];
    [window addSubview:self];
}

- (void)removeLaunchView
{
    
    self.startImageRemove = YES;
    
    if (self.superview) {
        [UIView animateWithDuration:0.4
                         animations:^{
                             self.alpha = 0.f;
                         } completion:^(BOOL finished) {
                             [_sliderView removeFromSuperview];
                             _sliderView = nil;
                             [_launchImageView removeFromSuperview];
                             _launchImageView = nil;
                             [self removeFromSuperview];
                             
                         }];
    }
}

- (void)removeLaunchImage
{
    if (self.launchType == TTAppLaunchTypeNone) {
        if (!self.startImageRemove) {
            
            [NSThread sleepForTimeInterval:0.8f];
            
            [self removeLaunchView];
        }
    }else if (self.launchType == TTAppLaunchTypeGuide){
        
        AppBundleState state = [AppInfoManager appBundleState];
        if (state == AppBundleNewInstalled||state == AppBundleUpdated) {
            self.startImageRemove = YES;
            
            [NSThread sleepForTimeInterval:0.8f];
            if (self.launchImageView.superview) {
                [UIView animateWithDuration:0.4
                                 animations:^{
                                     self.launchImageView.alpha = 0.f;
                                 } completion:^(BOOL finished) {
                                     [self.launchImageView removeFromSuperview];
                                     _launchImageView = nil;
                                 }];
            }
            
        }else{
            if (!self.startImageRemove) {
                
                [NSThread sleepForTimeInterval:0.8f];
                
                [self removeLaunchView];
            }
            
        }
        
    }else if (self.launchType == TTAppLaunchTypeAds){
        
        self.startImageRemove = YES;
        
        [NSThread sleepForTimeInterval:0.8f];
        if (self.superview) {
            [UIView animateWithDuration:0.4
                             animations:^{
                                 self.launchImageView.alpha = 0.f;
                             } completion:^(BOOL finished) {
                                 [self.launchImageView removeFromSuperview];
                                 _launchImageView = nil;
                             }];
        }
        
    }
}

@end
