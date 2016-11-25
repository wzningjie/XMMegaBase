//
//  MCCheckButton.h
//  XMMegaBase
//
//  Created by marco on 8/12/16.
//  Copyright © 2016 marco. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MCCheckButton : UIButton

@property (nonnull, nonatomic, strong) UIColor *selectedBackgroundColor;
@property (nonnull, nonatomic, strong) UIColor *selectedTickColor;
@property (nonnull, nonatomic, strong) UIColor *selectedBorderColor;

@property (nonnull, nonatomic, strong) UIColor *normalBackgroundColor;
@property (nonnull, nonatomic, strong) UIColor *normalTickColor;
@property (nonnull, nonatomic, strong) UIColor *normalBorderColor;


// In most case, you just use init to create check button with size (32,32).
// visible elements are always limited to bound with size (20,20).
- (nonnull instancetype)init;

// You use this method, only when you want to enlarge the area to touch inside,
// visible elements are always limited to bound with size (20,20).
- (nonnull instancetype)initWithFrame:(CGRect)frame;

// You should not use buttonWithType:.
- (nonnull instancetype)buttonWithType:(UIButtonType)buttonType NS_UNAVAILABLE;

@end
