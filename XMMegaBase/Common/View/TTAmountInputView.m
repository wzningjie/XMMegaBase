//
//  TTAmountView.m
//  HongBao
//
//  Created by Ivan on 16/2/12.
//  Copyright © 2016年 ivan. All rights reserved.
//

#import "TTAmountInputView.h"

#import "UIView+TT.h"
#import "UIImage+TT.h"
#import "ColorMarco.h"
#import "UIMacro.h"

@interface TTAmountInputView ()<UITextFieldDelegate>

@property (nonatomic, strong) UIButton *increaseButton;
@property (nonatomic, strong) UIButton *decreaseButton;
@property (nonatomic, strong) UITextField *amountTextField;

@property (nonatomic, strong) UIView *lineView1;
@property (nonatomic, strong) UIView *lineView2;

@end

@implementation TTAmountInputView

- (instancetype) initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if ( self ) {
        
        self.amount = 0;
        self.minAmount = 0;
        self.maxAmount = 200;
        self.autoCorrection = NO;
        
        self.layer.masksToBounds = YES;
        self.layer.cornerRadius = 2.0f;
        self.layer.borderColor = [Color_Gray209 CGColor];
        self.layer.borderWidth = 1.0f;
        
        [self addSubview:self.increaseButton];
        [self addSubview:self.decreaseButton];
        [self addSubview:self.lineView1];
        [self addSubview:self.lineView2];
        [self addSubview:self.amountTextField];
        
        self.lineView1.left = self.decreaseButton.right;
        self.lineView2.right = self.increaseButton.left;
        
        self.amountTextField.left = self.lineView1.right;
        self.amountTextField.width = self.width - self.increaseButton.width - self.decreaseButton.width - self.lineView1.width - self.lineView2.width;
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

- (UITextField *)amountTextField {
    
    if ( !_amountTextField ) {
        _amountTextField = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, 0, self.height)];
        _amountTextField.textColor = Color_Gray66;
        _amountTextField.font = FONT(14);
        _amountTextField.textAlignment = NSTextAlignmentCenter;
        _amountTextField.text = [NSString stringWithFormat:@"%ld", (long)self.amount];
        _amountTextField.delegate = self;
        _amountTextField.keyboardType = UIKeyboardTypeNumberPad;
        [_amountTextField addTarget:self action:@selector(textFieldChanged:) forControlEvents:UIControlEventEditingChanged];
        
    }
    
    return _amountTextField;
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
    
    self.increaseButton.enabled = YES;
    self.decreaseButton.enabled = YES;
    
    if (self.autoCorrection) {
        
        if ( _amount < self.minAmount ) {
            _amount = self.minAmount;
        }
        
        if ( _amount > self.maxAmount ) {
            _amount = self.maxAmount;
        }
    }
    
    if ( _amount >= self.maxAmount ) {
        self.increaseButton.enabled = NO;
    }
    
    if ( _amount <= self.minAmount ) {
        self.decreaseButton.enabled = NO;
    }
    
    self.amountTextField.text = [NSString stringWithFormat:@"%ld", (long)_amount];
}

- (void)setMaxAmount:(NSInteger)maxAmount {
    
    if (maxAmount <= self.minAmount) {
        _maxAmount = self.minAmount;
    }else{
        _maxAmount = maxAmount;
    }
    self.amount = self.amount;
}

- (void)setMinAmount:(NSInteger)minAmount {
    

    _minAmount = minAmount;
    self.amount = self.amount;
}


#pragma mark - Event Response

- (void) handleIncreaseButton {
    
    self.amount++;
    if ( [self.delegate respondsToSelector:@selector(amountInputViewDidIncrease:)]) {

        [self.delegate amountInputViewDidIncrease:self];
    }
}

- (void) handleDecreaseButton {

    self.amount--;
    if ( [self.delegate respondsToSelector:@selector(amountInputViewDidDecrease:)]) {

        [self.delegate amountInputViewDidDecrease:self];
    }
}

- (void)textFieldChanged:(id)sender
{
    self.amount = [self.amountTextField.text integerValue];
    //延迟校验，先存值
    //_amount = [self.amountTextField.text integerValue];
    
//    //检查按钮
//    if ( _amount >= self.maxAmount ) {
//        self.increaseButton.enabled = NO;
//    }else{
//        self.increaseButton.enabled = YES;
//    }
//    
//    if ( _amount <= self.minAmount ) {
//        self.decreaseButton.enabled = NO;
//    }else{
//        self.decreaseButton.enabled = YES;
//    }
    
    if ([self.delegate respondsToSelector:@selector(amountInputViewDidChangeValue:)]) {
        
        [self.delegate amountInputViewDidChangeValue:self];

    }
}

#pragma mark UITextFieldDelegate
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    if ([self.delegate respondsToSelector:@selector(amountInputViewDidBeginEditing:)]) {
        
        [self.delegate amountInputViewDidBeginEditing:self];
        
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    //校验
    self.amount = self.amount;
    if ([self.delegate respondsToSelector:@selector(amountInputViewDidEndEditing:)]) {
        
        [self.delegate amountInputViewDidEndEditing:self];
        
    }
}


@end
