//
//  TTTabbarItem.m
//  HongBao
//
//  Created by Ivan on 16/1/21.
//  Copyright © 2016年 ivan. All rights reserved.
//

#import "TTTabbarItem.h"
#import "ShortcutMacro.h"
#import "UIView+TT.h"
#import "ColorMarco.h"
#import "UIButton+TT.h"
#import "UIMacro.h"
#import "FunctionMacro.h"

#define TABBAR_ITEM_SPAN_TOP    6
#define TABBAR_ITEM_SPAN_BOTTOM 3

@interface TTTabbarItem ()

@property (nonatomic, strong) UIImage        *icon;
@property (nonatomic, strong) UIImage        *selectedIcon;
@property (nonatomic, strong) UILabel        *label;
@property (nonatomic, strong) UIImageView    *imageView;
@property (nonatomic, strong) UIColor        *titleColor;
@property (nonatomic, strong) UIColor        *selectedTitleColor;
@property (nonatomic, strong) UIView         *backgroundView;

@end

@implementation TTTabbarItem

- (id)initWithTitle:(NSString *)title titleColor:(UIColor *)titleColor selectedTitleColor:(UIColor *)selectedTitleColor icon:(UIImage *)icon selectedIcon:(UIImage *)selectedIcon
{
    self = [super initWithFrame:CGRectMake(0, 0, 0, 0)];
    if (self) {
        
        self.selected = NO;
        self.icon = icon;
        self.selectedIcon = selectedIcon;
        self.titleColor = titleColor;
        self.selectedTitleColor = selectedTitleColor;
        
        self.label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 0, 12)];
        self.label.backgroundColor = [UIColor clearColor];
        self.label.textColor = self.titleColor;
        self.label.textAlignment = NSTextAlignmentCenter;
        self.label.userInteractionEnabled = NO;
        self.label.text = title;
        self.label.font = FONT(10);
        [self addSubview:self.label];
        
        CGFloat imageWH = 30.f;
        
        if ( IsEmptyString(title)) {
            imageWH = 40.f;
        }
        
        self.imageView = [[UIImageView alloc]initWithFrame:CGRectMake((self.width - icon.size.width) / 2, 5, imageWH, imageWH)];
        
        self.imageView.image = self.icon;
        self.imageView.contentMode = UIViewContentModeCenter;
        [self addSubview:self.imageView];
        
        [self addTarget:self action:@selector(didSelect) forControlEvents:UIControlEventTouchUpInside];
 
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.label.width = self.width;
    self.label.bottom = self.height - 4.f;
    self.imageView.centerX = self.width / 2;
    self.imageView.frame= CGRectOffset(self.imageView.frame, self.imageInset.left, self.imageInset.top);
}

- (void)setTitle:(NSString*)title
{
    self.label.text = title;
}

- (void)setIcon:(UIImage *)image
{
    if (!image) {
        return;
    }
    _icon = image;
    
    if (!self.selected) {
        self.imageView.image = image;
    }
}

- (void)setSelectedIcon:(UIImage *)selectedIcon
{
    if (!selectedIcon) {
        return;
    }
    
    _selectedIcon = selectedIcon;
    
    if (self.selected) {
        self.imageView.image = selectedIcon;
    }
}

#pragma -mark
#pragma -mark action
- (void)didSelect
{
    if ([self.delegate respondsToSelector:@selector(tabBarItemdidSelected:)]) {
        [self.delegate tabBarItemdidSelected:self];
    }
}

- (void)setSelected:(BOOL)selected
{
    if (selected == self.selected) {
        return;
    }
    super.selected = selected;
    
    if (!selected) {
        self.imageView.image = self.icon;
        self.label.textColor = self.titleColor;
    } else {
        self.imageView.image = self.selectedIcon;
        self.label.textColor = self.selectedTitleColor;
    }
}

@end
