//
//  TTAmountView.m
//  HongBao
//
//  Created by Ivan on 16/2/12.
//  Copyright © 2016年 ivan. All rights reserved.
//

#import "TTAmountView.h"
#import "Categories.h"
#import "Macros.h"
#import "UIImage+TT.h"

@interface TTAmountView ()

@property (nonatomic, strong) UIButton *increaseButton;
@property (nonatomic, strong) UIButton *decreaseButton;
@property (nonatomic, strong) UILabel *amountLabel;

@property (nonatomic, strong) UIView *lineView1;
@property (nonatomic, strong) UIView *lineView2;

@end

@implementation TTAmountView

- (instancetype) initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if ( self ) {
        
        self.amount = 1;
        
        self.layer.masksToBounds = YES;
        self.layer.cornerRadius = 2.0f;
        self.layer.borderColor = [Color_Gray209 CGColor];
        self.layer.borderWidth = 1.0f;
        
        [self addSubview:self.increaseButton];
        [self addSubview:self.decreaseButton];
        [self addSubview:self.lineView1];
        [self addSubview:self.lineView2];
        [self addSubview:self.amountLabel];
        
        self.lineView1.left = self.decreaseButton.right;
        self.lineView2.right = self.increaseButton.left;
        
        self.amountLabel.left = self.lineView1.right;
        self.amountLabel.width = self.width - self.increaseButton.width - self.decreaseButton.width - self.lineView1.width - self.lineView2.width;
    }
    
    return self;
}

#pragma mark - Getters And Setters

- (UIButton *)increaseButton {
    
    if ( !_increaseButton ) {
        _increaseButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _increaseButton.frame = CGRectMake(0, 0, 26, self.height);
        [_increaseButton addTarget:self action:@selector(handleIncreaseButton) forControlEvents:UIControlEventTouchUpInside];
        [_increaseButton setImage:[UIImage imageNamed:@"icon_increase" module:ModuleName] forState:UIControlStateNormal];
        _increaseButton.right = self.width;
    }
    
    return _increaseButton;
}

- (UIButton *)decreaseButton {
    
    if ( !_decreaseButton ) {
        _decreaseButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _decreaseButton.frame = CGRectMake(0, 0, 26, self.height);
        [_decreaseButton addTarget:self action:@selector(handleDecreaseButton) forControlEvents:UIControlEventTouchUpInside];
        [_decreaseButton setImage:[UIImage imageNamed:@"icon_decrease" module:ModuleName] forState:UIControlStateNormal];
    }
    
    return _decreaseButton;
}

- (UILabel *)amountLabel {
    
    if ( !_amountLabel ) {
        _amountLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, self.height)];
        _amountLabel.textColor = Color_Gray66;
        _amountLabel.font = FONT(14);
        _amountLabel.textAlignment = NSTextAlignmentCenter;
        _amountLabel.text = [NSString stringWithFormat:@"%ld", (long)self.amount];
    }
    
    return _amountLabel;
}

- (UIView *)lineView1 {
    
    if ( !_lineView1 ) {
        _lineView1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, LINE_WIDTH, self.height)];
        _lineView1.backgroundColor = Color_Gray209;
    }
    
    return _lineView1;
}

- (UIView *)lineView2 {
    
    if ( !_lineView2 ) {
        _lineView2 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, LINE_WIDTH, self.height)];
        _lineView2.backgroundColor = Color_Gray209;
    }
    
    return _lineView2;
}

- (void)setAmount:(NSInteger)amount {
    _amount = amount;
    
    if ( _amount < 1 ) {
        _amount = 1;
    }
    
    self.increaseButton.enabled = YES;
    self.decreaseButton.enabled = YES;
    
    if ( _amount == self.maxAmount && 0 != self.maxAmount ) {
        self.increaseButton.enabled = NO;
    }
    
    if ( _amount == 1 && 0 != self.maxAmount ) {
        self.decreaseButton.enabled = NO;
    }
    
    self.amountLabel.text = [NSString stringWithFormat:@"%ld", (long)_amount];
}

- (void)setMaxAmount:(NSInteger)maxAmount {
    _maxAmount = maxAmount;
    if ( _amount >= maxAmount && 0 != maxAmount) {
        _amount = maxAmount;
        self.increaseButton.enabled = NO;
    }else {
        self.increaseButton.enabled = YES;
    }
    
    self.amountLabel.text = [NSString stringWithFormat:@"%ld", (long)_amount];
}


#pragma mark - Event Response

- (void) handleIncreaseButton {
    
    self.amount++;
    if ( [self.delegate respondsToSelector:@selector(increaseButtonDidTap)]) {
        [self.delegate increaseButtonDidTap];
    }
}

- (void) handleDecreaseButton {

    self.amount--;
    if ( [self.delegate respondsToSelector:@selector(decreaseButtonDidTap)]) {
        [self.delegate decreaseButtonDidTap];
    }
}

@end
