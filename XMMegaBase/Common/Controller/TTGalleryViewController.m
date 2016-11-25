//
//  TTGalleryViewController.m
//  HongBao
//
//  Created by Ivan on 16/3/16.
//  Copyright © 2016年 ivan. All rights reserved.
//

#import "TTGalleryViewController.h"
#import "TTSliderView.h"
#import "NSArray+NullCheck.h"
#import "UIView+TT.h"
#import "ColorMarco.h"
#import "UIButton+TT.h"
#import "UIMacro.h"
#import "UIImageView+TT.h"

@interface TTGalleryViewController ()<TTSliderViewDataSource, TTSliderViewDelegate>

@property (nonatomic, strong) TTSliderView *sliderView;
@property (nonatomic, strong) UIButton *backButton;

@end

@implementation TTGalleryViewController

#pragma mark - Life Cycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = Color_Black;
    
    self.view.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    
    [self render];
    
}

#pragma mark - Private Methods

- (void) render {
    
    self.sliderView  = [[TTSliderView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:SliderViewPageControlStyleDot alignment:SliderViewPageControlAlignmentCenter];
    self.sliderView.delegate = self;
    self.sliderView.dataSource = self;
    self.sliderView.autoScroll = NO;
    self.sliderView.wrapEnabled = NO;
    self.sliderView.currentPageColor = Color_White;
    self.sliderView.userInteractionEnabled = YES;
    [self.view addSubview:self.sliderView];
    [self.view sendSubviewToBack:self.sliderView];
    
    [self.sliderView reloadData];
    
    [self.sliderView jumpToItemAtIndex:self.index];
    
    self.backButton = [UIButton backButtonWithTarget:self action:@selector(clickback) forControlEvents:UIControlEventTouchUpInside];
    self.backButton.tintColor = Color_White;
    self.backButton.top = 20;
    [self.view addSubview:self.backButton];
    
}

#pragma mark - TTSliderViewDataSource

- (NSInteger)numberOfItemsInSliderView:(TTSliderView *)sliderView {
    
    if (self.images) {
        return self.images ? self.images.count : 0;
    }else{
        return self.imageDatas ? self.imageDatas.count : 0;
    }
}

- (UIView *)sliderView:(TTSliderView *)sliderView viewForItemAtIndex:(NSInteger)index reusingView:(UIView *)view {
    
    if (self.images) {
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, sliderView.width, sliderView.height)];
        
        [imageView setOnlineImage:[self.images safeObjectAtIndex:index]];
        
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        
        return imageView;
        
    }else if (self.imageDatas) {
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, sliderView.width, sliderView.height)];
        
        [imageView setImage:[self.imageDatas safeObjectAtIndex:index]];
        
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        
        return imageView;
    }
    
    return view;
    
}

@end
